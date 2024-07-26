

class Teams {
  int? success;
  List<TeamResult>? result;
  Teams({this.success, this.result});
  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
    success: json['success'] as int?,
    result: (json['result'] as List<dynamic>?)
        ?.map((e) => TeamResult.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  Map<String, dynamic> toJson() => {
    'success': success,
    'result': result?.map((e) => e.toJson()).toList(),
  };
}

class TeamResult {
  int? teamKey;
  String? teamName;
  String? teamLogo;
  List<Player>? players;
  List<Coach>? coaches;
  TeamResult({
    this.teamKey,
    this.teamName,
    this.teamLogo,
    this.players,
    this.coaches,
  });

  factory TeamResult.fromJson(Map<String, dynamic> json) => TeamResult(
    teamKey: json['team_key'] as int,
    teamName: json['team_name'] as String?,
    teamLogo: json['team_logo'] as String?,
    players: (json['players'] as List<dynamic>?)
        ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
        .toList(),
    coaches: (json['coaches'] as List<dynamic>?)
        ?.map((e) => Coach.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'team_key': teamKey,
    'team_name': teamName,
    'team_logo': teamLogo,
    'players': players?.map((e) => e.toJson()).toList(),
    'coaches': coaches?.map((e) => e.toJson()).toList(),
  };
}

class Player {
  int? playerKey;
  String? playerName;
  String? playerNumber;
  dynamic playerCountry;
  String? playerType;
  String? playerAge;
  String? playerMatchPlayed;
  String? playerGoals;
  String? playerYellowCards;
  String? playerRedCards;
  String? playerImage;

  Player({
    this.playerKey,
    this.playerName,
    this.playerNumber,
    this.playerCountry,
    this.playerType,
    this.playerAge,
    this.playerMatchPlayed,
    this.playerGoals,
    this.playerYellowCards,
    this.playerRedCards,
    this.playerImage,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    playerKey: json['player_key'] as int?,
    playerName: json['player_name'] as String?,
    playerNumber: json['player_number'] as String?,
    playerCountry: json['player_country'] as dynamic,
    playerType: json['player_type'] as String?,
    playerAge: json['player_age'] as String?,
    playerMatchPlayed: json['player_match_played'] as String?,
    playerGoals: json['player_goals'] as String?,
    playerYellowCards: json['player_yellow_cards'] as String?,
    playerRedCards: json['player_red_cards'] as String?,
    playerImage: json['player_image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'player_key': playerKey,
    'player_name': playerName,
    'player_number': playerNumber,
    'player_country': playerCountry,
    'player_type': playerType,
    'player_age': playerAge,
    'player_match_played': playerMatchPlayed,
    'player_goals': playerGoals,
    'player_yellow_cards': playerYellowCards,
    'player_red_cards': playerRedCards,
    'player_image': playerImage,
  };
}

class Coach {
  String? coachName;
  dynamic coachCountry;
  dynamic coachAge;

  Coach({this.coachName, this.coachCountry, this.coachAge});

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
    coachName: json['coach_name'] as String?,
    coachCountry: json['coach_country'] as dynamic,
    coachAge: json['coach_age'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'coach_name': coachName,
    'coach_country': coachCountry,
    'coach_age': coachAge,
  };
}
