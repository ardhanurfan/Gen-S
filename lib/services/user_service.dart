import 'dart:convert';

import 'package:music_player/models/user_model.dart';
import 'package:music_player/services/url_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> setTokenPreference(String token) async {
    final pref = await SharedPreferences.getInstance();
    await clearTokenPreference();
    pref.setString('token', token);
  }

  Future<String?> getTokenPreference() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> clearTokenPreference() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token')) {
      pref.clear();
    }
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    var url = UrlService().api('register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'username': username,
      'email': email,
      'password': password,
      'name': confirmPassword,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['data']['error']);
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = UrlService().api('login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user =
          UserModel.fromJson(data['user'], 'Bearer ${data['acess_token']}');
      await setTokenPreference(user.token);
      return user;
    } else {
      throw Exception(jsonDecode(response.body)['data']['error']);
    }
  }

  Future<bool> logout({required String token}) async {
    var url = UrlService().api('logout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      await clearTokenPreference();
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['data']['error']);
    }
  }

  Future<UserModel> getUser({required String token}) async {
    var url = UrlService().api('user');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data, token);
      return user;
    } else {
      throw Exception("Gagal Get User");
    }
  }

  Future<bool> forgotPassword({
    required String email,
  }) async {
    var url = UrlService().api('forgot-password');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['data']['error']);
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required int token,
  }) async {
    var url = UrlService().api('forgot-password');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'token': token,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['data']['error']);
    }
  }
}
