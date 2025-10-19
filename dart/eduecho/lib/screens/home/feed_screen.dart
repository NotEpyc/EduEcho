import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import '../../utils/responsive.dart';
import 'dart:math';
import 'thread_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  // Random names list
  static const List<String> _names = [
    'Alex',
    'John',
    'Mike',
    'Emma',
    'David',
    'Lisa',
    'James',
    'Maria',
    'Nina',
  ];

  // Random questions list
  static const List<Map<String, String>> _questions = [
    {
      'title': 'What is the difference between B+ Trees and B Trees?',
      'description':
          'I understand that both are balanced tree structures, but I\'m confused about their specific differences and use cases.',
    },
    {
      'title': 'How does async/await work in JavaScript?',
      'description':
          'Can someone explain the concept of promises and how async/await simplifies asynchronous programming?',
    },
    {
      'title': 'What are the SOLID principles in software design?',
      'description':
          'I keep hearing about SOLID principles but I\'m not sure how to apply them in real projects.',
    },
    {
      'title': 'How do neural networks learn patterns?',
      'description':
          'I understand the basic structure but the backpropagation algorithm is confusing me.',
    },
    {
      'title': 'What is the difference between REST and GraphQL?',
      'description':
          'Both are used for APIs but I\'m not sure when to use which approach.',
    },
    {
      'title': 'How does garbage collection work in Java?',
      'description':
          'I want to understand the different types of garbage collectors and when to use them.',
    },
    {
      'title': 'What is Big O notation and why is it important?',
      'description':
          'I see it mentioned everywhere but I struggle to calculate time complexity.',
    },
    {
      'title': 'How do I optimize SQL queries for better performance?',
      'description':
          'My queries are running slow on large datasets. What techniques should I use?',
    },
  ];

  String _getRandomName(int index) {
    final random = Random(index); // Use index as seed for consistency
    return _names[random.nextInt(_names.length)];
  }

  String _getRandomCharacter(int index) {
    final random = Random(index);
    return 'char${random.nextInt(5) + 1}'; // char1 to char5
  }

  Map<String, String> _getRandomQuestion(int index) {
    final random = Random(index);
    return _questions[random.nextInt(_questions.length)];
  }

  int _getReplyCount(int index) {
    final random = Random(index);
    return random.nextInt(10) + 3; // 3 to 12 replies
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Popular header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.widthPercent(5),
                vertical: responsive.heightPercent(2),
              ),
              child: Text(
                'Popular',
                style: TextStyle(
                  fontSize: responsive.fontSize(mobile: 6, min: 20, max: 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Feed list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: responsive.widthPercent(2),
                  right: responsive.widthPercent(2),
                  bottom: responsive.screenNavbarSpace,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(context, index, responsive);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    BuildContext context,
    int index,
    Responsive responsive,
  ) {
    final characterName = _getRandomCharacter(index);
    final userName = _getRandomName(index);
    final question = _getRandomQuestion(index);
    final replyCount = _getReplyCount(index);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ThreadScreen(
                    question: question['title']!,
                    description: question['description']!,
                    authorName: userName,
                    authorCharacter: characterName,
                    replyCount: replyCount,
                    questionIndex: index,
                  ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Character profile image with M3Container
                  M3Container(
                    Shapes.c6_sided_cookie,
                    width: 50,
                    height: 50,
                    color: Colors.deepPurple.withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/profile/$characterName.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '2 hours ago',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Chip(
                      label: const Text(
                        'Computer Science',
                        overflow: TextOverflow.ellipsis,
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                question['title']!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                question['description']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    child: _buildActionButton(
                      context,
                      icon: Icons.chat_bubble_outline,
                      label: '$replyCount',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ThreadScreen(
                                  question: question['title']!,
                                  description: question['description']!,
                                  authorName: userName,
                                  authorCharacter: characterName,
                                  replyCount: replyCount,
                                  questionIndex: index,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 7),
                  Flexible(
                    child: _buildActionButton(
                      context,
                      icon: Icons.mic_outlined,
                      label: 'Reply',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ThreadScreen(
                                  question: question['title']!,
                                  description: question['description']!,
                                  authorName: userName,
                                  authorCharacter: characterName,
                                  replyCount: replyCount,
                                  questionIndex: index,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_outline),
                    onPressed: () {
                      // TODO: Save to notebook
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {
                      // TODO: Share
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
