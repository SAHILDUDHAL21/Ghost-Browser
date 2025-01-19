import 'package:flutter/material.dart';
import 'downloads.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;
  final VoidCallback onClearHistory;
  final String version;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onClearHistory,
    this.version = '1.0.0',
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('Dark Mode'),
          subtitle: const Text('Toggle dark/light theme'),
          trailing: Switch(
            value: isDarkMode,
            onChanged: onThemeToggle,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Downloads'),
          subtitle: const Text('View downloaded files'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DownloadsPage(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Clear History'),
          subtitle: const Text('Clear browsing history'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Clear History'),
                content: const Text('Are you sure you want to clear all browsing history?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      onClearHistory();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('History cleared')),
                      );
                    },
                    child: const Text('CLEAR'),
                  ),
                ],
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          subtitle: Text('Version $version'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Ghost Browser',
              applicationVersion: version,
              applicationIcon: const Icon(Icons.web, size: 50),
              children: [
                const Text('A lightweight FOSS (Free & Open Source) Web Browser built with Flutter'),
                const Text('  '),
                const Text('Developers :' ,style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),),
                const Text('• Sahil Dudhal'),
                const Text('• Pratik Kawadwale'),
                const SizedBox(height: 15),
                const Text('Features :' ,style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),),
                const Text('• Top Level Privary'),
                const Text('• Dark mode support'),
                const Text('• Browsing history'),
                const Text('• Clean interface'),
              ],
            );
          },
        ),
      ],
    );
  }
} 