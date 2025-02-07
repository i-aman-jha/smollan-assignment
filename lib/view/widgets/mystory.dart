import 'package:flutter/material.dart';

class MyStory extends StatelessWidget {
  const MyStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.white),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                'https://img.etimg.com/thumb/width-1200,height-1200,imgsize-1008929,resizemode-75,msid-108694064/magazines/panache/tommy-shelby-is-back-cillian-murphy-confirmed-to-reprise-iconic-role-in-peaky-blinders-movie.jpg',
              ),
            ),
            Positioned(
              bottom: 2,
              right: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      width: 2),
                ),
                child: Icon(
                  Icons.add,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        Text("Your story"),
      ],
    );
    ;
  }
}
