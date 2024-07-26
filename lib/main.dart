import 'package:flutter/material.dart';
import 'package:flutter_application_8/login.dart';
import 'package:flutter_application_8/teams_cubit.dart';
import 'package:flutter_application_8/teams_states.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginPage(),
      home: BlocProvider(
        create: (context) => GetTeamsCubit()..getAllTeams(2),
        child: const TeamsScreen(),
      ),
    );
  }
}

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const GradeScreen(),
    const TopScoresScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff26243C),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff26243C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _onTabTapped(0),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.3,
                decoration: BoxDecoration(
                  color: _currentIndex == 0 ? Colors.blue : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.co_present,
                        color: _currentIndex == 0 ? Colors.white : Colors.blue,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Teams',
                        style: TextStyle(
                          color:
                              _currentIndex == 0 ? Colors.white : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onTabTapped(1),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.3,
                decoration: BoxDecoration(
                  color: _currentIndex == 1 ? Colors.blue : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.score,
                        color: _currentIndex == 1 ? Colors.white : Colors.blue,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Top Scores',
                        style: TextStyle(
                          color:
                              _currentIndex == 1 ? Colors.white : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradeScreen extends StatelessWidget {
  const GradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              label: const Text(
                'Type and Find Your Team',
                style: TextStyle(color: Colors.white),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        BlocBuilder<GetTeamsCubit, GetTeamsState>(
          builder: (context, state) {
            if (state is TeamsLoading) {
              return const CircularProgressIndicator();
            } else if (state is TeamsSuccess) {
              return Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: state.response.result?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var team = state.response.result![index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Stack(
                            children: [
                              // الصورة
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35.0),
                                  child: Image.network(
                                    team.teamLogo ?? '', // رابط الصورة للفريق
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.image,
                                            color: Colors.grey, size: 50),
                                      ); // في حال عدم تحميل الصورة
                                    },
                                  ),
                                ),
                              ),
                              // النص
                              Center(
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    team.teamName ?? 'Team # ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              );
            } else if (state is TeamsFailure) {
              return const Text('Failed to load teams',
                  style: TextStyle(color: Colors.red));
            }
            return Container();
          },
        ),
      ],
    );
  }
}

class TopScoresScreen extends StatefulWidget {
  const TopScoresScreen({super.key});

  @override
  _TopScoresScreenState createState() => _TopScoresScreenState();
}

class _TopScoresScreenState extends State<TopScoresScreen> {
  final TextEditingController otpController = TextEditingController();
  int number = 0;

  int nextNumber({required int min, required int max}) {
    return Random().nextInt(max - min) + min;
  }

  void generateRandomNumberAndShowDialog(BuildContext context) {
    final int newNumber = nextNumber(min: 1000, max: 10000);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$newNumber'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff14142B),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    setState(() {
      number = newNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('zzzzzzzzz'),
    );
  }
}
