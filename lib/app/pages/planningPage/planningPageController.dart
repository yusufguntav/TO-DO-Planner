// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/components/routinePage/routinePage.dart';
import 'package:to_do_app/app/pages/planningPage/components/specialListPage/specialListPage.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageService.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageView.dart';
import 'package:to_do_app/core/models/routines.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/utils/utils.dart';

import '../../../core/models/task.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

enum FormKeys {
  editCategory,
  addCategory,
  addSpecialList,
  editSpecialList,
  addRoutine;
}

enum FormFields {
  editCategoryName,
  addCategoryName,
  editCategoryDescription,
  addCategoryDescription,
  addSpecialListName,
  addSpecialListEndDate,
  editSpecialListName,
  editSpecialListEndDate,
  addRoutineName, //TODO Buraya bir göz at
}

enum PlanningPages {
  planningPage,
  specialListPage,
  routinePage;

  int get getPageNumber {
    switch (this) {
      case PlanningPages.planningPage:
        return 0;
      case PlanningPages.specialListPage:
        return 1;
      case PlanningPages.routinePage:
        return 2;
    }
  }
}

class PlanningPageController extends GetxController {
  //Weekday select control
  final List<WeekDay> weekdays = [
    WeekDay.monday,
    WeekDay.tuesday,
    WeekDay.wednesday,
    WeekDay.thursday,
    WeekDay.friday,
    WeekDay.saturday,
    WeekDay.sunday,
  ];

  Map<WeekDay, Rx<bool>> weekdaySelectControl = {
    WeekDay.monday: false.obs,
    WeekDay.tuesday: false.obs,
    WeekDay.wednesday: false.obs,
    WeekDay.thursday: false.obs,
    WeekDay.friday: false.obs,
    WeekDay.saturday: false.obs,
    WeekDay.sunday: false.obs,
    WeekDay.daily: false.obs,
  };
  // Routine
  RxList<RoutineModel> routines = <RoutineModel>[].obs;
  RoutineModel? selectedRoutine;
  // Task
  SpecialListModel? selectedListModel;
  //ScrollController for task list
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool addedNewTask = false;

  //AddTask Field Controller
  final TextEditingController _addTaskinputField = TextEditingController();
  TextEditingController get addTaskinputField => _addTaskinputField;

  //Task List control
  final RxList<TaskModel> _tasks = <TaskModel>[].obs;
  List<TaskModel> get tasks => _tasks;

  //Deleted Tasks
  final RxList<String> _deletedTasks = <String>[].obs;
  List<String> get deletedTasks => _deletedTasks;

  //New Tasks
  final RxList<TaskModel> _newTasks = <TaskModel>[].obs;
  List<TaskModel> get newTasks => _newTasks;

  //Refresh Task
  get refreshTask => _tasks.refresh();

  final Rx<int> _selectedPage = PlanningPages.planningPage.getPageNumber.obs;
  final List _pageViews = [
    const PlanningPageView(),
    const SpecialListPage(),
    const RoutinePage(),
  ];

  Future addTask(String task) async {
    errorHandler(tryMethod: () async {
      TaskModel newTask = TaskModel.fromJson((await _planningService.addTask(task, selectedListModel, selectedRoutine))?.body['task']);
      TaskModel.addTaskForLocale(tasks, TaskModel(id: newTask.id, task: newTask.task, successStatus: SuccessStatus.neutral));
      addedNewTask = true;
      _tasks.refresh();
    });
  }

  updateTasksOrder() async {
    errorHandler(tryMethod: () async {
      List<Map<String, dynamic>> updateTaskOrderList = [];
      for (TaskModel task in tasks) {
        updateTaskOrderList.add(task.toJson());
      }
      await _planningService.updateTaskOrder(updateTaskOrderList, selectedListModel?.id ?? '');
    });
  }

  // Delete task from database
  deleteTasksFromDB() async {
    errorHandler(
      tryMethod: () async {
        if (deletedTasks.isNotEmpty) {
          String tasks = '';
          for (var task in deletedTasks) {
            tasks += '$task,';
          }
          await _planningService.deleteTasks(tasks, () => Get.back());
        }
      },
    );
  }

  //Delete task
  deleteTaskFromLocale(TaskModel task) {
    TaskModel.deleteTaskForLocale(tasks, task);
    _tasks.refresh();
  }

