import 'products.dart';

class ProductModel {
  ProductModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : products = (json['products'] as List<dynamic>?)
            ?.map((dynamic e) => Products.fromJson(e as Map<String, dynamic>))
            .toList(),
        total = json['total'] as int?,
        skip = json['skip'] as int?,
        limit = json['limit'] as int?;
  final List<Products>? products;
  final int? total;
  final int? skip;
  final int? limit;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'products': products?.map((Products e) => e.toJson()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit
      };
}
