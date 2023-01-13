import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'categories.g.dart';

@JsonSerializable()
class Categories {
  int? id;
  String? name;
  String? created_at;
  Categories({this.id, this.created_at, this.name});

  @override
  factory Categories.fromJson(Map<String, dynamic> json) {
    return _$CategoriesFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$CategoriesToJson(this);
  }
}
