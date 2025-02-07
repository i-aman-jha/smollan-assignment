import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smollan_assignment/models/post_model.dart';
import 'package:smollan_assignment/models/story.dart';

class FeedProvider with ChangeNotifier {
  List<StoryModel> _stories = [];
  List<Post> _posts = [];
  bool _isLoading = true;
  String _error = '';

  List<StoryModel> get stories => _stories;

  List<Post> get posts => _posts;

  bool get isLoading => _isLoading;

  String get error => _error;

  Future<void> fetchFeedData() async {
    final url = 'https://api.mocklets.com/p6903/getFeedAPI';
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _stories = (data['stories'] as List)
            .map((story) => StoryModel.fromJson(story))
            .toList();
        _posts =
            (data['posts'] as List).map((post) => Post.fromJson(post)).toList();
      } else {
        _error = 'Failed to load data';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
