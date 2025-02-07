class Post {
  final String username;
  final String profilePic;
  final String image;
  final String likes;
  final String caption;

  Post(
      {required this.username,
      required this.profilePic,
      required this.image,
      required this.likes,
      required this.caption});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      profilePic: json['profile_pic'],
      image: json['image'],
      likes: json['likes'],
      caption: json['caption'],
    );
  }
}
