import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:webview_windows/webview_windows.dart' as windows;
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/history.dart';
import 'screens/settings.dart';
import 'dart:convert';
import 'screens/bookmarks.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart' as mobile;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows) {
    try {
      await windows.WebviewController.initializeEnvironment(
        userDataPath: '$Directory.current.path/webview_data',
      );
    } catch (e) {
      // Ignore if environment is already initialized
      if (!e.toString().contains('environment_already_initialized')) {
        rethrow;
      }
    }
  }
  
  runApp(const MyBrowserApp());
}

class MyBrowserApp extends StatefulWidget {
  const MyBrowserApp({super.key});

  @override
  State<MyBrowserApp> createState() => _MyBrowserAppState();
}

class _MyBrowserAppState extends State<MyBrowserApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void toggleTheme(bool value) async {
    setState(() {
      isDarkMode = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghost Browser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: WebBrowserPage(
        isDarkMode: isDarkMode,
        onThemeToggle: toggleTheme,
      ),
    );
  }
}

class WebBrowserPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  const WebBrowserPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<WebBrowserPage> createState() => _WebBrowserPageState();
}

class _WebBrowserPageState extends State<WebBrowserPage> {
  final TextEditingController urlController = TextEditingController();
  bool isLoading = true;
  dynamic _controller; // Can be either WebViewController or WebviewController
  String? _error;
  List<HistoryItem> history = [];
  int _currentIndex = 0;
  bool _isEditingUrl = false;
  List<BookmarkItem> bookmarks = [];
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _loadHistory();
    _loadBookmarks();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? historyStrings = prefs.getStringList('history');
      
