import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_game/constant/app_colors.dart';
import 'package:quiz_game/model/quiz_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'package:quiz_game/presentation/result-screen.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<int, int?> selectedAnswers = {}; // Store selected answer IDs
  Map<int, int?> correctAnswers = {}; // Store correct answer IDs
  int currentQuestionIndex = 0;
  int remainingTime = 60;
  late Timer _timer;
  Map<int, String?> optionSelected =
      {}; // Track selected options for color changes

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        moveToNextQuestion();
      }
    });
  }

  void moveToNextQuestion() {
    if (currentQuestionIndex < widget.quiz.questions!.length - 1) {
      setState(() {
        currentQuestionIndex++;
        remainingTime = 60;
        optionSelected.clear();
      });
    } else {
      _submitQuiz();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            selectedAnswers: selectedAnswers,
            correctAnswers: correctAnswers, // Pass the correct answers
            quiz: widget.quiz,
          ),
        ),
      );
    }
  }

  void _submitQuiz() {
    print("Quiz Submitted with answers: $selectedAnswers");
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = widget.quiz.questions?[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.quiz.title ?? 'Quiz',
          style: TextStyle(
              fontFamily: 'Montserrat Bold',
              fontSize: 20,
              color: AppColors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Time Left: $remainingTime s",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.primaryColor,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Container(
                height: 50,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.1),
                  border: Border.all(color: AppColors.green, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Stack(
                        children: [
                          LinearProgressIndicator(
                            value: remainingTime / 60,
                            backgroundColor: Colors.transparent,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.green),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  '$remainingTime',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 1.5,
                        padding: EdgeInsets.all(16),
                        color: AppColors.primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Question ${currentQuestionIndex + 1} of ${widget.quiz.questions!.length}",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat Bold',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 0),
                                CircularProgressIndicator(
                                  value: (currentQuestionIndex + 1) /
                                      widget.quiz.questions!.length,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            Text(
                              currentQuestion?.description ?? 'No Question',
                              style: TextStyle(
                                fontFamily: 'Montserrat Bold',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            if (currentQuestion != null)
                              ...currentQuestion.options!.map((option) {
                                bool isCorrect = option.isCorrect ?? false;
                                bool isSelected =
                                    optionSelected[currentQuestion.id] ==
                                        option.description;
                                Color optionColor;

                                if (isSelected) {
                                  optionColor = isCorrect
                                      ? AppColors.green
                                      : AppColors.red;
                                } else {
                                  optionColor = AppColors.white;
                                }

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        optionSelected[currentQuestion.id!] =
                                            option.description;
                                        selectedAnswers[currentQuestion.id!] =
                                            option.id;
                                        if (isCorrect) {
                                          correctAnswers[currentQuestion.id!] =
                                              option.id;
                                        }
                                      });

                                      Future.delayed(Duration(seconds: 1),
                                          moveToNextQuestion);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: optionColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: Colors.black26),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      child: Text(
                                        option.description ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            SizedBox(height: 20),
                            if (remainingTime > 0)
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.green),
                                ),
                                onPressed: moveToNextQuestion,
                                child: Text(
                                  'Next Question',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat Bold',
                                    fontSize: 16,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
