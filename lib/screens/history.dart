import 'package:flutter/material.dart';

class HistoryItem {
  final String url;
  final DateTime timestamp;

  HistoryItem(this.url, this.timestamp);

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryItem(
        json['url'] as String,
        DateTime.parse(json['timestamp'] as String),
      );
    } catch (e) {
      // Fallback for invalid data
      return HistoryItem(
        json['url'] as String? ?? 'Unknown URL',
        DateTime.now(),
      );
    }
  }
}

class HistoryPage extends StatelessWidget {
  final List<HistoryItem> history;
  final Function(String) onUrlSelect;
  final Function(int) onDeleteItem;
  
  const HistoryPage({
    super.key,
    required this.history,
    required this.onUrlSelect,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(
        child: Text('No browsing history'),
      );
    }

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(
            item.url,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _formatDate(item.timestamp),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          onTap: () => onUrlSelect(item.url),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDeleteItem(index),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    }
  }
} 