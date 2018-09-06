import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

final String url = "http://api.football-data.org/v1/teams/678/players";

Future<Competition> fetchCompetition() async {
  final response = 
    await http.get(url);

  if(response.statusCode == 200) {
    Map decoded = json.decode(response.body);
    return Competition.fromJson(decoded);
  } else {
    throw Exception('Failed to load competition');
  }
}


class Competition {
  final int playerCount;
  final List players;

  Competition({this.playerCount, this.players});

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      playerCount: json['count'],
      players: json['players']);
  }
}