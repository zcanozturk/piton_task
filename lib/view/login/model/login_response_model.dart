import 'package:piton_task/view/login/model/login.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends INetworkModel<LoginResponseModel> {
  Login? action_login;

  LoginResponseModel({this.action_login});

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$LoginResponseModelToJson(this);
  }
}
