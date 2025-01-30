import 'package:flutter/material.dart';
import 'package:quiz_game/model/quiz_model.dart';
import 'package:quiz_game/constant/app_colors.dart';
import 'package:quiz_game/presentation/start_screen.dart';

/// Displays the results of a quiz, including performance metrics and question details.
class ResultScreen extends StatelessWidget {
  /// The answers selected by the user.
  final Map<int, int?> selectedAnswers;

  /// The correct answers for each question.
  final Map<int, int?> correctAnswers;

  /// The quiz object containing questions and options.
  final Quiz quiz;

  const ResultScreen({
    Key? key,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Total number of questions in the quiz.
    final int totalQuestions = quiz.questions?.length ?? 0;

    // Calculate the number of correct answers.
    final correctAnswersCount = correctAnswers.entries.where((entry) {
      final selectedAnswerId = selectedAnswers[entry.key];
      return selectedAnswerId != null && selectedAnswerId == entry.value;
    }).length;

    // Calculate the number of wrong answers.
    final wrongAnswersCount = totalQuestions - correctAnswersCount;

    // Calculate the score percentage (0.0 - 1.0).
    final double scorePercentage =
        totalQuestions > 0 ? correctAnswersCount / totalQuestions : 0.0;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Quiz Results',
          style: TextStyle(
            fontFamily: 'Montserrat Bold',
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildScoreIndicator(scorePercentage),
              const SizedBox(height: 40),
              _buildMetricsRow(
                  correctAnswersCount, wrongAnswersCount, scorePercentage),
              const SizedBox(height: 20),
              Expanded(child: _buildQuestionsList(totalQuestions)),
              const SizedBox(height: 10),
              _buildRetakeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header text for the result screen.
  Widget _buildHeader() => Text(
        'Your Performance',
        style: TextStyle(
          fontFamily: 'Montserrat Bold',
          fontSize: 26,
          color: AppColors.white,
        ),
      );

  /// Builds a circular score indicator showing the user's performance percentage.
  Widget _buildScoreIndicator(double scorePercentage) => Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: scorePercentage,
            strokeWidth: 12,
            backgroundColor: AppColors.green.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(AppColors.green),
          ),
          Text(
            '${(scorePercentage * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontFamily: 'Montserrat Bold',
              fontSize: 36,
              color: AppColors.white,
            ),
          ),
        ],
      );

  /// Builds a row displaying performance metrics like correct answers, wrong answers, and accuracy.
  Widget _buildMetricsRow(int correct, int wrong, double accuracy) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMetricCard(
                'Correct', correct, AppColors.green, Icons.check_circle),
            _buildMetricCard('Wrong', wrong, Colors.red, Icons.cancel),
            _buildMetricCard(
                'Accuracy',
                '${(accuracy * 100).toStringAsFixed(1)}%',
                Colors.orange,
                Icons.bar_chart),
          ],
        ),
      );

  /// Builds a list of questions, showing the user's selected answer and the correct answer.
  Widget _buildQuestionsList(int totalQuestions) => ListView.builder(
        itemCount: totalQuestions,
        itemBuilder: (context, index) {
          final question = quiz.questions?[index];
          final selectedAnswerId = selectedAnswers[question?.id];
          final correctAnswerId = correctAnswers[question?.id];
          final correctOptions = question?.options
              ?.where((option) => option.isCorrect == true)
              .toList();
          final isCorrect = selectedAnswerId == correctAnswerId;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 6,
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                '${index + 1}. ${question?.description ?? 'Unknown Question'}',
                style: TextStyle(
                  fontFamily: 'Montserrat Bold',
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Your Answer: ${_getAnswerDescription(selectedAnswerId, question)}',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Correct Answer: ${(correctOptions?.map((e) => e.description).join(", ") ?? 'No Answer')}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  /// Builds a button to retake the quiz, returning to the start screen.
  Widget _buildRetakeButton(BuildContext context) => ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StartScreen()),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          backgroundColor: AppColors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Retake Quiz',
          style: TextStyle(
            fontFamily: 'Montserrat Bold',
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
      );

  /// Retrieves the description of the user's selected answer for a given question.
  String _getAnswerDescription(int? selectedAnswerId, Question? question) {
    if (selectedAnswerId == null || question == null) return 'No Answer';
    return question.options
            ?.firstWhere((option) => option.id == selectedAnswerId,
                orElse: () => Option(id: -1, description: 'No Answer'))
            .description ??
        'No Answer';
  }

  /// Builds a metric card displaying a label, value, and icon for performance metrics.
  Widget _buildMetricCard(
          String label, dynamic value, Color color, IconData icon) =>
      Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value.toString(),
                style: TextStyle(
                  fontFamily: 'Montserrat Bold',
                  fontSize: 24,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
}
