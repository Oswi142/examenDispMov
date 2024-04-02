class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  int? rating;

  Post({required this.id, required this.userId, required this.title, required this.body, this.rating});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      rating: null,
    );
  }
}