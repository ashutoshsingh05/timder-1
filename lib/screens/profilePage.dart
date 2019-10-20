import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> cards = new List<Widget>();
  List<Widget> arrayCardBuilder() {
    for (int i = 0; i < 4; i++) {
      cards[i] = cardBuilder("");
    }
    return cards;
  }

  Widget chipBuilder(String speciality) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ChoiceChip(
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$speciality",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        selected: true,
        padding: const EdgeInsets.all(2.0),
      ),
    );
  }

  List<Widget> studentInfo(String institute, String stream, String year) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Institute Name: ",
              softWrap: true,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              "$institute ",
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Graduation Year:",
              softWrap: true,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              "$year ",
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Stream:",
              softWrap: true,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              "$stream ",
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> professionalInfo(
      String company, String role, String experience) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Company Name:",
              softWrap: true,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              "$company",
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Experience:",
              softWrap: true,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              "$experience ",
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Role: \n$role",
              softWrap: true,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              "$role ",
              softWrap: true,
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    ];
  }

  Widget cardBuilder(String skill) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                child: Image.asset("assets/$skill.png"),
                borderRadius: BorderRadius.circular(20),
              ),
              Text(
                skill,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        onTap: () {},
        splashColor: Theme.of(context).accentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Pushkar Patel",
              softWrap: true,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                cardBuilder("angular"),
                cardBuilder("cpp"),
                cardBuilder("firebase"),
                cardBuilder("flutter"),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                chipBuilder("Front-End"),
                chipBuilder("Back-End"),
                chipBuilder("Designer"),
                chipBuilder("Mobile"),
                chipBuilder("Block Chain"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Gender, Age :",
                  softWrap: true,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "M, 19",
                  softWrap: true,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "T-shirt Size:",
                  softWrap: true,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "M",
                  softWrap: true,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: studentInfo("IIIT Vadodara", "Computer Science", "2022"),
          ),
        ],
      ),
    ));
  }
}
