import 'package:flutter_application_8/teams_model.dart';
import 'package:flutter_application_8/teams_repo.dart';
import 'package:flutter_application_8/teams_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTeamsCubit extends Cubit<GetTeamsState> {
  List<TeamResult> teams = [];

  GetTeamsCubit() : super(TeamsInitial());

  void getAllTeams(int? leagueId) {
    emit(TeamsLoading());
    TeamsRepo().getAllTeams(leagueId: leagueId).then((value) {
      if (value != null) {
        teams = value.result ?? [];
        print(teams.length);
        emit(TeamsSuccess(response: value));
      } else {
        emit(TeamsFailure());
        print("request failed");
      }
    });
  }
}
