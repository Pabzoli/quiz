import 'package:flutter/material.dart';
import 'questions.dart';
import 'dart:math';
import 'animated_bkg.dart';
import 'dart:async';
import 'main.dart';

const int numberOfQuestions = 10;
const Duration answerDelay = Duration(milliseconds: 500);
const Duration animationDuration = Duration(milliseconds: 250);
const double initialFontSize = 27;

class QuestionsPage extends StatefulWidget {
  final List<String> selectedTitles;

  QuestionsPage({
    required this.selectedTitles,
  });

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage>
    with SingleTickerProviderStateMixin {
  List<AnimeQuestion> selectedQuestions = [];
  int questionIndex = 0;
  int selectedOptionIndex = -1;
  bool showCorrectAnswer = false;
  bool showWrongAnswer = false;
  bool hintUsed = false;
  int timerSeconds = 10;
  List<int> questionHintCounts = [];
  List<bool> hintSnackBarShown = [];
  List<int> hintPressedCount = [];

  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  int mutableHintCount = 0;
  @override
  void initState() {
    super.initState();
    selectRandomQuestions();
    startTimer();
    TotalScoreManager.initialize();

    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    initializeHintCounts();
    HintManager.initialize().then((_) {
      // Ensure the HintManager is initialized before proceeding
      mutableHintCount = HintManager.getHintCount();
      // Rest of your initialization logic here...
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (timerSeconds == 0) {
          timer.cancel();
          moveToNextQuestion(); // Move to the next question when time is up
        } else {
          timerSeconds--;
        }
      });
    });
  }

  void selectRandomQuestions() {
    List<String> normalizedTitles =
        widget.selectedTitles.map((title) => title.toLowerCase()).toList();

    List<AnimeQuestion> filteredQuestions = animeQuestions
        .where((question) =>
            normalizedTitles.contains(question.animeTitle.toLowerCase()))
        .toList();

    final random = Random();
    if (filteredQuestions.length <= numberOfQuestions) {
      selectedQuestions.addAll(filteredQuestions);
    } else {
      while (selectedQuestions.length < numberOfQuestions) {
        int randomIndex = random.nextInt(filteredQuestions.length);
        if (!selectedQuestions.contains(filteredQuestions[randomIndex])) {
          selectedQuestions.add(filteredQuestions[randomIndex]);
        }
      }
    }

    if (selectedQuestions.isNotEmpty) {
      setState(() {
        selectedOptionIndex = -1;
      });
    }
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
                      'Question ${questionIndex + 1}/${selectedQuestions.length}'),
                  Tooltip(
                    message:
                        'Hints remaining: $mutableHintCount', // Show hint count in tooltip
                    child: IconButton(
                      icon: Icon(Icons.lightbulb),
                      onPressed: () => _useHint(questionIndex),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                IllusoryMotion(), // Displayed as the background
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Timer: ${timerSeconds}s',
                        style: TextStyle(
                          fontSize: 24.0, // Increase the font size
                          fontWeight: FontWeight.bold, // Make the text bold
                          color: Colors
                              .white, // Set the text color to white for visibility
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
              ],
            )));
  }

  void _useHint(int index) {
    setState(() {
      if (hintPressedCount[index] < 2) {
        if (hintPressedCount[index] == 0) {
          if (mutableHintCount > 0) {
            mutableHintCount--;
            questionHintCounts[index]--;
            _highlightWrongOption();
            HintManager.deductGeneralHint(); // Deduct the general hint count
            hintPressedCount[index]++;
          } else {
            _showSnackBarIfRequired(index, 'Insufficient hint count!');
          }
        } else {
          if (mutableHintCount >= 2) {
            mutableHintCount -= 2;
            questionHintCounts[index] -= 2;
            _highlightWrongOption();
            HintManager.deductGeneralHint();
            HintManager.deductGeneralHint(); // Deduct the general hint count
            hintPressedCount[index]++;
          } else {
            _showSnackBarIfRequired(index, 'Insufficient hint count!');
          }
        }
      }
    });
  }

  void initializeHintCounts() {
    hintPressedCount = List.generate(selectedQuestions.length, (_) => 0);
    questionHintCounts = List.generate(
      selectedQuestions.length,
      (_) => questionHintCounts.isEmpty
          ? mutableHintCount
          : questionHintCounts.last,
    );
    hintSnackBarShown = List.generate(selectedQuestions.length, (_) => false);
  }

  void _showSnackBarIfRequired(int index, String message) {
    if (!hintSnackBarShown[index]) {
      hintSnackBarShown[index] = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _highlightWrongOption() {
    final AnimeQuestion question = selectedQuestions[questionIndex];
    final int correctAnswer = question.correctAnswerIndex;
    final int selectedAnswer = selectedOptionIndex;

    if (hintPressedCount[questionIndex] == 0) {
      final random = Random();
      int randomWrongOptionIndex;

      do {
        randomWrongOptionIndex = random.nextInt(question.options.length);
      } while (randomWrongOptionIndex == correctAnswer);

      setState(() {
        selectedOptionIndex =
            randomWrongOptionIndex; // Highlight the first wrong option
      });
    } else if (hintPressedCount[questionIndex] == 1) {
      if (selectedAnswer != correctAnswer) {
        int firstWrongOption = -1;
        for (int i = 0; i < question.options.length; i++) {
          if (i != correctAnswer && i != selectedAnswer) {
            firstWrongOption = i;
            break;
          }
        }

        setState(() {
          selectedOptionIndex =
              firstWrongOption; // Highlight the first wrong option
        });
      }
    } else if (hintPressedCount[questionIndex] == 2) {
      if (selectedAnswer != correctAnswer) {
        int secondWrongOption = -1;
        int count = 0;
        for (int i = 0; i < question.options.length; i++) {
          if (i != correctAnswer && i != selectedAnswer) {
            count++;
            if (count == 2) {
              secondWrongOption = i; // Highlight the second wrong option
              break;
            }
          }
        }

        setState(() {
          selectedOptionIndex = secondWrongOption;
        });
      }
    }
  }

  Widget _buildAnswerOverlay() {
    if (selectedQuestions.isEmpty ||
        questionIndex >= selectedQuestions.length) {
      return SizedBox.shrink();
    }

    final AnimeQuestion question = selectedQuestions[questionIndex];
    final List<String> options = question.options;

    return IgnorePointer(
      ignoring: !(showCorrectAnswer || showWrongAnswer),
      child: AnimatedOpacity(
        opacity: showCorrectAnswer || showWrongAnswer ? 1.0 : 0.0,
        duration: animationDuration,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.8),
            ),
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _animation,
                  child: showCorrectAnswer
                      ? Icon(Icons.check, color: Colors.green, size: 100)
                      : Icon(Icons.close, color: Colors.red, size: 80),
                ),
                SizedBox(height: 10),
                FadeTransition(
                  opacity: _animation,
                  child: Text(
                    showCorrectAnswer
                        ? 'Correct!'
                        : 'The correct answer is: ${options[question.correctAnswerIndex]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget() {
    if (selectedQuestions.isEmpty ||
        questionIndex >= selectedQuestions.length) {
      return Center(
        child: Text('No Questions Available'),
      );
    }

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: animationDuration,
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0), // Slide from right
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves
                      .easeInOut, // Adjust the curve for smoother animation
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: Stack(
                  children: [
                    _buildQuestionItem(selectedQuestions[questionIndex]),
                    if (showCorrectAnswer || showWrongAnswer)
                      Center(
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 2000),
                          opacity:
                              showCorrectAnswer || showWrongAnswer ? 1.0 : 0.0,
                          curve: Curves
                              .easeInOut, // Adjust the curve for smoother opacity change
                          child: _buildAnswerOverlay(),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            key: ValueKey<int>(
                questionIndex), // Use ValueKey for AnimatedSwitcher to differentiate between questions
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionItem(AnimeQuestion question) {
    final List<String> options = question.options;
    final int correctAnswer = question.correctAnswerIndex;
    final int hintPressed = hintPressedCount[questionIndex];
    final bool isFirstHint = hintPressed == 1;
    final bool isSecondHint = hintPressed == 2;
    final bool hasSufficientHints = questionHintCounts[questionIndex] >= 2;

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

              if (index != correctAnswer) {
                if ((isFirstHint && !isSecondHint) ||
                    (isSecondHint && hasSufficientHints)) {
                  if (selectedOptionIndex == index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!(showCorrectAnswer || showWrongAnswer)) {
                            setState(() {
                              selectedOptionIndex = index;
                            });
                            _handleNext();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isSecondHint ? Colors.red : Colors.blue,
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
                  }
                }
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    if (!(showCorrectAnswer || showWrongAnswer)) {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                      _handleNext();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        selectedOptionIndex == index ? Colors.blue : Colors.red,
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
    final AnimeQuestion question = selectedQuestions[questionIndex];
    final int correctAnswer = question.correctAnswerIndex;

    setState(() {
      if (selectedOptionIndex == correctAnswer) {
        showCorrectAnswer = true;
        TotalScoreManager.addToTotalScore(10);
      } else {
        showWrongAnswer = true;
      }
    });

    _controller.forward().whenComplete(() {
      Future.delayed(answerDelay, () {
        setState(() {
          showWrongAnswer = false;
          showCorrectAnswer = false;
          moveToNextQuestion();
        });
        _controller.reset();
      });
    });
  }

  void moveToNextQuestion() {
    setState(() {
      if (questionIndex < selectedQuestions.length - 1) {
        questionIndex++;
        selectedOptionIndex = -1;
        timerSeconds = 10; // Reset the timer for the next question
        _timer.cancel(); // Cancel the previous timer
        startTimer(); // Start the timer for the next question
      } else {
        Navigator.pop(context);

        // Stop the timer when all questions are finished
        _timer.cancel(); // Stop the timer when all questions are finished
      }

      showWrongAnswer = false;
      showCorrectAnswer = false;

      _controller.reset();
    });
  }
}
