import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  final FirebaseMessaging _fm = FirebaseMessaging();
  Future initalise()async
  {
    _fm.configure(
      // when app is in forground
      onMessage: (Map<String, dynamic> message) async
      {
        print ('onMessage: $message');
      },
        // when app has been closed but opened from notification
        onLaunch: (Map<String, dynamic> message) async
    {
      print ('onMessage: $message');
    },
        // when app is in background and is opened from push notification
    onResume: (Map<String, dynamic> message) async
    {
      print ('onMessage: $message');
    }
    );
  }
}