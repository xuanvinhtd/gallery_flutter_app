class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({this.id, this.userId, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  static List<Post> dummys() {
    return [
      Post(id: 1, userId: 1, title: 'Title 1', body: 'Body 1'),
      Post(id: 2, userId: 2, title: 'Title 2', body: 'Body 2'),
      Post(id: 3, userId: 3, title: 'Title 3', body: 'Body 3'),
      Post(id: 4, userId: 4, title: 'Title 4', body: 'Body 4'),
      Post(id: 5, userId: 5, title: 'Title 5', body: 'Body 5'),
      Post(id: 6, userId: 6, title: 'Title 6', body: 'Body 6'),
    ];
  }
}
