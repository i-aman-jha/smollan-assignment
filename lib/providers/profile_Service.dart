import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/profile_models.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  Profile? _profile;

  bool get isLoading => _isLoading;

  String get error => _error;

  Profile? get profile => _profile;

  Future<void> fetchProfile() async {
    final url = 'https://api.mocklets.com/p6903/getProfileAPI';

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _profile = Profile.fromJson(data);
      } else {
        _error = 'Failed to load profile: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
