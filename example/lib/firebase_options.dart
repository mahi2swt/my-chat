// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZXs-oDulKZ9c65kz3HsYupNfH6mM1ZMw',
    appId: '1:1035883453080:web:0ac736ea0be3e21f2c4eed',
    messagingSenderId: '1035883453080',
    projectId: 'fl-chat-142db',
    authDomain: 'fl-chat-142db.firebaseapp.com',
    storageBucket: 'fl-chat-142db.appspot.com',
    measurementId: 'G-FF7V10XG20',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBZJ8yQ101ggTMZiYMqLa9SNYSTZpB7fU',
    appId: '1:1035883453080:android:2f05d90cdda363f62c4eed',
    messagingSenderId: '1035883453080',
    projectId: 'fl-chat-142db',
    storageBucket: 'fl-chat-142db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDldK6tFonqQI9Ar3wDr8ABxRbt4uoaL44',
    appId: '1:1035883453080:ios:b421774ce44a3a362c4eed',
    messagingSenderId: '1035883453080',
    projectId: 'fl-chat-142db',
    storageBucket: 'fl-chat-142db.appspot.com',
    androidClientId: '1035883453080-64n2k3pd9ldqb132qs2pdpeh5d5oq4qp.apps.googleusercontent.com',
    iosClientId: '1035883453080-qt1qn291id90fskt384igp7nb763ekks.apps.googleusercontent.com',
    iosBundleId: 'com.example.example',
  );
}
