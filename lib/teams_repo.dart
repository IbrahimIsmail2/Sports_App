import 'dart:convert';

import 'package:flutter_application_8/teams_model.dart';
import 'package:http/http.dart' as http;

class TeamsRepo {
  Future<Teams?> getAllTeams({int? leagueId}) async {
    print(leagueId);

    try {
      var response = await http.get(
        Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=95&APIkey=2f862e8b3a38465b85c084175fad9fe046db13260a2b2f49e3d5bd28961ab14c"),
      );
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      if (response.statusCode == 200) {
        Teams teams = Teams.fromJson(jsonResponse);
        return teams;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
