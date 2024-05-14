import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_midea_flutter/api/noti_api.dart';
import 'package:social_midea_flutter/firebase_options.dart';
import 'package:social_midea_flutter/pages/home_page.dart';
import 'package:social_midea_flutter/pages/main_page.dart';
import 'package:social_midea_flutter/pages/profile_page.dart';
import 'package:social_midea_flutter/pages/users_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform);
  await NotiApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: {
        '/profile_page' : (context) => ProfilePage() ,
        '/users_page' : (context) => const UsersPage(),
        '/home_page' : (context) => const HomePage()
      },
    );
  }
}
