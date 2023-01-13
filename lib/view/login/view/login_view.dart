import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piton_task/core/components/drawer/get_drawer.dart';
//import 'package:piton_task/core/components/appbar/app_bar.dart';
import 'package:piton_task/core/constants/app/app_constants.dart';
import 'package:piton_task/core/network/vexana_manager.dart';
import 'package:piton_task/view/login/service/login_service.dart';
import 'package:piton_task/view/login/viewmodel/login_view_model.dart';

import '../../../../core/extensions/context_extension.dart';
import 'package:get/get.dart';

import '../../../core/components/input_deco.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ctrl = Get.put(
      LoginViewModel(LoginService(VexanaManager.instance.networkManager)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: buildObservableBody(context),
    );
  }

  buildObservableBody(BuildContext context) {
    return Obx(
        () => ctrl.isLoading.value ? buildCenterLoading() : buildBody(context));
  }

  buildCenterLoading() => Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          backgroundColor: Colors.grey,
        ),
      );

  buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHeadImage(),
        Padding(
          padding: context.paddingNormalHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'welcome'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color.fromRGBO(9, 9, 55, 0.6)),
              ),
              Text(loginaccountext)
            ],
          ),
        ),
        getFormFields(context),
        
        LoginButton(context),
      ],
    );
  }

  String get loginaccountext => 'Login to your account';

  getHeadImage() {
    return Container(
        alignment: Alignment.center,
        width: Get.width,
        height: Get.height * 0.1,
        child: Image.asset('assets/images/im_logostroke.png'));
  }

  getFormFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: context.paddingNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Email '),
                ),
                TextFormField(
                  controller: ctrl.usernameController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  decoration: myInputDec('john@gmail.com'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'emptyInputMessage'.tr;
                    }
                    print(value);
                    // TODO ctrl.emailInput = value;
                    return null;
                  },
                ),
              ],
            ),
          ),
          passwordField(context),
          Padding(
            padding: context.paddingNormalHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.05,
                  child: Row(children: [
                    Obx(() => Checkbox(
                          value: ctrl.isChecked.value,
                          onChanged: ((value) {
                            ctrl.isChecked.value = value!;
                          }),
                          activeColor: Color(0xFF6251DD),
                        )),
                    Text('Remember Me',
                        style: TextStyle(color: Color(0xFF6251DD)))
                  ]),
                ),
                TextButton(
                    onPressed: null,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Color(0xFF6251DD)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding passwordField(BuildContext context) {
    return Padding(
      padding: context.paddingNormalHorizontal,
      child: TextFormField(
        controller: ctrl.passwordController,
        cursorColor: Colors.black,
        decoration: myInputDec('.....'),
        obscureText: true,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'emptyInput';
          }
          // TODO ctrl.passwordInput = value;
          return null;
        },
      ),
    );
  }

  Padding LoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Color(0xFFEF6B4A),
          padding: context.paddingLow,
          minimumSize: Size(Get.width, 60),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            Get.snackbar('Giriş Yapılıyor', 'Lütfen bekleyiniz',
                colorText: Colors.white,
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 3),
                snackPosition: SnackPosition.TOP);
            ctrl.sendLoginToAPI();
          }
        },
        child: Obx(() => ctrl.isLoading.value
            ? Icon(Icons.watch_later_outlined)
            : Text('loginTitle'.tr)),
      ),
    );
  }


}
