class Article {
  String? _title;
  String? _description;
  String? _url;
  String? _imgUrl;

  Article({
    required title,
    required description,
    required url,
    required imgUrl,
  }) {
    _title = title;
    _description = description;
    _url = url;
    _imgUrl = imgUrl;
  }

  String? get title => _title;

  String? get description => _description;

  String? get imgUrl => _imgUrl;

  String? get url => _url;
}
