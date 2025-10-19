import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import '../../utils/responsive.dart';
import 'dart:math';

class ThreadScreen extends StatelessWidget {
  final String question;
  final String description;
  final String authorName;
  final String authorCharacter;
  final int replyCount;
  final int questionIndex;

  const ThreadScreen({
    super.key,
    required this.question,
    required this.description,
    required this.authorName,
    required this.authorCharacter,
    required this.replyCount,
    required this.questionIndex,
  });

  // Random names for replies
  static const List<String> _replyNames = [
    'Alex',
    'John',
    'Mike',
    'Emma',
    'David',
    'Lisa',
    'James',
    'Maria',
    'Nina',
    'Ryan',
    'Sarah',
    'Chris',
  ];

  // Random reply content
  static const List<String> _replyContents = [
    'Great question! The main difference is that B+ Trees store all data in leaf nodes, while B Trees store data in all nodes.',
    'I think the key difference is in how they handle sequential access. B+ Trees are much better for range queries.',
    'From what I understand, B+ Trees have better performance for disk-based storage systems.',
    'Both are balanced trees, but B+ Trees maintain a linked list at the leaf level for efficient traversal.',
    'B Trees have faster single-record access, but B+ Trees excel at range queries and sequential access.',
    'The choice depends on your use case. For databases, B+ Trees are preferred due to their sequential access benefits.',
  ];

  String _getReplyName(int index) {
    final random = Random(questionIndex * 100 + index);
    return _replyNames[random.nextInt(_replyNames.length)];
  }

  String _getReplyCharacter(int index) {
    final random = Random(questionIndex * 100 + index);
    return 'char${random.nextInt(5) + 1}';
  }

  String _getReplyContent(int index) {
    final random = Random(questionIndex * 100 + index);
    return _replyContents[random.nextInt(_replyContents.length)];
  }

  String _getReplyTime(int index) {
    final hours = [1, 2, 3, 4, 5, 6];
    final random = Random(questionIndex * 100 + index);
    return '${hours[random.nextInt(hours.length)]} hours ago';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thread', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: responsive.widthPercent(2),
          right: responsive.widthPercent(2),
          bottom: responsive.heightPercent(2),
        ),
        children: [
          // Original Question Card
          _buildQuestionCard(context, responsive),
          const SizedBox(height: 16),
          // Replies header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              '$replyCount Replies',
              style: TextStyle(
                fontSize: responsive.fontSize(mobile: 5, min: 18, max: 22),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Replies list
          ...List.generate(
            replyCount,
            (index) => _buildReplyCard(context, index, responsive),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, Responsive responsive) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                M3Container(
                  Shapes.c6_sided_cookie,
                  width: 50,
                  height: 50,
                  color: Colors.deepPurple.withOpacity(0.3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/profile/$authorCharacter.png',
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
                        authorName,
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
            Text(question, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyCard(
    BuildContext context,
    int index,
    Responsive responsive,
  ) {
    final replyName = _getReplyName(index);
    final replyCharacter = _getReplyCharacter(index);
    final replyContent = _getReplyContent(index);
    final replyTime = _getReplyTime(index);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                M3Container(
                  Shapes.c6_sided_cookie,
                  width: 40,
                  height: 40,
                  color: Colors.deepPurple.withOpacity(0.3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/profile/$replyCharacter.png',
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
                        replyName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        replyTime,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(replyContent, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_outlined, size: 18),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                Text(
                  '${Random(index).nextInt(20) + 1}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.reply, size: 18),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                Text('Reply', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