      if (historyStrings != null) {
        setState(() {
          history = historyStrings.map((str) {
            try {
              return HistoryItem.fromJson(json.decode(str));
            } catch (e) {
              // Handle old format or invalid entries
              return HistoryItem(str, DateTime.now());
            }
          }).toList();
        });
      }
    } catch (e) {
      developer.log('Error loading history', error: e);
      setState(() {
        history = [];
      });
    }
  }

  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> historyStrings = history.map((item) {
        return json.encode(item.toJson());
      }).toList();
      await prefs.setStringList('history', historyStrings);
    } catch (e) {
      developer.log('Error saving history', error: e);
    }
  }

  Future<void> _addToHistory(String url) async {
    if (!history.any((item) => item.url == url)) {
      setState(() {
        history.insert(0, HistoryItem(url, DateTime.now()));
        if (history.length > 100) {
          history.removeLast();
        }
      });
      await _saveHistory();
    }
  }

  Future<void> _initPlatformState() async {
    try {
      if (Platform.isWindows) {
        await _initWindowsWebView();
      } else if (Platform.isAndroid) {
        await _initAndroidWebView();
      }
    } catch (e, stackTrace) {
      developer.log('WebView initialization error', error: e, stackTrace: stackTrace);
      setState(() {
        _error = 'Failed to initialize WebView: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _initWindowsWebView() async {
    final controller = windows.WebviewController();
    await controller.initialize();
    
    // Add custom CSS to hide trending searches
    const css = '''
      .UUbT9 { display: none !important; }     /* Trending searches */
      .aajZCb { display: none !important; }    /* Search suggestions dropdown */
      #SIvCob { display: none !important; }    /* Language options */
      .gTMtLb { display: none !important; }    /* Additional language options */
      .minidiv .sfbg { display: none !important; } /* Search box background */
      .sbct { display: none !important; }      /* Search suggestions */
      .sbsb_a { display: none !important; }    /* Suggestions container */
      .sbdd_b { display: none !important; }    /* Dropdown container */
    ''';
    
    controller.url.listen((url) {
      if (mounted) {
        setState(() {
          if (url != 'https://google.com' && url != 'https://www.google.com') {
            urlController.text = url;
          } else {
            urlController.text = '';
          }
          isLoading = false;
        });
        _checkIfBookmarked(url);
      }
    });

    await controller.setBackgroundColor(Colors.transparent);
    await controller.setPopupWindowPolicy(windows.WebviewPopupWindowPolicy.deny);
    await controller.loadUrl('https://google.com');
    
    // Inject CSS after page load
    await controller.executeScript('''
      var style = document.createElement('style');
      style.textContent = `${css}`;
      document.head.appendChild(style);
    ''');

    if (mounted) {
      setState(() {
        _controller = controller;
        isLoading = false;
      });
    }
  }

  Future<void> _initAndroidWebView() async {
    final controller = mobile.WebViewController();
    
    await controller.setJavaScriptMode(mobile.JavaScriptMode.unrestricted);
    await controller.setNavigationDelegate(
      mobile.NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (String url) async {
          // Inject CSS to hide trending searches
          await controller.runJavaScript('''
            var style = document.createElement('style');
            style.textContent = `
              .UUbT9 { display: none !important; }     /* Trending searches */
              .aajZCb { display: none !important; }    /* Search suggestions dropdown */
              #SIvCob { display: none !important; }    /* Language options */
              .gTMtLb { display: none !important; }    /* Additional language options */
              .minidiv .sfbg { display: none !important; } /* Search box background */
              .sbct { display: none !important; }      /* Search suggestions */
              .sbsb_a { display: none !important; }    /* Suggestions container */
              .sbdd_b { display: none !important; }    /* Dropdown container */
            `;
            document.head.appendChild(style);
          ''');
          
          setState(() {
            isLoading = false;
            if (url != 'https://google.com' && url != 'https://www.google.com') {
              urlController.text = url;
            } else {
              urlController.text = '';
            }
          });
          _checkIfBookmarked(url);
        },
      ),
    );
    
    await controller.loadRequest(Uri.parse('https://google.com'));

    setState(() {
      _controller = controller;
    });
  }

  Widget _buildWebView() {
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (Platform.isWindows) {
      return windows.Webview(_controller as windows.WebviewController);
    } else if (Platform.isAndroid) {
      return mobile.WebViewWidget(controller: _controller as mobile.WebViewController);
    }

    return const Center(
      child: Text('Platform not supported'),
    );
  }

  Future<void> _loadUrl(String url) async {
    if (url.isEmpty || _controller == null) return;

    try {
      setState(() {
        isLoading = true;
        _error = null;
      });

      String fullUrl = url;
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        // Check if it's a search query or direct URL
        if (url.contains('.') && !url.contains(' ')) {
          fullUrl = 'https://$url';
        } else {
          // Encode the search query
          fullUrl = 'https://www.google.com/search?q=${Uri.encodeComponent(url)}';
        }
      }

      if (Platform.isWindows) {
        await (_controller as windows.WebviewController).loadUrl(fullUrl);
      } else {
        await (_controller as mobile.WebViewController)
            .loadRequest(Uri.parse(fullUrl));
      }

      await _addToHistory(fullUrl);
      _checkIfBookmarked(fullUrl);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      developer.log('URL loading error', error: e);
      setState(() {
        _error = 'Failed to load URL: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? bookmarkStrings = prefs.getStringList('bookmarks');
      
      if (bookmarkStrings != null) {
        setState(() {
          bookmarks = bookmarkStrings.map((str) {
            try {
              return BookmarkItem.fromJson(json.decode(str));
            } catch (e) {
              return BookmarkItem(str, 'Untitled', DateTime.now());
            }
          }).toList();
        });
      }
    } catch (e) {
      developer.log('Error loading bookmarks', error: e);
    }
  }

  Future<void> _saveBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> bookmarkStrings = bookmarks.map((item) {
        return json.encode(item.toJson());
      }).toList();
      await prefs.setStringList('bookmarks', bookmarkStrings);
    } catch (e) {
      developer.log('Error saving bookmarks', error: e);
    }
  }

  void _toggleBookmark() async {
    if (_controller == null) return;
    
    final currentUrl = urlController.text;
    if (currentUrl.isEmpty) return;

    final exists = bookmarks.any((item) => item.url == currentUrl);
    
    setState(() {
      if (exists) {
        bookmarks.removeWhere((item) => item.url == currentUrl);
        isBookmarked = false;
      } else {
        bookmarks.insert(0, BookmarkItem(
          currentUrl,
          currentUrl, // You can add page title here if available
          DateTime.now(),
        ));
        isBookmarked = true;
      }
    });
    
    await _saveBookmarks();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exists ? 'Bookmark removed' : 'Bookmark added'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _checkIfBookmarked(String url) {
    setState(() {
      isBookmarked = bookmarks.any((item) => item.url == url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.95),
        elevation: 0,
        toolbarHeight: 56,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, size: 20),
              onPressed: () {
                _loadUrl('https://google.com');
                urlController.clear();
              },
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(),
            ),
            Expanded(
              child: Container(
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    hintText: 'Search or enter website',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    suffixIcon: isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(4),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.refresh, size: 16),
                          onPressed: _controller?.reload,
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                        ),
                  ),
                  onSubmitted: (url) {
                    if (url.isEmpty) {
                      _loadUrl('https://google.com');
                    } else {
                      _loadUrl(url);
                    }
                  },
                ),
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.share_outlined, size: 20),
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'copy',
                  child: Row(
                    children: [
                      Icon(Icons.copy, size: 20),
                      SizedBox(width: 8),
                      Text('Copy URL'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share, size: 20),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) async {
                final url = urlController.text;
                if (url.isEmpty) return;

                switch (value) {
                  case 'copy':
                    await Clipboard.setData(ClipboardData(text: url));
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('URL copied to clipboard'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    break;
                  case 'share':
                    try {
                      await Share.share(
                        url,
                        subject: 'Check out this website',
                      );
                    } catch (e) {
                      developer.log('Error sharing URL', error: e);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to share URL'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                    break;
                }
              },
            ),
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
                size: 20,
              ),
              onPressed: _toggleBookmark,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        titleSpacing: 8,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              _buildWebView(),
              BookmarksPage(
                bookmarks: bookmarks,
                onUrlSelect: (url) {
                  setState(() {
                    _currentIndex = 0; // Switch back to browser tab
                  });
                  _loadUrl(url);
                },
                onDeleteBookmark: (index) async {
                  setState(() {
                    bookmarks.removeAt(index);
                  });
                  await _saveBookmarks();
                },
              ),
              HistoryPage(
                history: history,
                onUrlSelect: _loadUrl,
                onDeleteItem: (index) async {
                  setState(() {
                    history.removeAt(index);
                  });
                  await _saveHistory();
                },
              ),
              SettingsPage(
                isDarkMode: widget.isDarkMode,
                onThemeToggle: widget.onThemeToggle,
                onClearHistory: () async {
                  setState(() {
                    history.clear();
                  });
                  await _saveHistory();
                },
                version: '1.0.0',
              ),
            ],
          ),
          // URL Input Field (hidden by default, shown when tab bar is tapped)
          if (_isEditingUrl)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: urlController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search or enter website',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _isEditingUrl = false;
                        });
                      },
                    ),
                  ),
                  onSubmitted: (url) {
                    _loadUrl(url);
                    setState(() {
                      _isEditingUrl = false;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 18,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.web_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.web),
              ),
              label: 'Browser',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.bookmark_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.bookmark),
              ),
              label: 'Bookmarks',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.history_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.history),
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.settings_outlined),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.settings),
              ),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    urlController.dispose();
    if (_controller != null) {
      if (Platform.isWindows) {
        (_controller as windows.WebviewController).dispose();
      }
    }
    super.dispose();
  }
}
