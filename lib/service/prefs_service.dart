import 'package:my_collage_fm/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

  static save(User user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('Username', user.name!);
    prefs.setString('UserImage', user.image!);
    prefs.setString('UserUrl', user.url!);

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
    await prefs.remove('Username');
    await prefs.remove('UserImage');
    await prefs.remove('UserUrl');

  }
}