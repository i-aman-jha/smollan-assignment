import 'package:flutter/material.dart';
import 'package:smollan_assignment/models/story.dart';

class Story extends StatelessWidget {
  final String username;
  final String image;

  const Story({
    super.key,
    required this.username,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.orange, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.black : Colors.white,
              border: Border.all(
                  color: isDarkMode ? Colors.black : Colors.white, width: 4),
            ),
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          username,
          overflow: TextOverflow.ellipsis,
        ),
        // Text("aman_jha.a"),
      ],
    );
  }
}
