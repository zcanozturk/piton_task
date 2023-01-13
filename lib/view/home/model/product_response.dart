import 'package:piton_task/view/home/model/product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import 'categories.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse extends INetworkModel<ProductResponse> {
  List<Product>? product;

  ProductResponse({this.product});

  @override
  ProductResponse fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$ProductResponseToJson(this);
  }
}
