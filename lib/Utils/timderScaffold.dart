import 'package:flutter/material.dart';
import 'package:timder/screens/requestNotifications.dart';

class TimderScaffold extends StatelessWidget {
  final Widget body;
  final Widget floatingButton;
  final Widget bottomWidget;
  final String title;
  final bool showNotificationIcon;

  TimderScaffold({
    @required this.body,
    @required this.title,
    @required this.showNotificationIcon,
    this.floatingButton,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: showNotificationIcon
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return RequestNotification();
                        },
                      ),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue[900],
            Colors.indigo,
            Colors.deepPurple,
            Colors.purple[900]
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: this.body),
      floatingActionButton: this.floatingButton,
      bottomNavigationBar: bottomWidget,
    );
  }
}
