// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTaskService.dart';
import 'package:to_do_app/core/models/category.dart';

import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/services/secure_storage.dart';
import '../../../core/variables/colorTable.dart';
import '../../../core/variables/enums.dart';
import '../../../core/variables/standartMeasurementUnits.dart';
import '../../../core/widgets/texts/customText.dart';

enum AddCategoryFields {
  name,
}

class AllTaskController extends GetxController {
  //Category control
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  // Form Key
  final _addCategoryformKey = GlobalKey<FormState>();
  GlobalKey<FormState> get getAddCategoryFormKey => _addCategoryformKey;

  // Category Controller
  final Map<AddCategoryFields, TextEditingController> _addCategoryControllerList = {
    AddCategoryFields.name: TextEditingController(text: 'TestKategori'),
  };
  Map<AddCategoryFields, TextEditingController> get getAddCategoryControllers => _addCategoryControllerList;

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

  Future addCategory(String name) async {
    //TODO Hata kontrolü konulacak
    await _allTaskService.addCategory(name, await SecureStorage().readSecureData('token'), () async {
      await addCategoryToCategories();
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: StandartMeasurementUnits.highRadius,
        backgroundColor: ColorTable.getPositiveButtonColor.withOpacity(.9),
        maxWidth: Get.width * .8,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.symmetric(vertical: StandartMeasurementUnits.highPadding),
        messageText: CustomText(
          'Category created',
          textColor: Colors.white,
          centerText: true,
        ),
      ));
    });
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

  Future addCategoryToCategories() async {
    categories.clear();
    dynamic json = jsonDecode((await getCategoryReq())!.body);
    for (var i = 0; i < json.length; i++) {
      categories.add(CategoryModel(json[i]['name']));
    }
    categories.refresh();
  }
}
