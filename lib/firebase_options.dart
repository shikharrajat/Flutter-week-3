// TODO Implement this library.
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
    apiKey: 'AIzaSyC3h6ZbHtQAjYwJgEzbsnMr1IZENKB2dTA',
    appId: '1:965601402706:android:df417475c7434cf769248b',
    messagingSenderId: '965601402706',
    projectId: 'fir-9dc6a',
    storageBucket: 'fir-9dc6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrQBTKz4UeSgk34yjfb7TwrFoH8EGLdts',
    appId: '1:965601402706:ios:f661938bbeef72d569248b',
    messagingSenderId: '965601402706',
    projectId: 'fir-9dc6a',
    storageBucket: 'fir-9dc6a.appspot.com',
    iosClientId: '965601402706-jmjk9ff9vaqojjsbbroer4fran801hrs.apps.googleusercontent.com',
    iosBundleId: 'com.flutterweek3.moviesApp',
  );
}