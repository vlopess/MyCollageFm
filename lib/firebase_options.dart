// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSMe69MyID0EW-jMmWjQ1PzZuraO33438',
    appId: '1:832503260217:android:d54e912f465811f8e6d9e8',
    messagingSenderId: '832503260217',
    projectId: 'mymusictaste-8fb0d',
    storageBucket: 'mymusictaste-8fb0d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCgSLa_0xYkQUSJTO875kFfaCQYN0XfMQ',
    appId: '1:832503260217:ios:abe5b3cc8ceb4bace6d9e8',
    messagingSenderId: '832503260217',
    projectId: 'mymusictaste-8fb0d',
    storageBucket: 'mymusictaste-8fb0d.appspot.com',
    androidClientId: '832503260217-lgaf55fdpbol7n3u2u9qhr6muvjochhj.apps.googleusercontent.com',
    iosClientId: '832503260217-7c9n78jgv4q3flv37tqlsbmjpe2hj9ji.apps.googleusercontent.com',
    iosBundleId: 'com.example.mymusictaste',
  );

}