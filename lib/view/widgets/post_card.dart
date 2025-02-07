import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smollan_assignment/view/widgets/CustomIconButton.dart';
import 'package:expandable_text/expandable_text.dart';

class PostCard extends StatefulWidget {
  final String username;
  final int? likes;
  final int? comments;
  final String? likedBy;
  final String caption;
  final String profilePic;
  final String image;

  const PostCard({
    super.key,
    required this.username,
    this.likes,
    this.comments,
    this.likedBy,
    required this.caption,
    required this.profilePic,
    required this.image,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _likesCount;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.likes ?? 0;
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        _likesCount--;
      } else {
        _likesCount++;
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userDetails(),
          _postImage(),
          _postActions(),
          if (widget.likedBy != null) _likes(),
          _caption(),
        ],
      ),
    );
  }

  Widget _userDetails() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePic),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Text(widget.username,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_sharp),
          ),
        ],
      ),
    );
  }

  Widget _postImage() {
    return GestureDetector(
      onDoubleTap: _toggleLike,
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Image.network(
          widget.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _postActions() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CustomIconButton(
            onTap: _toggleLike,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : null,
              size: 28,
            ),
          ),
          const SizedBox(width: 4),
          if (_likesCount != 0) Text(_likesCount.toString()),
          const SizedBox(width: 10),
          CustomIconButton(
            onTap: () {},
            icon: SvgPicture.asset(
              'assets/icons/comment.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
              height: 34,
            ),
          ),
          const SizedBox(width: 4),
          if (widget.comments != null) Text(widget.comments.toString()),
          const SizedBox(width: 10),
          CustomIconButton(
            onTap: () {},
            icon: SvgPicture.asset(
              'assets/icons/share.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
              height: 22,
            ),
          ),
          const Spacer(),
          CustomIconButton(
            onTap: () {},
            icon: const Icon(
              Icons.bookmark_border,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _likes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        spacing: 6,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePic),
            radius: 10,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Liked by ",
                ),
                TextSpan(
                    text: widget.likedBy,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
          ),
          // Text("Liked by ${widget.likedBy}"),
        ],
      ),
    );
  }

  Widget _caption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ExpandableText(
        '${widget.username}  ${widget.caption}',
        expandText: 'more',
        collapseText: 'less',
        collapseOnTextTap: true,
        linkColor: Colors.grey,
        maxLines: 2,
      ),
    );
  }
}
