class StoryModel {
  final String username;
  final String profilePic;

  StoryModel({required this.username, required this.profilePic});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      username: json['username'],
      profilePic: json['profile_pic'],
    );
  }
}
