import 'package:flutter/cupertino.dart';
import 'package:music_player/models/user_model.dart';
import 'package:music_player/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  String _errorMessage = '';
  late UserModel _user;
  late String _tokenReset;

  String get errorMessage => _errorMessage;
  UserModel get user => _user;
  String get tokenReset => _tokenReset;

  set setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      return await UserService().register(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _user = await UserService().login(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> logout({required String token}) async {
    try {
      return await UserService().logout(token: token);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> delete({required String token}) async {
    try {
      return await UserService().delete(token: token);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      _tokenReset = await UserService().forgotPassword(email: email);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required int token,
  }) async {
    try {
      return await UserService().resetPassword(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        token: token,
      );
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> getUser({required String token}) async {
    try {
      UserModel user = await UserService().getUser(token: token);
      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }
}
