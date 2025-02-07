import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smollan_assignment/configs/routes.dart';
import 'package:smollan_assignment/models/profile_models.dart';
import 'package:smollan_assignment/providers/profile_Service.dart';
import 'package:smollan_assignment/view/post_screen.dart';
import 'package:smollan_assignment/view/widgets/CustomIconButton.dart';
import 'package:smollan_assignment/view/widgets/story.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.error.isNotEmpty) {
          return Center(child: Text(provider.error));
        }
        // if (provider.profile != null) {
        final profile = provider.profile!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, AppRoutes.home);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            automaticallyImplyLeading: false,
            title: Text(
              profile.username,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: [
              CustomIconButton(
                onTap: () {},
                icon: Icon(Icons.more_horiz_sharp),
              ),
              SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _profileDetails(profile),
                _link(profile.bio.website),
                _buttons(),
                _highlights(profile.highlights),
                _tabSection(profile),
              ],
            ),
          ),
        );
        // }
      },
    );
  }

  Widget _profileDetails(Profile profile) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Followers,Following and profile immage
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  profile.profilePic,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.username,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    spacing: 10,
                    children: [
                      _details("Posts", "${profile.posts}"),
                      _details("followers", "${profile.followers}"),
                      _details("following", "${profile.following}"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          //name
          Text(
            profile.bio.designation,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            profile.bio.description,
          ),
        ],
      ),
    );
  }

  Widget _details(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _link(String website) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            Icons.link,
            color: Colors.blue,
          ),
          Text(
            website,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        spacing: 4,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Follow"),
            ),
          ),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: Text("Message"),
            ),
          ),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: Text("Contact"),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_add_outlined,
              size: 18,
            ),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlights(List<Highlight> highlights) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 105,
        child: ListView.builder(
          itemCount: highlights.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Story(
              username: highlights[index].title,
              image: highlights[index].cover,
            );
          },
        ),
      ),
    );
  }

  Widget _postsGridView(List<GalleryItem> gallery) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: gallery.length,
      // Example post count
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.pushNamed(context, AppRoutes.postScreen);
            }
          },
          child: Image.network(
            gallery[index].image,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _reelsView() {
    return Center(child: Text("Reels Section"));
  }

  Widget _taggedView() {
    return Center(child: Text("Tagged Section"));
  }

  Widget _tabSection(Profile profile) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            indicatorColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            labelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)), // Posts Grid
              Tab(icon: Icon(Icons.video_collection)), // Reels
              Tab(icon: Icon(Icons.person_pin)), // Tagged
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _postsGridView(profile.gallery),
                _reelsView(),
                _taggedView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
