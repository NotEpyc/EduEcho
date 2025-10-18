import 'package:flutter/material.dart';

class NotebookScreen extends StatelessWidget {
  const NotebookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notebooks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search notebooks
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.book,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              title: Text('Notebook ${index + 1}'),
              subtitle: Text('${(index + 1) * 12} notes • Updated 2 days ago'),
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
                // TODO: Open notebook details
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Create new notebook
        },
        icon: const Icon(Icons.add),
        label: const Text('New Notebook'),
      ),
    );
  }
}
