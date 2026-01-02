import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Logo/Icon
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '📚',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Boom',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // App Description
          _buildSection(
            title: 'About Boom',
            content:
                'Boom is a beautiful book reading application featuring 10 pre-loaded classic literature books. Immerse yourself in timeless stories with a customizable reading experience, track your progress, and build lasting reading habits.',
          ),

          const SizedBox(height: 24),

          // Features
          _buildSection(
            title: 'Features',
            content: '• 10 Pre-loaded Classic Books\n'
                '• Customizable Reading Experience\n'
                '• Multiple Themes (Light, Dark, Sepia)\n'
                '• Adjustable Font Sizes\n'
                '• Bookmarks & Progress Tracking\n'
                '• Detailed Reading Statistics\n'
                '• Beautiful & Intuitive Interface',
          ),

          const SizedBox(height: 24),

          // Developer Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Developer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.person, 'Zaki Ul Hassan'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.code, 'zakiuhh'),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                      const ClipboardData(text: 'zakiulhassan105@gmail.com'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: _buildInfoRow(
                    Icons.email,
                    'zakiulhassan105@gmail.com',
                    isLink: true,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Privacy Statement
          _buildSection(
            title: 'Privacy',
            content:
                'Boom respects your privacy. All your reading data, bookmarks, and preferences are stored locally on your device. We do not collect, store, or share any personal information. Your reading journey is completely private and secure.',
          ),

          const SizedBox(height: 32),

          // Copyright
          Center(
            child: Text(
              '© 2024 Boom. All rights reserved.\nMade with ❤️ for book lovers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isLink = false}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isLink ? Colors.blue : Colors.grey[700],
              decoration: isLink ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}
