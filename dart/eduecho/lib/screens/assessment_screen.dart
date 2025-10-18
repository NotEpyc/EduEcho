import 'package:flutter/material.dart';
import 'home/home_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentQuestion = 0;
  String? _selectedAnswer;

  final List<AssessmentQuestion> _questions = [
    AssessmentQuestion(
      question: 'When learning a new concept, what do you prefer?',
      options: [
        'Deep, detailed explanations with examples',
        'Balanced overview with key points',
        'Quick, concise summary',
        'Simple, step-by-step guidance',
      ],
    ),
    AssessmentQuestion(
      question: 'How do you approach problem-solving?',
      options: [
        'Analyze thoroughly and explore all angles',
        'Consider main factors and decide',
        'Quick decision based on key facts',
        'Need clear guidance and instructions',
      ],
    ),
    AssessmentQuestion(
      question: 'What\'s your preferred study style?',
      options: [
        'Research deeply, take detailed notes',
        'Mixed approach: reading and practice',
        'Focus on key concepts only',
        'Follow structured tutorials',
      ],
    ),
    AssessmentQuestion(
      question: 'When reading explanations, you prefer:',
      options: [
        'Comprehensive with technical details',
        'Moderate depth with examples',
        'Brief and to the point',
        'Very simple with basics',
      ],
    ),
    AssessmentQuestion(
      question: 'Your goal in learning is to:',
      options: [
        'Master every detail completely',
        'Understand well enough to apply',
        'Get the gist quickly',
        'Build basic understanding',
      ],
    ),
  ];

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _nextQuestion() {
    if (_selectedAnswer == null) return;

    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
      });
    } else {
      _completeAssessment();
    }
  }

  void _completeAssessment() {
    // TODO: Calculate user type based on answers
    // For now, just navigate to home
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];
    final progress = (_currentQuestion + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Learning Assessment')),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Question ${_currentQuestion + 1} of ${_questions.length}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question.question,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 32),
                    ...question.options.map((option) {
                      final isSelected = _selectedAnswer == option;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                          color:
                              isSelected
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.1)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () => _selectAnswer(option),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.primary
                                          : Theme.of(context).dividerColor,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color:
                                        isSelected
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.5),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedAnswer != null ? _nextQuestion : null,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      _currentQuestion < _questions.length - 1
                          ? 'Next'
                          : 'Complete',
                    ),
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

class AssessmentQuestion {
  final String question;
  final List<String> options;

  AssessmentQuestion({required this.question, required this.options});
}
