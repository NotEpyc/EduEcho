import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'dart:math';

class NotebookDetailScreen extends StatelessWidget {
  final String notebookTitle;
  final int notebookIndex;

  const NotebookDetailScreen({
    super.key,
    required this.notebookTitle,
    required this.notebookIndex,
  });

  // Random topics for notebooks
  static const List<String> _topics = [
    'Data Structures',
    'Algorithms',
    'Machine Learning',
    'Web Development',
    'Database Design',
    'Software Engineering',
    'Computer Networks',
    'Operating Systems',
    'Artificial Intelligence',
    'Cloud Computing',
  ];

  // Random note content templates
  static const List<Map<String, String>> _noteTemplates = [
    {
      'title': 'Introduction to Binary Trees',
      'content':
          'Binary trees are hierarchical data structures where each node has at most two children. They are fundamental in computer science and used in various applications like file systems, expression parsing, and searching algorithms.',
    },
    {
      'title': 'Understanding Hash Tables',
      'content':
          'Hash tables provide O(1) average time complexity for insertions and lookups. They use a hash function to map keys to indices in an array. Collision resolution techniques include chaining and open addressing.',
    },
    {
      'title': 'Sorting Algorithms Overview',
      'content':
          'Common sorting algorithms include QuickSort (O(n log n) average), MergeSort (O(n log n) guaranteed), and BubbleSort (O(n²)). Each has different time/space complexity trade-offs and use cases.',
    },
    {
      'title': 'Graph Traversal Techniques',
      'content':
          'BFS (Breadth-First Search) uses a queue and explores level by level. DFS (Depth-First Search) uses a stack and explores as far as possible before backtracking. Both have O(V+E) time complexity.',
    },
    {
      'title': 'Dynamic Programming Principles',
      'content':
          'Dynamic programming solves complex problems by breaking them into simpler subproblems. Key concepts: optimal substructure and overlapping subproblems. Common examples: Fibonacci, knapsack problem.',
    },
    {
      'title': 'Object-Oriented Programming',
      'content':
          'OOP principles: Encapsulation (data hiding), Inheritance (code reuse), Polymorphism (many forms), and Abstraction (hiding complexity). These principles help create maintainable and scalable code.',
    },
    {
      'title': 'Database Normalization',
      'content':
          'Normalization reduces data redundancy. 1NF: Atomic values. 2NF: No partial dependencies. 3NF: No transitive dependencies. BCNF: Stricter version of 3NF. Helps maintain data integrity.',
    },
    {
      'title': 'REST API Design',
      'content':
          'RESTful APIs use HTTP methods (GET, POST, PUT, DELETE) and follow stateless communication. Best practices: use nouns for resources, version your API, implement proper status codes.',
    },
  ];

  String _getNoteTopic(int index) {
    final random = Random(notebookIndex * 100 + index);
    return _topics[random.nextInt(_topics.length)];
  }

  Map<String, String> _getNoteContent(int index) {
    final random = Random(notebookIndex * 100 + index);
    return _noteTemplates[random.nextInt(_noteTemplates.length)];
  }

  String _getNoteDate(int index) {
    final days = [1, 2, 3, 5, 7, 14];
    final random = Random(notebookIndex * 100 + index);
    final daysAgo = days[random.nextInt(days.length)];
    return daysAgo == 1 ? '1 day ago' : '$daysAgo days ago';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final noteCount = (notebookIndex + 1) * 8;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(notebookTitle, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // TODO: Search notes
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // TODO: Show menu
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          left: responsive.widthPercent(2),
          right: responsive.widthPercent(2),
          top: responsive.heightPercent(1),
          bottom: responsive.heightPercent(2),
        ),
        itemCount: noteCount,
        itemBuilder: (context, index) {
          return _buildNoteCard(context, index, responsive);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create new note
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(
    BuildContext context,
    int index,
    Responsive responsive,
  ) {
    final topic = _getNoteTopic(index);
    final noteContent = _getNoteContent(index);
    final date = _getNoteDate(index);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.deepPurple, width: 1.5),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Open note details
          _showNoteDetails(context, topic, noteContent, date);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      topic,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                noteContent['title']!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                noteContent['content']!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Colors.amber[700],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Key Concept',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.amber[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoteDetails(
    BuildContext context,
    String topic,
    Map<String, String> noteContent,
    String date,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            topic,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          noteContent['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          noteContent['content']!,
                          style: const TextStyle(fontSize: 16, height: 1.6),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amber[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: Colors.amber[700],
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'This is a key concept that frequently appears in technical interviews and real-world applications.',
                                  style: TextStyle(
                                    color: Colors.amber[900],
                                    fontSize: 14,
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
              ],
            ),
          ),
    );
  }
}
