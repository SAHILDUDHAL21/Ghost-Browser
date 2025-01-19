import 'package:flutter/material.dart';

class BookmarkItem {
  final String url;
  final String title;
  final DateTime timestamp;

  BookmarkItem(this.url, this.title, this.timestamp);

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory BookmarkItem.fromJson(Map<String, dynamic> json) {
    return BookmarkItem(
      json['url'] as String,
      json['title'] as String? ?? 'Untitled',
      DateTime.parse(json['timestamp'] as String),
    );
  }
}

class BookmarksPage extends StatelessWidget {
  final List<BookmarkItem> bookmarks;
  final Function(String) onUrlSelect;
  final Function(int) onDeleteBookmark;
  
  const BookmarksPage({
    super.key,
    required this.bookmarks,
    required this.onUrlSelect,
    required this.onDeleteBookmark,
  });

  @override
  Widget build(BuildContext context) {
    if (bookmarks.isEmpty) {
      return const Center(
        child: Text('No bookmarks yet'),
      );
    }

    return ListView.builder(
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarks[index];
        return ListTile(
          leading: const Icon(Icons.bookmark),
          title: Text(
            bookmark.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            bookmark.url,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          onTap: () {
            if (bookmark.url.isNotEmpty) {
              onUrlSelect(bookmark.url);
            }
          },
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDeleteBookmark(index),
          ),
        );
      },
    );
  }
} 