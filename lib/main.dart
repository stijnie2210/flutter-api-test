import 'package:flutter/material.dart';

import 'package:apiapp/model/competition_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Flutter API test'),
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
              return getListWidgets(snapshot.data.players);
            } else if(snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          }
        )
      )
    );
  }

  Widget getListWidgets(List strings) {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < strings.length; i++) {
      list.add(new Text(strings[i]['name']));
    }
    return new Row(children: list);
  }
}
