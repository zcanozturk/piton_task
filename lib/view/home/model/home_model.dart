import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import 'categories.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel extends INetworkModel<HomeModel> {
  List<Categories>? category;

  HomeModel({this.category});

  @override
  HomeModel fromJson(Map<String, dynamic> json) {
    return _$HomeModelFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$HomeModelToJson(this);
  }
}