  Future<RequestResponse?> getTasks({
    bool isForRoutine = false,
    bool showLoad = true,
  }) async {
    return await errorHandler(
      tryMethod: () async {
        {
          RequestResponse? requestResponse =
              // = isForRoutine
              // ? await _planningService.getRoutineTasks(selectedRoutine, showLoad)
              await _planningService.getTasks(selectedListModel, showLoad);
          if (requestResponse != null) {
            if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
              return requestResponse;
            }
          }
        }
        return null;
      },
    );
  }

  Future getTasksToVariable({showLoad = true, isForRoutine = false}) async {
    await errorHandler(tryMethod: () async {
      tasks.clear();
      if (await getTasks(showLoad: showLoad, isForRoutine: isForRoutine) != null) {
        dynamic json = jsonDecode((await getTasks(isForRoutine: isForRoutine, showLoad: showLoad))!.body)['tasks'];
        for (var i = 0; i < json.length; i++) {
          tasks.add(TaskModel.fromJson(json[i]));
        }
        _tasks.refresh();
      }
    });
  }

  onListReorder(int oldListIndex, int newListIndex) {
    if (oldListIndex != newListIndex) TaskModel.updateTaskOrderForLocale(tasks, oldListIndex, newListIndex);
    var movedList = tasks.removeAt(oldListIndex);
    tasks.insert(newListIndex, movedList);
    _tasks.refresh();
  }

  changeStatus(TaskModel task) {
    task.successStatus = _getNewStatus(task.successStatus ?? SuccessStatus.neutral);
    _tasks.refresh();
  }

  _getNewStatus(SuccessStatus status) {
    switch (status) {
      case SuccessStatus.neutral:
        return SuccessStatus.successful;
      case SuccessStatus.successful:
        return SuccessStatus.fail;
      case SuccessStatus.fail:
        return SuccessStatus.neutral;
      default:
        return SuccessStatus.neutral;
    }
  }

  // Change page
  Widget getPage() {
    return _pageViews[_selectedPage.value];
  }

  changeSelectedPageIndex(PlanningPages page) {
    _selectedPage.value = page.getPageNumber;
  }

  //Form Keys
  final Map<FormKeys, GlobalKey<FormState>> _formKeys = {
    FormKeys.editCategory: GlobalKey<FormState>(),
    FormKeys.addCategory: GlobalKey<FormState>(),
    FormKeys.addSpecialList: GlobalKey<FormState>(),
    FormKeys.editSpecialList: GlobalKey<FormState>(),
    FormKeys.addRoutine: GlobalKey<FormState>(),
  };
  Map<FormKeys, GlobalKey<FormState>> get formKeys => _formKeys;

  // Form Controllers
  final Map<FormFields, TextEditingController> _formControlers = {
    FormFields.addSpecialListName: TextEditingController(),
    FormFields.editSpecialListName: TextEditingController(),
    FormFields.editCategoryName: TextEditingController(),
    FormFields.editCategoryDescription: TextEditingController(),
    FormFields.editSpecialListEndDate: TextEditingController(),
    FormFields.addCategoryName: TextEditingController(text: 'TestKategori'),
    FormFields.addSpecialListEndDate: TextEditingController(),
    FormFields.addCategoryDescription: TextEditingController(text: 'Description'),
    FormFields.addRoutineName: TextEditingController(),
  };
  Map<FormFields, TextEditingController> get formControlers => _formControlers;

  //Special List control
  final RxList<SpecialListModel> specialLists = <SpecialListModel>[].obs;

  isValidName(String? val) {
    if ((val ?? '').isEmpty) {
      return 'This field can\'t be empty';
    }
  }

  // Network services
  late PlanningPageService _planningService;

  @override
  void onInit() async {
    _planningService = Get.find<PlanningPageService>();
    await getRoutinesToVariable();
    await addSpecialListsToVariable();

    super.onInit();
  }

//Routine Request Functions

  Future getRoutinesToVariable() async {
    dynamic routinesFromDB = await getRoutines();
    if (routinesFromDB != null) {
      specialLists.clear();
      dynamic json = jsonDecode((await routinesFromDB).body);
      for (var i = 0; i < json.length; i++) {
        routines.add(
          RoutineModel(id: json[i]['_id'] ?? '', name: json[i]['name'] ?? ''),
        );
      }
      routines.refresh();
    }
  }

  Future addRoutine(String name, List<int> days) async {
    errorHandler(
      tryMethod: () => _planningService.createRoutine(
        name,
        days,
        () async {
          Get.back();
          //TODO
          // await addSpecialListsToVariable();
        },
      ),
    );
  }

  Future<RequestResponse?> getRoutines() async {
    return errorHandler(tryMethod: () async {
      RequestResponse? requestResponse = await _planningService.getRoutines();
      if (requestResponse != null) {
        if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
          return requestResponse;
        }
      }
      return null;
    });
  }

// Special List request functions
  Future addSpecialList(String name, String endDate) async {
    errorHandler(
      tryMethod: () => _planningService.addSpecialList(
        name,
        endDate,
        () async {
          Get.back();
          await addSpecialListsToVariable();
        },
      ),
    );
  }

  Future<RequestResponse?> getSpecialListReq() async {
    return errorHandler(tryMethod: () async {
      RequestResponse? requestResponse = await _planningService.getSpecialList();
      if (requestResponse != null) {
        if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
          return requestResponse;
        }
      }
      return null;
    });
  }

  Future addSpecialListsToVariable() async {
    dynamic specialListsFromDB = await getSpecialListReq();
    if (specialListsFromDB != null) {
      specialLists.clear();
      dynamic json = jsonDecode((await getSpecialListReq())!.body);
      for (var i = 0; i < json.length; i++) {
        specialLists.add(SpecialListModel(
            id: json[i]['_id'] ?? '',
            name: json[i]['name'] ?? '',
            date: json[i]['date'] != null ? formatDate(DateTime.parse(json[i]['date'])) : null));
      }
      specialLists.refresh();
    }
  }

  Future updateSpecialList(String name, String id, String endDate) async {
    errorHandler(tryMethod: () async {
      await _planningService.updateSpecialList(
        name,
        id,
        endDate,
        () async {
          Get.back();
          await addSpecialListsToVariable();
        },
      );
    });
  }

  Future deleteSpecialList(String id) async {
    errorHandler(tryMethod: () async {
      await _planningService.deleteSpecialList(id, () async {
        Get.back();
        await addSpecialListsToVariable();
      });
    });
  }
}
