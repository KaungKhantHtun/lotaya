import 'package:firebase_core/firebase_core.dart';

const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAbNWl5QPWRH6bxHy37OK0GZbVtbpXQ4YM",
    authDomain: "service-33a01.firebaseapp.com",
    projectId: "service-33a01",
    storageBucket: "service-33a01.appspot.com",
    messagingSenderId: "1095771549322",
    appId: "1:1095771549322:web:9dc19e4dbfc1ededd68773",
    measurementId: "G-PXDNG703GN");

class FirebaseService {
  Future<void> init() async {
    try {
      await Firebase.initializeApp(options: web);
    } catch (e) {}
  }
}
