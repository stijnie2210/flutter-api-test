import 'package:flutter/material.dart';

import 'package:apiapp/model/competition_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ajax Players',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Ajax Players'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List players;
  String selectedPlayerName;
  String selectedPlayerSquadNumber;
  String selectedPlayerPosition;
  String selectedPlayerNationality;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.refresh), onPressed: _doUpdate),
        ],
      ),
      body: Center(
        child: FutureBuilder<Competition>(
          future: fetchCompetition(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              this.players = snapshot.data.players;
              return _buildListView();
            } else if(snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          }
        )
      )
    );
  }

  void _doUpdate() {
    setState(() {
        fetchCompetition();
    });
  }

  Widget _buildRow(String squadNumber, String name, String position, String nationality) {
    return ListTile(
      leading: new CircleAvatar(
        child: new Text(squadNumber)
      ),
      title: new Text(
        name
      ),
      subtitle: new Text(
        position
      ),
      onTap: () {
        this.selectedPlayerName = name;
        this.selectedPlayerPosition = position;
        this.selectedPlayerSquadNumber = squadNumber;
        this.selectedPlayerNationality = nationality;
        _detailPage();
      }
    );
  }

  List<Widget> _widgets() {
    List<Widget> list = new List<Widget>();

    for(var player in players) {
      print(player);
      list.add(_buildRow(player['jerseyNumber'].toString(), player['name'], player['position'], player['nationality']));
    }

    return list;
  }

  Widget _buildListView() {
    return new ListView(
      children: _widgets(),
    );
  }

  void _detailPage() {
  Navigator.of(context).push(
    new MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(selectedPlayerName),
          ),
          body: new Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [new CircleAvatar(
                child: new Text(
                  selectedPlayerSquadNumber,
                  style: TextStyle(fontSize: 30.0),
                  softWrap: false,
                ),
                maxRadius: 56.0,
              ),
              new Text(
                '\n Position: $selectedPlayerPosition\n \n Nationality: $selectedPlayerNationality',
                style: TextStyle(fontSize: 36.0),
                textAlign: TextAlign.center,
              )
              ],
            ),
          )
        );
      }
    )
  );
}
}
