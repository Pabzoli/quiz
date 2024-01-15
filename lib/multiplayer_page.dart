import 'package:flutter/material.dart';
import 'questions.dart';
import 'dart:math';
import 'animated_bkg.dart';
import 'dart:async';
import 'main.dart';
import 'summary_page.dart';

const int numberOfQuestions = 10;
const double initialFontSize = 27;

class MultiplayerPage extends StatefulWidget {
  final int betScore;
  final String playerName;

  MultiplayerPage({
    Key? key,
    required this.betScore,
    required this.playerName,
  }) : super(key: key);

  @override
  _MultiplayerPageState createState() => _MultiplayerPageState();
}

class _MultiplayerPageState extends State<MultiplayerPage>
    with SingleTickerProviderStateMixin {
  List<AnimeQuestion> selectedQuestions = [];
  int questionIndex = 0;
  int selectedOptionIndex = -1;
  int timerSeconds = 10;
  int opponentScore = 0;
  int playerScore = 0;
  late String _playerName;
  late int betScore;

  late Timer _timer;
  int _hints = 0;
  List<bool> hintUsed = [];
  bool _waitingForOpponent = false;

  Map<String, List<AnimeQuestion>> questionsByTitle = {};
  List<int> userAnswers = List.filled(
      numberOfQuestions, -1); // Initialize with -1 indicating no answer
  Set<int> usedQuestionIndices = {};

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initializeQuestionsByTitle();
    startTimer();
    selectRandomQuestions();
    initializeHintUsed();
    HintManager.initialize().then((_) {
      // Ensure the HintManager is initialized before proceeding
      _hints = HintManager.getHintCount();
      // Rest of your initialization logic here...
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Set your desired duration
      value: 1.0, // Ensure it starts fully opaque
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _playerName = widget.playerName;
    betScore = widget.betScore;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (timerSeconds == 0) {
          timer.cancel();
          moveToNextQuestion();
        } else {
          timerSeconds--;
        }
      });
    });
  }

  void initializeQuestionsByTitle() {
    questionsByTitle.clear(); // Clearing previously stored questions if any

    animeQuestions.forEach((question) {
      final normalizedTitle = question.animeTitle.toLowerCase();
      if (!questionsByTitle.containsKey(normalizedTitle)) {
        questionsByTitle[normalizedTitle] = [];
      }
      questionsByTitle[normalizedTitle]!.add(question);
    });
  }

  void selectRandomQuestions() {
    List<AnimeQuestion> tempQuestions = [];
    questionsByTitle.forEach((title, questions) {
      if (questions.isNotEmpty) {
        final random = Random();
        final indices = List.generate(questions.length, (index) => index);
        indices.shuffle(random);

        for (int i = 0; i < 2 && i < questions.length; i++) {
          tempQuestions.add(questions[indices[i]]);
        }
      }
    });

    final random = Random();
    final indices = List.generate(tempQuestions.length, (index) => index);
    indices.shuffle(random);

    selectedQuestions.clear();
    for (int i = 0; i < numberOfQuestions && i < tempQuestions.length; i++) {
      if (!usedQuestionIndices.contains(indices[i])) {
        selectedQuestions.add(tempQuestions[indices[i]]);
        usedQuestionIndices.add(indices[i]); // Mark as used
      }
    }

    // Check if all questions are used, then reset if necessary
    if (usedQuestionIndices.length >= tempQuestions.length) {
      usedQuestionIndices.clear(); // Reset used questions
    }

    if (selectedQuestions.isNotEmpty) {
      setState(() {
        selectedOptionIndex = -1;
      });
    }
  }

  void initializeHintUsed() {
    hintUsed = List.generate(selectedQuestions.length, (_) => false);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${questionIndex + 1}/${selectedQuestions.length}',
              ),
              Tooltip(
                message: 'Hints remaining: $_hints',
                child: IconButton(
                  icon: Icon(Icons.lightbulb),
                  onPressed: (_hints > 0 && !hintUsed[questionIndex])
                      ? () => _useHint(questionIndex)
                      : null,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            IllusoryMotion(),
            FadeTransition(
              opacity: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Timer: ${timerSeconds}s',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildQuestionWidget(),
                    ),
                  ),
                ],
              ),
            ),
            _waitingForOpponent ? _buildWaitingDialog() : Container(),
          ],
        ),
      ),
    );
  }

  void _useHint(int index) {
    if (!hintUsed[index] && _hints > 0) {
      setState(() {
        _highlightWrongOption(index);
        _hints--;
        hintUsed[index] = true;
        HintManager.deductGeneralHint();
      });
    } else if (hintUsed[index]) {
      _showSnackBarIfRequired(index, 'Maximum hint used for this question');
    }
  }

  void _highlightWrongOption(int index) {
    final question = selectedQuestions[index];
    final correctAnswer = question.correctAnswerIndex;

    setState(() {
      for (int i = 0; i < question.options.length; i++) {
        if (i != correctAnswer && i != selectedOptionIndex) {
          selectedOptionIndex = i;
          break;
        }
      }
    });
  }

  void _showSnackBarIfRequired(int index, String message) {
    if (!hintUsed[index]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      hintUsed[index] = true;
    }
  }

  Widget _buildQuestionWidget() {
    if (selectedQuestions.isEmpty ||
        questionIndex >= selectedQuestions.length) {
      return Center(
        child: Text('No Questions Available'),
      );
    }

    final AnimeQuestion question = selectedQuestions[questionIndex];
    final List<String> options = question.options;

    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.8),
            ),
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: _calculateQuestionFontSize(question.question),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOptionIndex = index;
                      userAnswers[questionIndex] = index;
                      _handleNext();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: (index == selectedOptionIndex &&
                            index != question.correctAnswerIndex)
                        ? Colors.red // Incorrect option turns red
                        : (index == question.correctAnswerIndex)
                            ? Colors.blue // Correct option stays blue
                            : Colors.blue, // Other options are also blue
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  double _calculateQuestionFontSize(String text) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.8;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: initialFontSize),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final double availableWidth = textPainter.size.width;
    if (availableWidth > maxWidth) {
      final double scaleFactor = maxWidth / availableWidth;
      return initialFontSize * scaleFactor;
    }
    return initialFontSize;
  }

  void _handleNext() {
    setState(() {
      _waitForOpponentSelection();
    });
  }

  void moveToNextQuestion() {
    _animationController.reset();
    _animationController.forward();
    setState(() {
      if (questionIndex < selectedQuestions.length - 1) {
        if (selectedOptionIndex ==
            selectedQuestions[questionIndex].correctAnswerIndex) {
          playerScore++;
        }
        questionIndex++;
        selectedOptionIndex = -1;
        timerSeconds = 10;
        _timer.cancel();
        startTimer();
      } else {
        if (selectedOptionIndex ==
            selectedQuestions[questionIndex].correctAnswerIndex) {
          playerScore++;
        }
        _timer.cancel();
        _showSummaryPage();
      }
    });
  }

  Widget _buildWaitingDialog() {
    return Container(
      color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
      child: Center(
        child: CircularProgressIndicator(), // Customize loader appearance
      ),
    );
  }

  void _waitForOpponentSelection() {
    setState(() {
      _waitingForOpponent = true;
      _timer.cancel();
    });

    final randomDuration = Duration(seconds: Random().nextInt(4));

    Future.delayed(randomDuration, () {
      setState(() {
        _waitingForOpponent = false;
        moveToNextQuestion();
      });
    });
  }

  void _showSummaryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          questions: selectedQuestions,
          playerName: _playerName,
          betScore: betScore,
          userAnswers: userAnswers,
          playerScore: playerScore,
        ),
      ),
    );
  }
}
