
import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class Login {
  
  String? message;
  String? token;

  Login(
      {this.message,this.token});
 
 factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);

}