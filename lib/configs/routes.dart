import 'package:flutter/material.dart';
import 'package:smollan_assignment/view/home.dart';
import 'package:smollan_assignment/view/post_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String postScreen = 'postScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case postScreen:
        return _slideTransitionRoute(const PostScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No routes defined"),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder _slideTransitionRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from right
        const end = Offset.zero; // Move to original position
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
