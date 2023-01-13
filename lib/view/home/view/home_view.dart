import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piton_task/core/constants/app/app_constants.dart';
import 'package:piton_task/core/network/vexana_manager.dart';
import 'package:piton_task/view/home/model/categories.dart';
import 'package:piton_task/view/home/model/home_model.dart';
import 'package:piton_task/view/home/service/home_service.dart';
import 'package:piton_task/view/home/viewmodel/home_view_model.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final ctrl = Get.put(
      HomeViewModel(HomeService(VexanaManager.instance.networkManager)));


  @override
  Widget build(BuildContext context) {
     ctrl.getCategories();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Catalog',
            style: TextStyle(color: Colors.black),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: Image.asset('assets/images/im_logostroke.png'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: getObservableBody(context),
    );
  }

  getObservableBody(BuildContext context) {
    return Obx(
        () => ctrl.isLoading.value ? buildCenterLoading() : buildListBuilder());
  }

  buildCenterLoading() => Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          backgroundColor: Colors.grey,
        ),
      );

  buildListBuilder() {
    var refreshKey = GlobalKey<RefreshIndicatorState>();
    return Container(
        // if there is another thing above or below list yo should make this expanded to fit .
        alignment: Alignment.center,
        height: Get.height,
        child: ctrl.categories.isEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  await ctrl.getCategories();
                },
                child: Stack(
                  children: <Widget>[
                    ListView(),
                    Center(
                      child: Text(
                        'no title',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                key: refreshKey,
                onRefresh: () async {
                  await ctrl.getCategories();
                },
                child: Scrollbar(
                  interactive: true,
                  isAlwaysShown: true,
                  radius: Radius.circular(50),
                  thickness: Get.width * 0.02,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: ctrl.categories.length,
                      itemBuilder: (context, index) {
                        var model = ctrl.categories[index];
                        return getCardListWidget(context, model);
                      }),
                ),
              ));
  }

  Widget getCardListWidget(BuildContext context, Categories model) {
    return Card(
      child: Column(
        children: [
          Container(child: Text(model.name!)),
        ],
      ),
    );
  }

  // getCategoriesList(BuildContext context, Categories model) {
  //   return Container(
  //     height: Get.height,
  //     child: ListView.builder(
  //       itemCount: ctrl.categories.length,
  //       itemBuilder: ((context, index) {
  //         var modela = model;
  //         print(model.name);
  //         return Container(
  //             height: Get.height * 0.2,
  //             child: Text(
  //               modela.name!,
  //               style: TextStyle(color: Colors.blueAccent),
  //             ));
  //       }),
  //     ),
  //   );
  // }
}
