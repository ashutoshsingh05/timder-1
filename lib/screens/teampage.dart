import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timder/Utils/timder.dart';
import 'package:timder/Utils/timderScaffold.dart';
import 'package:timder/models/hackathon.dart';
import 'package:timder/models/participant.dart';
import 'package:timder/screens/timderSwipe.dart';

class TeamPage extends StatefulWidget {
  final Hackathon hackathon;
  final Participant currentUser;

  TeamPage({
    @required this.hackathon,
    @required this.currentUser,
  });

  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController joiningCodeController = TextEditingController();
    TextEditingController createTeamController = TextEditingController();
    return TimderScaffold(
        showNotificationIcon: true,
        title: "Team Details",
        body: SingleChildScrollView(
          child: Container(
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
                      onPressed: () {
                        return showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Enter joining code"),
                                content: TextFormField(
                                  controller: joiningCodeController,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Join a Team"),
                                    onPressed: () {
                                      return showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Enter joining code"),
                                            content: TextFormField(
                                              controller: joiningCodeController,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Join"),
                                                onPressed: () async {
                                                  bool isJoinable =
                                                      await joinable(
                                                          joiningCodeController
                                                              .text);
                                                  if (isJoinable) {
                                                    await Firestore.instance
                                                        .collection(
                                                            "participants")
                                                        .document(Timder.prefs
                                                            .getString(Timder
                                                                .emailPref))
                                                        .updateData({
                                                      "isIndividual": false,
                                                    }).then((onValue) async {
                                                      await Firestore.instance
                                                          .collection(
                                                              "hackathons")
                                                          .document(widget
                                                              .hackathon.name)
                                                          .collection("teams")
                                                          .document(
                                                              joiningCodeController
                                                                  .text)
                                                          .updateData({
                                                        "teamMembers":
                                                            FieldValue
                                                                .arrayUnion([
                                                          Timder.prefs
                                                              .getString(Timder
                                                                  .emailPref)
                                                        ]),
                                                      });
                                                    });
                                                    print("Joined");
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Joined team successfully",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIos: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                    joiningCodeController
                                                        .clear();
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    joiningCodeController
                                                        .clear();
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "You cannot join this team",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIos: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
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
                    onPressed: () {
                      return showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Enter Team name"),
                            content: TextFormField(
                              controller: createTeamController,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Create"),
                                onPressed: () async {
                                  bool isCreateable;
                                  isCreateable = await createable(
                                      createTeamController.text);
                                  if (isCreateable) {
                                    print("createable");
                                    print(widget.hackathon.name);
                                    await Firestore.instance
                                        .collection("hackathons")
                                        .document(widget.hackathon.name)
                                        .collection("teams")
                                        .document(createTeamController.text)
                                        .setData({
                                      "joiningCode": createTeamController.text,
                                      "teamName": createTeamController.text,
                                      "teamMembers": FieldValue.arrayUnion([
                                        Timder.prefs.getString(Timder.emailPref)
                                      ]),
                                    });
                                  } else {
                                    print("Cannot create");
                                    Fluttertoast.showToast(
                                      msg: "You cannot create this team",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    createTeamController.clear();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> joinable(String teamName) async {
    var snapshot = await Firestore.instance
        .collection("hackathons")
        .document(widget.hackathon.name)
        .collection("teams")
        .document(teamName)
        .get();
    if (snapshot.data["teamMembers"].length < widget.hackathon.maxTeamSize) {
      print("Team is not full");
      return true;
    }
    return false;
  }

  Future<bool> createable(String teamName) async {
    var snapshot = await Firestore.instance
        .collection("hackathons")
        .document(widget.hackathon.name)
        .collection("teams")
        .getDocuments();
    for (int i = 0; i < snapshot.documents.length; i++) {
      if (snapshot.documents[i].data["teamName"] == teamName) {
        return false;
      }
    }
    return true;
  }
}
