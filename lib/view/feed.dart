import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smollan_assignment/models/post_model.dart';
import 'package:smollan_assignment/models/story.dart';
import 'package:smollan_assignment/providers/feed_provider.dart';
import 'package:smollan_assignment/view/widgets/mystory.dart';
import 'package:smollan_assignment/view/widgets/post_card.dart';
import 'package:smollan_assignment/view/widgets/story.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/logo.svg",
          height: 40,
          colorFilter: ColorFilter.mode(
            isDarkMode ? Colors.white : Colors.black,
            BlendMode.srcIn,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              //todo:handle activity section
            },
            child: Icon(
              Icons.favorite_border,
              size: 30,
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              //todo:handle dm section
            },
            child: SvgPicture.asset(
              'assets/icons/dm.svg',
              height: 28,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Consumer<FeedProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (provider.error.isNotEmpty) {
          return Center(child: Text(provider.error));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              _stories(provider.stories),
              Divider(),
              _posts(provider.posts),
            ],
          ),
        );
      }),
    );
  }

  Widget _stories(List<StoryModel> stories) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        itemCount: stories.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return MyStory();
          }
          final story = stories[index - 1];
          return Story(
            username: story.username,
            image: story.profilePic,
          );
        },
      ),
    );
  }

  Widget _posts(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => PostCard(
        username: posts[index].username,
        likedBy: posts[index].likes,
        caption: posts[index].caption,
        profilePic: posts[index].profilePic,
        image: posts[index].image,
      ),
    );
  }
}
