class Quote {
  final String quote;
  final String author;
  final String category;
  int likes = 0;
  bool isLiked = false;

  Quote({
    required this.quote,
    required this.author,
    required this.category,
  });

  factory Quote.fromMap({required Map data}) => Quote(
        quote: data['quote'],
        author: data['author'],
        category: data['category'],
      );

  Map<String, dynamic> get toMap => {
        'quote': quote,
        'author': author,
        'category': category,
        'likes': likes,
        'isLiked': isLiked,
      };
}
