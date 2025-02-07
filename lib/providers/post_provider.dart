import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smollan_assignment/models/post_Screen_model.dart';
import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  PostScreenModel? _post;

  bool get isLoading => _isLoading;

  String get error => _error;

  PostScreenModel? get post => _post;

  Future<void> fetchPost() async {
    final url = 'https://api.mocklets.com/p6903/getPostAPI';

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _post = PostScreenModel.fromJson(data);
      } else {
        _error = 'Failed to load post: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
