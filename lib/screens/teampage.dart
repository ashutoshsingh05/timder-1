import 'package:flutter/material.dart';
import 'package:timder/Utils/timderScaffold.dart';
import 'package:timder/models/hackathon.dart';
import 'package:timder/screens/timderSwipe.dart';

class TeamPage extends StatefulWidget {
  final Hackathon hackathon;

  TeamPage({@required this.hackathon});

  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return TimderScaffold(
      showNotificationIcon: true,
      title: "Team Details",
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue[900],
          Colors.indigo,
          Colors.deepPurple,
          Colors.purple[900]
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Join a Team",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                onPressed: () {},
              ),
              FlatButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Look for \nTeammates",
                    style: TextStyle(fontSize: 40.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return TimderSwipe();
                      },
                    ),
                  );
                },
              ),
              FlatButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Create your \nown Team",
                    style: TextStyle(fontSize: 40.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
