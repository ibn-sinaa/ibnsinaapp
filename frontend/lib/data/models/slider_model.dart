class SliderModel {
  final int id;
  final String name;
  final String image;

  SliderModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
