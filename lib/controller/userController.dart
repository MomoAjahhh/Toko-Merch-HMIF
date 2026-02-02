import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_merch_hmif/database/user_helper.dart';
import 'package:toko_merch_hmif/models/user.dart';

class UserController {
  final dbHelper = UserDataBaseHelper.instance;

  Future<String> registerUser(User user) async {

    String message = 'Registration Failed';
    final userMap = {
      'nama': user.nama,
      'email': user.email,
      'password': user.password,
    };
    int rowAfected = await dbHelper.insertUser(userMap);
     
    if (rowAfected > 0) {
      message = 'Registration Successful';
    }
    return message;
  }

  Future<String> LoginUser(User user) async { 
    String message = "Login Failed";
    final existingUser = await dbHelper.queryUserByEmail(user.email);

    if (existingUser != null) {
      if (existingUser['password'] == user.password) {
        message = "Login Successful";
        final pref = await SharedPreferences.getInstance();
        await pref.setString('nama', existingUser['nama']);
        await pref.setString('email', existingUser['email']);

      }else { 
        message = "Incorrect Password";
      }
    }else {
      message = "User not found";
    }
    return message;
  }
  Future<bool> checkSession() async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString('email');
    if (email != null) {
      return true;
    } 
    return false;
  }

}