import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',
      ),
      NotificationChannel(
        channelKey: 'Scheduled_channel',
        channelName: 'Scheduled Notification',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: '',
        soundSource: 'resource://raw/res_custom_notification',
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
