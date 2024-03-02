class Products {
  Products({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString() as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        price = json['price'].toString() as String?,
        discountPercentage = json['discountPercentage'].toString() as String?,
        rating = json['rating'].toString() as String?,
        stock = json['stock'].toString() as String?,
        brand = json['brand'] as String?,
        category = json['category'] as String?,
        thumbnail = json['thumbnail'] as String?,
        images = (json['images'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList();
  final String? id;
  final String? title;
  final String? description;
  final String? price;
  final String? discountPercentage;
  final String? rating;
  final String? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images
      };
}
