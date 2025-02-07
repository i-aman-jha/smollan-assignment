class Bio {
  final String designation;
  final String description;
  final String website;

  Bio({
    required this.designation,
    required this.description,
    required this.website,
  });

  factory Bio.fromJson(Map<String, dynamic> json) {
    return Bio(
      designation: json['designation'],
      description: json['description'],
      website: json['website'],
    );
  }
}

class Highlight {
  final String title;
  final String cover;

  Highlight({
    required this.title,
    required this.cover,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) {
    return Highlight(
      title: json['title'],
      cover: json['cover'],
    );
  }
}

class GalleryItem {
  final String image;

  GalleryItem({required this.image});

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      image: json['image'],
    );
  }
}

class Profile {
  final String username;
  final String profilePic;
  final int posts;
  final int followers;
  final int following;
  final Bio bio;
  final List<Highlight> highlights;
  final List<GalleryItem> gallery;

  Profile({
    required this.username,
    required this.profilePic,
    required this.posts,
    required this.followers,
    required this.following,
    required this.bio,
    required this.highlights,
    required this.gallery,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      profilePic: json['profile_pic'],
      posts: json['posts'],
      followers: json['followers'],
      following: json['following'],
      bio: Bio.fromJson(json['bio']),
      highlights: (json['highlights'] as List)
          .map((e) => Highlight.fromJson(e))
          .toList(),
      gallery: (json['gallery'] as List)
          .map((e) => GalleryItem.fromJson(e))
          .toList(),
    );
  }
}
