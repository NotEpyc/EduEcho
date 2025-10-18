import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('John Doe', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text(
              'Quick Learner',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard(context, '1,234', 'Points'),
                _buildStatCard(context, '45', 'Answers'),
                _buildStatCard(context, '12', 'Questions'),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'Activity',
              children: [
                _buildListTile(
                  context,
                  icon: Icons.question_answer,
                  title: 'My Questions',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.chat_bubble,
                  title: 'My Answers',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.bookmark,
                  title: 'Saved',
                  onTap: () {},
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Learning',
              children: [
                _buildListTile(
                  context,
                  icon: Icons.psychology,
                  title: 'Learning Profile',
                  subtitle: 'Quick Learner',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.lightbulb,
                  title: 'Flashcards',
                  onTap: () {},
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Account',
              children: [
                _buildListTile(
                  context,
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.info,
                  title: 'About',
                  onTap: () {},
                ),
                _buildListTile(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // TODO: Implement logout
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
