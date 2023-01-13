import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:piton_task/view/home/model/categories.dart';
import 'package:piton_task/view/home/model/home_model.dart';
import 'package:piton_task/view/home/model/product.dart';
import 'package:piton_task/view/home/model/product_response.dart';
import 'package:piton_task/view/home/service/home_service.dart';
import 'package:get/get.dart';

import '../model/home_model.dart';

class HomeViewModel extends GetxController {
  final IHomeService homeService;
  HomeViewModel(this.homeService);
  // @override
  // void onInit() {
  //   super.onInit();
  //   getCategories();
  // }

  var counter = 0.obs;
  var isLoading = false.obs;
  var home = HomeModel().obs;
  var categories = <Categories>[].obs;

  void increaseCounter() => counter++;

  void changeLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> getCategories() async {
    changeLoading();

    final response = await homeService.fetchCategories();
    //this response handle algo can be better than
    if (response != null) {
      home.value = response;
      categories.value = home.value.category!;
      inspect(this);
      Get.snackbar(
        "Success",
        'You have items !',
      );
    } else {
      Get.snackbar('Error', 'Some errors happened OR There is no item !');
    }

    changeLoading();
  }
}
