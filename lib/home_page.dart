import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_notification/notifications.dart';
import 'package:flutter_awesome_notification/plant_stats_page.dart';
import 'package:flutter_awesome_notification/utilities.dart';
import 'package:flutter_awesome_notification/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permitir notificações'),
            content: const Text('Our app woul like to send you notification'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications().requestPermissionToSendNotifications().then(
                      (_) => Navigator.pop(context),
                    ),
                child: const Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });

    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notification Created on ${notification.channelKey}'),
        ),
      );
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PlantStatsPage()),
        (route) => route.isFirst,
      );
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlantStatsPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.insert_chart_outlined_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PlantImage(),
            const SizedBox(height: 25),
            HomePageButtons(
              onPressedOne: createPlantFoodNotification,
              onPressedTwo: () async {
                NotificationWeekAndTime? pickedSchedule = await pickSchedule(context);
                if (pickedSchedule != null) {
                  createWaterReminderNotification(pickedSchedule);
                }
              },
              onPressedThree: cancelScheduledNotifications,
            )
          ],
        ),
      ),
    );
  }
}
