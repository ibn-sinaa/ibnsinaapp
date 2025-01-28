class PageModel {
  final int id;
  final String name;
  final String content;

  PageModel({
    required this.id,
    required this.name,
    required this.content,
  });

  factory PageModel.fromMap(Map<String, dynamic> map) {
    return PageModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      content: map['content'] ?? '',
    );
  }
}
