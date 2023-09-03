// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPage.dart';
import 'package:to_do_app/core/models/category.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/widgets/dialogs/customSnackbar.dart';

import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/services/secure_storage.dart';
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
  late PlanningPageService _allTaskService;

  @override
  void onInit() async {
    _allTaskService = Get.find<PlanningPageService>();
    await addCategoryToVariable();
    await addSpecialListsToVariable();
    super.onInit();
  }

// Special List request functions
  Future addSpecialList(String name) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.addSpecialList(
      name,
      await SecureStorage().readSecureData('token'),
      () async {
        Get.back();
        await addSpecialListsToVariable();
        Get.showSnackbar(
            CustomSnackbar(snackbarText: 'Special List created', backgrundColor: MainPages.planning.getPageColor.withOpacity(.9)).getSnackbar());
      },
    );
  }

  Future<RequestResponse?> getSpecialListReq() async {
    //TODO Hata kontrolü konulacak
    RequestResponse? requestResponse = await _allTaskService.getSpecialList(await SecureStorage().readSecureData('token'));
    if (requestResponse != null) {
      if (StatusCodes.successful.checkStatusCode(int.parse(requestResponse.status))) {
        return requestResponse;
      }
    }
    return null;
  }

  Future addSpecialListsToVariable() async {
    specialLists.clear();
    dynamic json = jsonDecode((await getSpecialListReq())!.body);
    for (var i = 0; i < json.length; i++) {
      specialLists.add(SpecialListModel(json[i]['_id'], json[i]['name']));
    }
    specialLists.refresh();
  }

  Future updateSpecialList(String name, String id) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.updateSpecialList(
      name,
      id,
      await SecureStorage().readSecureData('token'),
      () async {
        Get.back();
        await addSpecialListsToVariable();
        Get.showSnackbar(
            CustomSnackbar(snackbarText: 'Special List updated', backgrundColor: MainPages.planning.getPageColor.withOpacity(.9)).getSnackbar());
      },
    );
  }

  Future deleteSpecialList(String id) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.deleteSpecialList(await SecureStorage().readSecureData('token'), id, () async {
      Get.back();
      await addSpecialListsToVariable();
      Get.showSnackbar(
          CustomSnackbar(snackbarText: 'Special List deleted', backgrundColor: MainPages.planning.getPageColor.withOpacity(.9)).getSnackbar());
    });
  }

  // Category request functions TODO Kategorilendirme nasıldı vs code içerisinde (dropdown lı olan)
  Future addCategory(String name, String description) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.addCategory(
      name,
      description,
      await SecureStorage().readSecureData('token'),
      () async {
        Get.back();
        await addCategoryToVariable();
        Get.showSnackbar(
            CustomSnackbar(snackbarText: 'Category created', backgrundColor: MainPages.planning.getPageColor.withOpacity(.9)).getSnackbar());
      },
    );
  }

  Future updateCategory(String name, String id, String description) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.updateCategory(
      name,
      id,
      description,
      await SecureStorage().readSecureData('token'),
      () async {
        Get.back();
        await addCategoryToVariable();
        Get.showSnackbar(
            CustomSnackbar(snackbarText: 'Category updated', backgrundColor: MainPages.planning.getPageColor.withOpacity(.9)).getSnackbar());
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

  Future deleteCategory(String id) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.deleteCategory(await SecureStorage().readSecureData('token'), id, () async {
      Get.back();
      await addCategoryToVariable();
      Get.showSnackbar(
          CustomSnackbar(snackbarText: 'Category deleted', backgrundColor: MainPages.planning.getPageColor.withOpacity(.9)).getSnackbar());
    });
  }

  Future addCategoryToVariable() async {
    categories.clear();
    dynamic json = jsonDecode((await getCategoryReq())!.body);
    for (var i = 0; i < json.length; i++) {
      categories.add(CategoryModel(json[i]['_id'], json[i]['name'], json[i]['description']));
    }
    categories.refresh();
  }
}
