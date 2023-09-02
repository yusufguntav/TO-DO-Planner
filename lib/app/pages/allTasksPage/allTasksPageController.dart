// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTaskService.dart';
import 'package:to_do_app/core/models/category.dart';
import 'package:to_do_app/core/widgets/dialogs/customSnackbar.dart';

import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/services/secure_storage.dart';
import '../../../core/variables/enums.dart';

enum FormCategoryFields {
  name,
  description,
}

class AllTaskController extends GetxController {
  // Form Key
  final _getEditCategoryformKey = GlobalKey<FormState>();
  GlobalKey<FormState> get getEditCategoryFormKey => _getEditCategoryformKey;

  // Validation control
  // isValidPassword(String? val) {
  //   if ((val ?? '').length < 6) {
  //     return 'Password must be longer than 6 characters';
  //   }
  // }

  // Edit Name and Description Controller
  final Map<FormCategoryFields, TextEditingController> _editCategoryControllers = {
    FormCategoryFields.name: TextEditingController(),
    FormCategoryFields.description: TextEditingController(),
  };
  Map<FormCategoryFields, TextEditingController> get getEditCategoryControllers => _editCategoryControllers;

  //Category control
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  // Form Key
  final _addCategoryformKey = GlobalKey<FormState>();
  GlobalKey<FormState> get getAddCategoryFormKey => _addCategoryformKey;

  // Category Controller
  final Map<FormCategoryFields, TextEditingController> _addCategoryControllerList = {
    FormCategoryFields.name: TextEditingController(text: 'TestKategori'),
    FormCategoryFields.description: TextEditingController(text: 'Description'),
  };
  Map<FormCategoryFields, TextEditingController> get getAddCategoryControllers => _addCategoryControllerList;

  isValidCategoryName(String? val) {
    if ((val ?? '').isEmpty) {
      return 'Invalid category name';
    }
  }

  // Network services
  late AllTaskService _allTaskService;

  @override
  void onInit() {
    _allTaskService = Get.find<AllTaskService>();
    addCategoryToCategories();
    super.onInit();
  }

  Future addCategory(String name, String description) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.addCategory(
      name,
      description,
      await SecureStorage().readSecureData('token'),
      () async {
        Get.back();
        await addCategoryToCategories();
        Get.showSnackbar(
            CustomSnackbar(snackbarText: 'Category created', backgrundColor: MainPages.allTasks.getPageColor.withOpacity(.9)).getSnackbar());
      },
    );
  }

  Future updateCategory(String name, String oldName, String description) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.updateCategory(
      name,
      oldName,
      description,
      await SecureStorage().readSecureData('token'),
      () async {
        Get.back();
        await addCategoryToCategories();
        Get.showSnackbar(
            CustomSnackbar(snackbarText: 'Category updated', backgrundColor: MainPages.allTasks.getPageColor.withOpacity(.9)).getSnackbar());
      },
    );
  }

  Future<RequestResponse?> getCategoryReq() async {
    //TODO Hata kontrolü konulacak
    RequestResponse? requestResponse = await _allTaskService.getCategory(await SecureStorage().readSecureData('token'));
    if (requestResponse != null) {
      if (StatusCodes.successful.checkStatusCode(int.parse(requestResponse.status))) {
        return requestResponse;
      }
    }
    return null;
  }

  Future deleteCategory(String name) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.deleteCategory(await SecureStorage().readSecureData('token'), name, () async {
      Get.back();
      await addCategoryToCategories();
      Get.showSnackbar(
          CustomSnackbar(snackbarText: 'Category deleted', backgrundColor: MainPages.allTasks.getPageColor.withOpacity(.9)).getSnackbar());
    });
  }

  Future addCategoryToCategories() async {
    categories.clear();
    dynamic json = jsonDecode((await getCategoryReq())!.body);
    for (var i = 0; i < json.length; i++) {
      categories.add(CategoryModel(json[i]['name'], json[i]['description']));
    }
    categories.refresh();
  }
}
