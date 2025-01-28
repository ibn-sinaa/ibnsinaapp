class ImageModel {
  final List<String> images;
  final bool isFile;
  final int index;

  ImageModel({
    required this.images,
    this.isFile = false,
    this.index = 0,
  });
}
