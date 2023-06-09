class Article {
  String? url;
  String? title;
  String? author;
  String? content;
  String? urlToImage;
  late Source source;
  String? description;
  DateTime? publishedAt;

  Article({
    this.url,
    this.title,
    this.author,
    this.content,
    this.urlToImage,
    this.description,
    this.publishedAt,
    required this.source,
  });

  Article.fromJson(Map<String, dynamic> j) {
    url = j['link'];
    title = j['title'];
    content = j['content'];
    urlToImage = j['image_url'];
    description = j['description'];
    author = j['creator']?.first ?? '';
    publishedAt = DateTime.parse(j['pubDate']);
    source = Source(id: j['source_id'], name: '');
  }

  factory Article.defaultArticle() => Article(
    url: '',
    title: '',
    author: '',
    content: '',
    urlToImage: '',
    description: '',
    publishedAt: DateTime.now(),
    source: Source(id: 'default', name: 'Default')
  );
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> j) {
    id = j['id'];
    name = j['name'];
  }
}
