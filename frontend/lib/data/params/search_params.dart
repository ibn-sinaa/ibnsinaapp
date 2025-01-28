class SearchParams {
  final String? query;
  final int? id;
  final int page;

  SearchParams({
    this.query,
    this.id,
    required this.page,
  });

  Map<String, String> toMap() {
    Map<String, String> idMap = {};
    if (id != null) {
      idMap = {
        'category_id': id.toString(),
      };
    }
    return {
      ...{
        'title': query ?? '',
        'page': page.toString(),
      },
      ...idMap,
    };
  }
}
