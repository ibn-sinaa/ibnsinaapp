class IntroModel {
  final int id;
  final String image;
  final String description;

  IntroModel({
    required this.id,
    required this.image,
    required this.description,
  });

  factory IntroModel.fromMap(Map<String, dynamic> map) {
    return IntroModel(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
