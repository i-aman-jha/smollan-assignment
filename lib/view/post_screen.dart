import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smollan_assignment/providers/post_provider.dart';
import 'package:smollan_assignment/view/widgets/post_card.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.error.isNotEmpty) {
          return Center(child: Text(provider.error));
        }
        final post = provider.post!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            title: Column(
              children: [
                Text(
                  post.username,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text("Posts"),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  //todo:handle follow
                },
                child: Text("Follow"),
              ),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostCard(
                  username: post.username,
                  likes: post.likes,
                  comments: 0,
                  caption: post.caption,
                  profilePic: post.profilePic,
                  image: post.image,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    provider.post!.postDate,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
