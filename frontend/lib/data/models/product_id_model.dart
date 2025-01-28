class ProductIdModel {
  final int id;
  final String title;
  final String image;

  ProductIdModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory ProductIdModel.fromMap(Map<String, dynamic> map) {
    return ProductIdModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
