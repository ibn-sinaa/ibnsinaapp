class PaginateModel {
  final int total;
  final int lastPage;
  final int perPage;
  final int currentPage;

  PaginateModel({
    required this.total,
    required this.lastPage,
    required this.perPage,
    required this.currentPage,
  });

  factory PaginateModel.fromMap(Map<String, dynamic> map) {
    return PaginateModel(
      total: map['total'],
      lastPage: map['lastPage'],
      perPage: map['perPage'],
      currentPage: map['currentPage'],
    );
  }
}
