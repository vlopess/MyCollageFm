import 'package:my_collage_fm/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

  static saveFirstAccess() async {
    var prefs = await SharedPreferences.getInstance();
    bool? isFirstAccess = bool.tryParse(prefs.getString("isFirstAccess").toString());
    if(isFirstAccess == null) prefs.setString('isFirstAccess', "true");
  }

  static isFirstAccess() async {
    var prefs = await SharedPreferences.getInstance();
    bool? isFirstAccess = bool.tryParse(prefs.getString("isFirstAccess").toString());
    return isFirstAccess == null ? false : true; 
  }


  static save(User user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('Username', user.name!.toLowerCase());
    prefs.setString('UserImage', user.image!);
    prefs.setString('UserUrl', user.url!);

  }

  static saveValue(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  
  static getValue(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static getUsername() async {
    var prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString('Username');
    return userName;
  }

  static getUserImage() async {
    var prefs = await SharedPreferences.getInstance();
    var userImage = prefs.getString('UserImage');
    return userImage;
  }

  static getUserUrl() async {
    var prefs = await SharedPreferences.getInstance();
    var userUrl = prefs.getString('UserUrl');
    return userUrl;
  }

  static remove() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  
}