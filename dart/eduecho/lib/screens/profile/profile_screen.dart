import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import '../../utils/responsive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedCharacter = 'char1'; // Default character

  void _showCharacterSelection() {
    String tempSelection = _selectedCharacter;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Your Character',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    // Preview
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/profile/$tempSelection.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Character selections
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final charName = 'char${index + 1}';
                          final isSelected = tempSelection == charName;
                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                tempSelection = charName;
                              });
                            },
                            child: Container(
                              width: 80,
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.deepPurple
                                          : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/profile/$charName.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedCharacter = tempSelection;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Save'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final screenWidth = responsive.screenWidth;
    final screenHeight = responsive.screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: responsive.widthPercent(5),
              right: responsive.widthPercent(5),
              top: responsive.heightPercent(1),
              bottom: responsive.screenNavbarSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Learning Stats title and edit icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Learning Stats',
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
                      onPressed: _showCharacterSelection,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                        size: responsive.iconSize(mobile: 6, min: 24, max: 32),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.heightPercent(5)),

                // Main Stats Card with M3Shape and Character
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.85,
                    height:
                        screenHeight * 0.55, // Extra height for character head
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // M3Container Card - positioned lower in the stack
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: M3Container(
                            Shapes.c4_sided_cookie,
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.45,
                            color: const Color(0xFF7E57C2),
                            child: SizedBox(), // Empty container
                          ),
                        ),

                        // Character image - overlays the card with head popping out
                        Positioned(
                          top: -screenHeight * 0.2,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              'assets/profile/$_selectedCharacter.png',
                              width: screenWidth * 0.7,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // Total Points Card - at the bottom
                        Positioned(
                          bottom: screenHeight * 0.02,
                          left: screenWidth * 0.075,
                          right: screenWidth * 0.075,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.025,
                              horizontal: screenWidth * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '2,480',
                                  style: TextStyle(
                                    fontSize: responsive.fontSize(
                                      mobile: 12,
                                      min: 36,
                                      max: 48,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                Text(
                                  'Total Points',
                                  style: TextStyle(
                                    fontSize: responsive.fontSize(
                                      mobile: 3.5,
                                      min: 14,
                                      max: 16,
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: responsive.heightPercent(3)),

                // Activity Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        context,
                        responsive,
                        icon: Icons.question_answer,
                        label: 'Questions Asked',
                        percentage: '34%',
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(width: responsive.widthPercent(4)),
                    Expanded(
                      child: _buildStatItem(
                        context,
                        responsive,
                        icon: Icons.chat_bubble_outline,
                        label: 'Answers Given',
                        percentage: '68%',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.heightPercent(2)),

                // Learning Progress
                Container(
                  padding: EdgeInsets.all(responsive.widthPercent(4)),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          color: Colors.deepPurple,
                          size: responsive.iconSize(
                            mobile: 7,
                            min: 28,
                            max: 36,
                          ),
                        ),
                      ),
                      SizedBox(width: responsive.widthPercent(3)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Learning Progress',
                              style: TextStyle(
                                fontSize: responsive.fontSize(
                                  mobile: 3.5,
                                  min: 14,
                                  max: 16,
                                ),
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: responsive.heightPercent(0.5)),
                            Text(
                              'Quick Learner',
                              style: TextStyle(
                                fontSize: responsive.fontSize(
                                  mobile: 4,
                                  min: 16,
                                  max: 18,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: responsive.iconSize(mobile: 4, min: 16, max: 20),
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    Responsive responsive, {
    required IconData icon,
    required String label,
    required String percentage,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(responsive.widthPercent(4)),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: responsive.iconSize(mobile: 5, min: 20, max: 24),
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.heightPercent(1.5)),
          Text(
            label,
            style: TextStyle(
              fontSize: responsive.fontSize(mobile: 3, min: 12, max: 14),
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: responsive.heightPercent(0.5)),
          Text(
            percentage,
            style: TextStyle(
              fontSize: responsive.fontSize(mobile: 6, min: 22, max: 28),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
