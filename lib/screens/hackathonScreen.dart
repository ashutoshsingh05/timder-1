import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timder/Utils/timder.dart';
import 'package:timder/models/hackathon.dart';
import 'package:timder/screens/teampage.dart';

class HackathonScreen extends StatefulWidget {
  @override
  _HackathonScreenState createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  List<Hackathon> hackathons;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("hackathons").getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            hackathons = List<Hackathon>(snapshot.data.documents.length);
            // print(snapshot.data.documents);
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              hackathons[i] = Hackathon.fromJSON(snapshot.data.documents[i]);
            }

            return Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blue[900],
                  Colors.indigo,
                  Colors.deepPurple,
                  Colors.purple[900]
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children: cardList(
                        hackathons: hackathons,
                      ),
                    ),
                  ),
                ));
          }
        }
      },
    );
  }

  List<Widget> cardList({@required List<Hackathon> hackathons}) {
    List<Widget> cards = List<Widget>(hackathons.length);
    for (int i = 0; i < hackathons.length; i++) {
      cards[i] = cardBuilder(hackathon: hackathons[i]);
    }
    return cards;
  }

  Widget cardBuilder({@required Hackathon hackathon}) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                child: Image.network(hackathon.imageUrl),
                borderRadius: BorderRadius.circular(20),
              ),
              Text(
                "${hackathon.name}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 5),
              Text(
                "${hackathon.desc}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          height: 200,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return TeamPage(
                  hackathon: hackathon,
                  currentUser: Timder.currentUser,
                );
              },
            ),
          );
        },
        splashColor: Theme.of(context).accentColor,
      ),
    );
  }
}
