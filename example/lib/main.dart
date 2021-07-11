import 'package:flutter/material.dart';
import 'package:notifications/notifications.dart';

void main() {
  runApp(LocalNotificationApp());
}

class LocalNotificationApp extends StatelessWidget {
  const LocalNotificationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notifications",
      home: HomePage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final Notifications notifications = Notifications();

  void showNotification() async {
    try {
      await notifications.showNotification(ProxyNotification(
          title: "Test Notification",
          contentText: "New Test Notification from Method Channel"));
    } on NotificationException catch (e) {
      debugPrint("Notification Exception ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text("Push the button below to Test notification"),
            ),
            ElevatedButton(
              onPressed: () {
                showNotification();
              },
              child: Text("Send Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
