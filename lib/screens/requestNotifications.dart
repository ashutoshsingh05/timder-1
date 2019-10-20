import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timder/Utils/timder.dart';
import 'package:timder/Utils/timderScaffold.dart';
import 'package:timder/models/participant.dart';

class RequestNotification extends StatefulWidget {
  @override
  _RequestNotificationState createState() => _RequestNotificationState();
}

class _RequestNotificationState extends State<RequestNotification> {
  @override
  Widget build(BuildContext context) {
    return TimderScaffold(
      title: "Matches",
      showNotificationIcon: false,
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("participants")
              .where("rightSwipes",
                  arrayContains: Timder.prefs.getString(Timder.emailPref))
              .getDocuments(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                print(snapshot.data.documents.first.data["email"]);
                List<Participant> matches =
                    List<Participant>(snapshot.data.documents.length);
                if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text("Check back later to find your matches 😁"),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        title: Text(
                          snapshot.data.documents[i].data["displayName"],
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        isThreeLine: true,
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Bio : " +
                                    snapshot.data.documents[i].data["bio"],
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                                "Github : " +
                                    snapshot
                                        .data.documents[i].data["githubLink"],
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                                "Linkedin : " +
                                    snapshot
                                        .data.documents[i].data["linkedinLink"],
                                style: TextStyle(color: Colors.white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 3,
                                ),
                                snapshot.data.documents[i].data["backend"]
                                    ? Text("Backend",
                                        style: TextStyle(color: Colors.white))
                                    : Text(""),
                                SizedBox(
                                  width: 3,
                                ),
                                snapshot.data.documents[i].data["design"]
                                    ? Text("design",
                                        style: TextStyle(color: Colors.white))
                                    : Text(""),
                                SizedBox(
                                  width: 3,
                                ),
                                snapshot.data.documents[i].data["frontend"]
                                    ? Text("frontend",
                                        style: TextStyle(color: Colors.white))
                                    : Text(""),
                                SizedBox(
                                  width: 3,
                                ),
                                snapshot.data.documents[i].data["mobile"]
                                    ? Text("mobile",
                                        style: TextStyle(color: Colors.white))
                                    : Text(""),
                                SizedBox(
                                  width: 3,
                                ),
                                snapshot.data.documents[i].data["blockchain"]
                                    ? Text("blockchain",
                                        style: TextStyle(color: Colors.white))
                                    : Text(""),
                                SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                          ],
                        ));
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
