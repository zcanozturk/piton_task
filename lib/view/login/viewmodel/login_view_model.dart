import 'package:flutter/material.dart';
import 'package:piton_task/core/constants/enums/get_storage_enum.dart';
import 'package:piton_task/core/constants/enums/locale_keys_enum.dart';
import 'package:piton_task/view/home/view/home_view.dart';
import 'package:piton_task/view/login/model/login_model.dart';
import 'package:piton_task/view/login/service/login_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as storage;

class LoginViewModel extends GetxController {
  final ILoginService loginService;
  LoginViewModel(this.loginService);

  final box = storage.GetStorage();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isChecked = false.obs;

  var isLoading = false.obs;

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
  

  Future<void> sendLoginToAPI() async {
    changeLoading();
    final response = await loginService.sendLoginRequest(LoginModel(
        email: usernameController.text, password: passwordController.text));
    print("***********");
    print(response);
    if (response != null) {
      if (response.action_login!.token != '') {
        box.write(
            PreferencesKeys.TOKEN.toString(), response.action_login!.token);
        Get.to(HomeView());
      } else {
        Get.snackbar("ERROR",
            response.action_login!.message ?? "There are some errors happened",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3));
      }
    } else {
      Get.snackbar('HATA', 'Tekrar kontrol edip deneyiniz!',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    }
    changeLoading();
  }
}
