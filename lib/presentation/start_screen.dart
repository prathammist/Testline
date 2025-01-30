import 'package:flutter/material.dart';
import 'package:quiz_game/presentation/quiz_screen.dart';
import 'package:quiz_game/service/quiz_service.dart';
import 'package:quiz_game/constant/app_colors.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isLoading = false;
  String? error;

  Future<void> startQuiz() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final quiz = await QuizService().fetchQuiz();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(quiz: quiz),
          ),
        );
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor, // Consistent background color
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Quiz Icon with modern styling
              const Icon(
                Icons.quiz,
                size: 100,
                color: AppColors.white,
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome to the Quiz App',
                style: TextStyle(
                    fontFamily: 'Montserrat Bold',
                    fontSize: 26,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Card for quiz features
              Card(
                color: Colors.white.withOpacity(0.8), // Semi-transparent card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quiz Features:',
                        style: TextStyle(
                          fontFamily: 'Montserrat Bold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildFeatureRow(Icons.timer, 'Timed questions'),
                      _buildFeatureRow(Icons.favorite, 'Multiple lives'),
                      _buildFeatureRow(Icons.stars, 'Points system'),
                      _buildFeatureRow(Icons.lightbulb, 'Detailed solutions'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Error Message Section
              if (error != null)
                Card(
                  color: Colors.red.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              // Start Quiz Button
              ElevatedButton(
                onPressed: isLoading ? null : startQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Start Quiz',
                        style: TextStyle(
                          fontFamily: 'Montserrat Bold',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.green),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
