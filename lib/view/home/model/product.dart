import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String? author;
  String? cover;
  String? createdAt;
  String? description;
  int? id;
  String? name;
  double? price;
  int? sales;
  String? slug;
  LikesAggregate? likesAggregate;

  Product(
      {this.author,
      this.cover,
      this.createdAt,
      this.description,
      this.id,
      this.name,
      this.price,
      this.sales,
      this.slug,
      this.likesAggregate});

  @override
  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$ProductToJson(this);
  }
}
class LikesAggregate {
  Aggregate? aggregate;

  LikesAggregate({this.aggregate});

  LikesAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}