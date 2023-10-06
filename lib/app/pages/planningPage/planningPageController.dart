// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPage.dart';
import 'package:to_do_app/core/models/category.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/utils/utils.dart';

import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

enum FormFields {
  editCategoryName,
  addCategoryName,
  editCategoryDescription,
  addCategoryDescription,
  addSpecialListName,
  editSpecialListName,
}

class PlanningPageController extends GetxController {
  // TODO Controller gibi yapı kur
  // Edit Page Form Key
  final _editCategoryFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get editCategoryFormKey => _editCategoryFormKey;

  // Add Category Form Key
  final _addCategoryFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get addCategoryFormKey => _addCategoryFormKey;

  // Add Special List Form Key
  final _addSpecialListFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get addSpecialListFormKey => _addSpecialListFormKey;

  // Edit Special List Form Key
  final _editSpecialListFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get editSpecialListFormKey => _editSpecialListFormKey;

  // Form Controllers
  final Map<FormFields, TextEditingController> _formControlers = {
    FormFields.addSpecialListName: TextEditingController(),
    FormFields.editSpecialListName: TextEditingController(),
    FormFields.editCategoryName: TextEditingController(),
    FormFields.editCategoryDescription: TextEditingController(),
    FormFields.addCategoryName: TextEditingController(text: 'TestKategori'),
    FormFields.addCategoryDescription: TextEditingController(text: 'Description'),
  };
  Map<FormFields, TextEditingController> get formControlers => _formControlers;

  //Category control
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  //Special List control
  final RxList<SpecialListModel> specialLists = <SpecialListModel>[].obs;

  isValidName(String? val) {
    if ((val ?? '').isEmpty) {
      return 'Name field can\'t be empty';
    }
  }

  // Network services
  late PlanningPageService _planningService;

  @override
  void onInit() async {
    _planningService = Get.find<PlanningPageService>();
    await addCategoryToVariable();
    await addSpecialListsToVariable();
    super.onInit();
  }

// Special List request functions
  Future addSpecialList(String name) async {
    errorHandler(
      tryMethod: () => _planningService.addSpecialList(
        name,
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
    if (await getSpecialListReq() != null) {
      specialLists.clear();
      dynamic json = jsonDecode((await getSpecialListReq())!.body);
      for (var i = 0; i < json.length; i++) {
        specialLists.add(SpecialListModel(id: json[i]['_id'], name: json[i]['name']));
      }
      specialLists.refresh();
    }
  }

  Future updateSpecialList(String name, String id) async {
    errorHandler(tryMethod: () async {
      await _planningService.updateSpecialList(
        name,
        id,
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

  Future addCategory(String name, String description) async {
    errorHandler(tryMethod: () async {
      await _planningService.addCategory(
        name,
        description,
        () async {
          Get.back();
          await addCategoryToVariable();
        },
      );
    });
  }

  Future updateCategory(String name, String id, String description) async {
    errorHandler(tryMethod: () async {
      await _planningService.updateCategory(
        name,
        id,
        description,
        () async {
          Get.back();
          await addCategoryToVariable();
        },
      );
    });
  }

  Future<RequestResponse?> getCategoryReq() async {
    return errorHandler(tryMethod: () async {
      RequestResponse? requestResponse = await _planningService.getCategory();
      if (requestResponse != null) {
        if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
          return requestResponse;
        }
      }
      return null;
    });
  }

  Future deleteCategory(String id) async {
    errorHandler(tryMethod: () async {
      await _planningService.deleteCategory(id, () async {
        Get.back();
        await addCategoryToVariable();
      });
    });
  }

  Future addCategoryToVariable() async {
    if (await getCategoryReq() != null) {
      categories.clear();
      dynamic json = jsonDecode((await getCategoryReq())!.body);
      for (var i = 0; i < json.length; i++) {
        categories.add(CategoryModel(id: json[i]['_id'], name: json[i]['name'], description: json[i]['description']));
      }
      categories.refresh();
    }
  }
}
