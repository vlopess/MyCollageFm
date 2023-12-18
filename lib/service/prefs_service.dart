import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

  static save(String userName) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('Username', userName);

  }

  static getUsername() async {
    var prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString('Username');
    return userName;
  }

  static remove() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('Username');

  }
}