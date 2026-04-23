import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web is not supported.');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('This platform is not supported.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhA3TzplJWQVEUM7VG-M0yMv1PbOFFzmI',
    appId: '1:773773386970:android:91a1fa8b43219d8b71b1e3',
    messagingSenderId: '773773386970',
    projectId: 'tic-tac-toe-3b69b',
    storageBucket: 'tic-tac-toe-3b69b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6wCTT5xCLcw-GrDWF5GeZUvIkMlnzgl0',
    appId: '1:773773386970:ios:65072af50f9b982471b1e3',
    messagingSenderId: '773773386970',
    projectId: 'tic-tac-toe-3b69b',
    storageBucket: 'tic-tac-toe-3b69b.firebasestorage.app',
    iosBundleId: 'com.example.ticTacToe',
  );
}
