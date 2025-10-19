import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'notebook_detail_screen.dart';

class NotebookScreen extends StatelessWidget {
  const NotebookScreen({super.key});

  // Topics for notebooks (matching detail screen)
  static const List<String> _notebookTopics = [
    'Data Structures',
    'Algorithms',
    'Machine Learning',
    'Web Development',
    'Database Design',
  ];

  String _getNotebookTopic(int index) {
    return _notebookTopics[index % _notebookTopics.length];
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
            // My Notebooks header with search button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.widthPercent(5),
                vertical: responsive.heightPercent(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'My Notebooks',
                    style: TextStyle(
                      fontSize: responsive.fontSize(
                        mobile: 6,
                        min: 20,
                        max: 28,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Search notebooks
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                      size: responsive.iconSize(mobile: 6, min: 24, max: 32),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: responsive.widthPercent(2),
                  right: responsive.widthPercent(2),
                  bottom: responsive.screenNavbarSpace,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final notebookTopic = _getNotebookTopic(index);
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.deepPurple, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Icon(
                        Icons.book,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      title: Text(notebookTopic),
                      subtitle: Text(
                        '${(index + 1) * 8} notes • Updated 2 days ago',
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'share',
                                child: Row(
                                  children: [
                                    Icon(Icons.share),
                                    SizedBox(width: 8),
                                    Text('Share'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                        onSelected: (value) {
                          // TODO: Handle menu actions
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => NotebookDetailScreen(
                                  notebookTitle: notebookTopic,
                                  notebookIndex: index,
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
