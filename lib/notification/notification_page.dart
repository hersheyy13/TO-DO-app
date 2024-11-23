import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(235, 36, 105, 62),
        title: Text("Notifications"),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text("Mark All As Read"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildNotificationItem(
            "Divya ",
            "Good work! Keep it going",
            "21 mins ago",
          ),
          _buildNotificationItem(
            "Divya liked your profile:",
            "",
            "23 mins ago",
          ),
          _buildNotificationItem(
            "Guillaume commented ",
            "I like the angle you took on this",
            "50 mins ago",
          ),
          SizedBox(height: 10),
          Divider(),
          _buildNotificationItem(
            "Anupam :",
            "Overthinking and its dangerous effects",
            "21 mins ago",
          ),
          _buildNotificationItem(
            "Alissa followed you",
            "",
            "23 mins ago",
          ),
          _buildNotificationItem(
            "Ontario ",
            "Great consistency!",
            "",
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String content, String timestamp) {
    return ListTile(
      leading: Icon(Icons.notifications,color: const Color.fromARGB(235, 36, 105, 62),),
      title: Text(title),
      subtitle: Text(content),
      trailing: Text(timestamp),
    );
  }
}