import 'package:flutter/material.dart';
import 'package:piton_task/core/constants/app/app_constants.dart';
import 'package:piton_task/core/constants/enums/locale_keys_enum.dart';
import 'package:piton_task/core/lang/app_translations.dart';
import 'package:piton_task/view/login/view/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'view/home/view/home_view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(const GetTemplateApp());
}

class GetTemplateApp extends StatelessWidget {
  const GetTemplateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation.translationKeys,
      locale: Locale('en', 'US'),
      fallbackLocale: Get.deviceLocale,
      enableLog: true,
      navigatorKey: Get.key,
      navigatorObservers: [GetObserver()],
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.blue[500]),
        ),
        primarySwatch: Colors.blue,
      ),
      home: checkTokenExist(),
    );
  }

  Widget checkTokenExist() {
    final box = GetStorage();
    var token = box.read(PreferencesKeys.TOKEN.toString());
    print(token.toString() + 'sda');
    if (token == null || token == '') {
      return LoginView();
    } else {
      return HomeView();
    }
  }
}
