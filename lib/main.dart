import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smollan_assignment/configs/routes.dart';
import 'package:smollan_assignment/configs/theme.dart';
import 'package:smollan_assignment/providers/feed_provider.dart';
import 'package:smollan_assignment/providers/post_provider.dart';
import 'package:smollan_assignment/providers/profile_Service.dart';
import 'package:smollan_assignment/providers/theme_provider.dart';
import 'package:smollan_assignment/view/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()..fetchPost()),
        ChangeNotifierProvider(create: (_) => FeedProvider()..fetchFeedData()),
        ChangeNotifierProvider(
            create: (_) => ProfileProvider()..fetchProfile()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: themeProvider.themeMode,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
