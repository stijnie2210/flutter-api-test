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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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

  Widget _buildRow(String squadNumber, String name, String position) {
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
      onTap: () => {

      },
    );
  }

  List<Widget> _widgets() {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < players.length; i++) {
      print(players[i]);
      list.add(_buildRow(players[i]['jerseyNumber'].toString(), players[i]['name'], players[i]['position']));
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
        
      }
    )
  );
}
}
