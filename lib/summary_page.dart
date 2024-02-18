import 'package:flutter/material.dart';
import 'package:quiz/main.dart';
import 'dart:math';
import 'questions.dart';
import 'bet_S.dart';

class SummaryPage extends StatefulWidget {
  final List<AnimeQuestion> questions;
  final List<int> userAnswers;
  final String playerName;
  final int betScore;
  final int playerScore;

  SummaryPage(
      {Key? key,
      required this.questions,
      required this.userAnswers,
      required this.betScore,
      required this.playerName,
      required this.playerScore})
      : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with SingleTickerProviderStateMixin {
  int opponentScore = 0;
  late String _playerName;
  late int betScore;
  late int playerScore;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    TotalScoreManager.initialize();
    _playerName = widget.playerName;
    betScore = widget.betScore;
    playerScore = widget.playerScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Summary'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.grey[150] ?? Colors.grey, // Use Colors.grey as default
            Colors.grey[300] ?? Colors.grey, // Use Colors.grey as default
            Colors.grey[150] ?? Colors.grey,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: _buildSummaryPage(),
      ),
    );
  }

  void setOpponentScore() {
    final random =
        Random().nextInt(100); // Generating a random number between 0 and 99
    if (random < 85) {
      opponentScore = 10; // 85% chance of score 10
    } else if (random < 95) {
      opponentScore = 9; // 10% chance of score 9
    } else {
      opponentScore = 8; // 5% chance of score 8
    }
  }

  void togglePanel() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Summary',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: _buildSummary(),
          ),
        );
      },
    );
  }

  Widget _buildSummary() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.questions.length,
      itemBuilder: (context, index) {
        final question = widget.questions[index];
        final userAnswer = widget.userAnswers[index];
        final isCorrect = userAnswer == question.correctAnswerIndex;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${index + 1}. ${isCorrect ? 'Correct' : 'Incorrect'}',
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'You Chose: ${userAnswer + 1}', // Assuming answers are 0-based
              style: TextStyle(
                color: Colors.blue, // You can choose the color you prefer
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryPage() {
    setOpponentScore();
    List<String> participants = ['Player', '$_playerName'];
    List<int> scores = [playerScore, opponentScore];
    if (playerScore > opponentScore) {
      scores[0] = playerScore;
    } else if (playerScore == opponentScore) {
      scores[0] = playerScore;
    } else {
      scores[0] = playerScore;
    }

    List<String> outcomeImages = [
      'assets/winner_image.png',
      'assets/draw_image.png',
      'assets/loser_image.png',
    ];

    int outcomeIndex;
    int adjustedBetScore = betScore;
    String outcomeText;
    int stotalbet = betScore * 2;
    int totalN = stotalbet;

    if (playerScore > opponentScore) {
      outcomeIndex = 0;
      TotalScoreManager.addToTotalScore(stotalbet);
      outcomeText = "${stotalbet} Was Returned";
      betScore = 0;
      stotalbet = 0;
      print("Total Score: ${TotalScoreManager.getTotalScore()}");
    } else if (playerScore == opponentScore) {
      outcomeIndex = 1;
      adjustedBetScore += (betScore * 0.5).toInt();
      TotalScoreManager.addToTotalScore(adjustedBetScore);
      outcomeText = "$adjustedBetScore Was Returned";
      adjustedBetScore = 0;
      betScore = 0;
      stotalbet = 0;
      print("Total Score: ${TotalScoreManager.getTotalScore()}");
    } else {
      outcomeIndex = 2;
      outcomeText = "RIP You Lost $betScore";
      print("Total Score: ${TotalScoreManager.getTotalScore()}");
      betScore = 0;
      stotalbet = 0;
    }
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              margin: EdgeInsets.fromLTRB(13, 13, 13, 6.5),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Participants:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: participants.map((participant) {
                                return Text(
                                  '$participant',
                                  style: TextStyle(fontSize: 20),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scores:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  List.generate(participants.length, (index) {
                                return Text(
                                  '${participants[index]}: ${scores[index]}',
                                  style: TextStyle(fontSize: 20),
                                );
                              }),
                            ),
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // Handle the gesture (e.g., navigate to another page)
                                    // Add your desired action here
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_downward,
                                        size: 35,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ))
                            ])
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Align children with space in between
                      children: [
                        Text(
                          'Total Bet: $totalN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5), // Add some space between the cards
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 175,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8,
                    margin: EdgeInsets.fromLTRB(15, 0, 5, 1),
                    child: Center(
                      child: Text(
                        'First',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                //SizedBox(width: 0), // Add space between the cards
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 175,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8,
                    margin: EdgeInsets.fromLTRB(5, 0, 15, 1),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Image.asset(
                        outcomeImages[outcomeIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              Container(
                height: 135,
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.fromLTRB(13, 12, 13, 6.5),
                  child: Container(
                    color: Colors.grey[300], // Ash grayish background color
                    height: 150,
                    padding: EdgeInsets.all(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _showDialog();
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Summary Panel',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // Space between panel and text
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            ' Click to view details',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 87.5,
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(outcomeText,
                              style: TextStyle(
                                fontSize: 32, // Adjust the font size as needed
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ])),
            ),
            SizedBox(
              width: 0,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 92.5,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8,
                      margin: EdgeInsets.fromLTRB(15, 7.5, 5, 7.5),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Icon(
                          Icons.share,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BetScreen()));
                    print("Total Score: ${TotalScoreManager.getTotalScore()}");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 92.5,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 8,
                      margin: EdgeInsets.fromLTRB(5, 7.5, 15, 7.5),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
