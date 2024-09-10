abstract class ApiUrl {
  static String urlBase = 'https://ws.audioscrobbler.com/2.0/?';
  
  static String buildUrl(String path, String apiKey){
    return '$urlBase$path&api_key=$apiKey&format=json';
  } 
  
}

abstract class Method {
  
  static const String _trackgetinfo = 'method=track.getinfo';
  static String getinfoTrack(String artist, String track) => '$_trackgetinfo&artist=$artist&track=$track';

  static const String _usergetinfo = 'method=user.getinfo';
  static String getinfoUser(String userName) => '$_usergetinfo&user=$userName';

  static const String _usergetlovedtracks = 'method=user.getlovedtracks';
  static String getlovedtracksUser(String userName) => '$_usergetlovedtracks&user=$userName&limit=10';

  static const String _usergetrecenttracks = 'method=user.getrecenttracks';
  static String getrecenttracksUser(String userName) => '$_usergetrecenttracks&user=$userName&limit=15';

  static const String _usergettoptracks = 'method=user.gettoptracks';
  static String gettoptracksUser(String userName, String period, int limit) => '$_usergettoptracks&user=$userName&limit=$limit&period=$period';

  static const String _usergettopartists = 'method=user.gettopartists';
  static String gettopartistsUser(String userName, String period, int limit) => '$_usergettopartists&user=$userName&limit=$limit&period=$period';

  static const String _usergettopalbums = 'method=user.gettopalbums';
  static String gettopalbumsUser(String userName, String period, int limit) => '$_usergettopalbums&user=$userName&limit=$limit&period=$period';  

  static const String _artistgettopalbums = 'method=artist.gettopalbums';
  static String gettopalbumsArtist(String artistName) => '$_artistgettopalbums&artist=$artistName';

}

