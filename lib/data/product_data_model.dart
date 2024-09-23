class ProductDataModel {
  final String? title;
  final String? description;
  final String? image;
  final num? price;

  ProductDataModel({
    this.title,
    this.description,
    this.image,
    this.price,
  });
  // toMap == toJson
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'price': price,
    };
  }

// fromMap == fromJson
  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      title: map['title'],
      description: map['description'],
      image: map['image'],
      price: map['price'],
    );
  }
}
