import 'package:firebase_messaging/firebase_messaging.dart';

class NotiApi{

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();

    //fetch the fcm token from this device
    final fcmToken = await _firebaseMessaging.getToken();

    print('Fcm noti : $fcmToken');
  }
}