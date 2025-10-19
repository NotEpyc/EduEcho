import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import '../../utils/responsive.dart';
import 'dart:math';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  // Random names list (same as feed_screen)
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

  String _getRandomName(int index) {
    final random = Random(index);
    return _names[random.nextInt(_names.length)];
  }

  String _getRandomCharacter(int index) {
    final random = Random(index);
    return 'char${random.nextInt(5) + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Explore header with search button
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
                      'Explore',
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
                        // TODO: Open search
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.widthPercent(5),
                ),
                child: Text(
                  'Popular Topics',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              _buildTopicsGrid(context),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Leaderboard',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              _buildLeaderboard(context),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Resource Marketplace',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              _buildResourceMarketplace(context),
              SizedBox(height: responsive.screenNavbarSpace + 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicsGrid(BuildContext context) {
    final topics = [
      {
        'name': 'Computer Science',
        'icon': Icons.computer,
        'count': '1.2k questions',
      },
      {
        'name': 'Mathematics',
        'icon': Icons.calculate,
        'count': '890 questions',
      },
      {'name': 'Physics', 'icon': Icons.science, 'count': '645 questions'},
      {'name': 'Chemistry', 'icon': Icons.biotech, 'count': '423 questions'},
      {'name': 'Biology', 'icon': Icons.eco, 'count': '567 questions'},
      {
        'name': 'Engineering',
        'icon': Icons.engineering,
        'count': '789 questions',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: M3Container(
            Shapes.c4_sided_cookie,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                // TODO: Navigate to topic
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      topic['icon'] as IconData,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(height: 6),
                    Flexible(
                      child: Text(
                        topic['name'] as String,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      topic['count'] as String,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeaderboard(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        final userName = _getRandomName(index);
        final characterImage = _getRandomCharacter(index);

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/profile/$characterImage.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (index < 3)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color:
                              [Colors.amber, Colors.grey, Colors.brown][index],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            title: Text(userName),
            subtitle: Text('${1000 - index * 100} points'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: View profile
            },
          ),
        );
      },
    );
  }

  Widget _buildResourceMarketplace(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                // TODO: View resource
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 160,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Notebook ${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '4.${9 - index}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(index + 1) * 50} saves',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
