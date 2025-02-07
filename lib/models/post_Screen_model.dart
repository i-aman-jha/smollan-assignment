class PostScreenModel {
  final String username;
  final String profilePic;
  final String image;
  final int likes;
  final String caption;
  final String postDate;
  final String postText;

  PostScreenModel({
    required this.username,
    required this.profilePic,
    required this.image,
    required this.likes,
    required this.caption,
    required this.postDate,
    required this.postText,
  });

  factory PostScreenModel.fromJson(Map<String, dynamic> json) {
    return PostScreenModel(
      username: json['username'],
      profilePic: json['profile_pic'],
      image: json['image'],
      likes: json['likes'],
      caption: json['caption'],
      postDate: json['post_date'],
      postText: json['post_text'],
    );
  }
}
