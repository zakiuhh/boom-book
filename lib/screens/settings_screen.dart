import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onThemeChanged;
  final String currentTheme;
  final VoidCallback onUsernameChanged;

  const SettingsScreen({
    Key? key,
    required this.onThemeChanged,
    required this.currentTheme,
    required this.onUsernameChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _username;
  String _fontSize = 'medium';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final username = await StorageService.loadUsername();
    final fontSize = await StorageService.loadFontSize();
    setState(() {
      _username = username;
      _fontSize = fontSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // User Settings Section
        const Text(
          'User Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildCard(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Username'),
            subtitle: Text(_username ?? 'Not set'),
            trailing: const Icon(Icons.edit),
            onTap: _showUsernameDialog,
          ),
        ),

        const SizedBox(height: 24),

        // App Preferences Section
        const Text(
          'App Preferences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('Theme'),
                subtitle: Text(_getThemeName(widget.currentTheme)),
                trailing: const Icon(Icons.chevron_right),
                onTap: _showThemeDialog,
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Default Font Size'),
                subtitle: Text(_getFontSizeName(_fontSize)),
                trailing: const Icon(Icons.chevron_right),
                onTap: _showFontSizeDialog,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Data Management Section
        const Text(
          'Data Management',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildCard(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.restart_alt, color: Colors.orange[700]),
                title: const Text('Reset All Progress'),
                subtitle: const Text('Clear all reading progress and statistics'),
                onTap: () => _showResetDialog('all'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.bookmark_remove, color: Colors.orange[700]),
                title: const Text('Clear Bookmarks'),
                subtitle: const Text('Remove all saved bookmarks'),
                onTap: () => _showResetDialog('bookmarks'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.bar_chart, color: Colors.orange[700]),
                title: const Text('Reset Statistics'),
                subtitle: const Text('Clear all reading statistics'),
                onTap: () => _showResetDialog('statistics'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  String _getThemeName(String theme) {
    switch (theme) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      case 'sepia':
        return 'Sepia';
      default:
        return 'Light';
    }
  }

  String _getFontSizeName(String size) {
    switch (size) {
      case 'small':
        return 'Small';
      case 'medium':
        return 'Medium';
      case 'large':
        return 'Large';
      default:
        return 'Medium';
    }
  }

  void _showUsernameDialog() {
    final TextEditingController controller =
        TextEditingController(text: _username);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Username'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter new username',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await StorageService.saveUsername(controller.text.trim());
                setState(() {
                  _username = controller.text.trim();
                });
                widget.onUsernameChanged();
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption('Light', 'light'),
            _buildThemeOption('Dark', 'dark'),
            _buildThemeOption('Sepia', 'sepia'),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String name, String value) {
    return RadioListTile<String>(
      title: Text(name),
      value: value,
      groupValue: widget.currentTheme,
      onChanged: (selected) {
        if (selected != null) {
          widget.onThemeChanged(selected);
          Navigator.pop(context);
        }
      },
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Font Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFontSizeOption('Small', 'small'),
            _buildFontSizeOption('Medium', 'medium'),
            _buildFontSizeOption('Large', 'large'),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeOption(String name, String value) {
    return RadioListTile<String>(
      title: Text(name),
      value: value,
      groupValue: _fontSize,
      onChanged: (selected) async {
        if (selected != null) {
          await StorageService.saveFontSize(selected);
          setState(() {
            _fontSize = selected;
          });
          Navigator.pop(context);
        }
      },
    );
  }

  void _showResetDialog(String type) {
    String title;
    String content;

    switch (type) {
      case 'all':
        title = 'Reset All Progress?';
        content =
            'This will reset all reading progress, bookmarks, and statistics. This action cannot be undone.';
        break;
      case 'bookmarks':
        title = 'Clear All Bookmarks?';
        content =
            'This will remove all saved bookmarks from all books. This action cannot be undone.';
        break;
      case 'statistics':
        title = 'Reset Statistics?';
        content =
            'This will clear all reading statistics and time tracking data. This action cannot be undone.';
        break;
      default:
        return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              switch (type) {
                case 'all':
                  await StorageService.resetAllProgress();
                  break;
                case 'bookmarks':
                  await StorageService.clearAllBookmarks();
                  break;
                case 'statistics':
                  final emptyStats = await StorageService.loadStatistics();
                  await StorageService.saveStatistics(emptyStats);
                  break;
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${_getResetTypeName(type)} completed')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  String _getResetTypeName(String type) {
    switch (type) {
      case 'all':
        return 'Reset all progress';
      case 'bookmarks':
        return 'Clear bookmarks';
      case 'statistics':
        return 'Reset statistics';
      default:
        return 'Reset';
    }
  }
}
