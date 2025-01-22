# Ghost Browser

<p align="center">
  <img src="assets/icon.png" alt="Ghost Browser Logo" width="200"/>
</p>

A lightweight, privacy-focused FOSS (Free & Open Source Software) web browser built with Flutter. Ghost Browser provides a clean and intuitive interface while prioritizing user privacy and performance.

## Features

- 🔒 **Privacy Focused**: No tracking, no telemetry, just pure browsing
- 🌙 **Dark Mode**: Comfortable browsing in low-light conditions
- 📚 **Bookmarks**: Save and organize your favorite websites
- 📝 **History**: Track your browsing history with easy management
- 🔍 **Clean Interface**: Minimalist design for distraction-free browsing
- 📱 **Cross Platform**: Supports both Windows and Android

## Screenshots

[You can add screenshots of your app here]

## Installation

### Prerequisites
- Flutter SDK (>=3.1.4)
- Android Studio / VS Code
- Git

### Building from Source

1. Clone the repository

2. Install dependencies

3. Configure platform-specific setup

#### For Android:
- Enable Developer Options and USB Debugging on your device
- Connect your device or start an emulator

#### For Windows:
- Install Visual Studio 2019 or later with Desktop development with C++
- Install Windows 11 SDK

4. Run in development mode

### Troubleshooting

If you encounter any issues during the build process:

1. Clean the build cache:
```bash
flutter clean
flutter pub get
```

2. Update Flutter:
```bash
flutter upgrade
flutter doctor
```

3. Common issues:
- Android SDK not found: Set `ANDROID_SDK_ROOT` environment variable
- Windows build fails: Install Visual Studio C++ build tools
- Gradle sync fails: Check your internet connection and try `flutter pub get`

### Download

You can download the latest release from our [GitHub Releases](https://github.com/sahildudhal/ghost_browser/releases) page:

- [Download APK](https://github.com/sahildudhal/ghost_browser/releases/latest) (Android)
- [Download EXE](https://github.com/sahildudhal/ghost_browser/releases/latest) (Windows)

## Technical Details

### Architecture
- Built with Flutter 3.x
- Uses WebView for rendering web pages
- Implements Material Design 3
- Local storage for bookmarks and history
- Cross-platform support (Windows & Android)

### Dependencies
- webview_flutter: ^4.4.2
- webview_windows: ^0.2.0
- shared_preferences: ^2.2.2
- share_plus: ^7.2.1
- url_launcher: ^6.2.1

## Contributing

We welcome contributions! Here's how you can help:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please read our [Contributing Guidelines](CONTRIBUTING.md) for details.

## Development Team

- **Sahil Dudhal** - *Lead Developer* - [GitHub](https://github.com/sahildudhal)
- **Pratik Kawadwale** - *Core Developer* - [GitHub](https://github.com/pratikkawadwale)

## Version History

- v1.0.0 (2024-01)
  - Initial release
  - Basic browsing functionality
  - Bookmarks and history
  - Dark mode support

## Roadmap

- [ ] Ad blocking support
- [ ] Cross-device sync
- [ ] Password manager
- [ ] Extensions support
- [ ] Custom themes
- [ ] Tab groups

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Privacy Policy

Ghost Browser is committed to user privacy:

- No data collection
- No telemetry
- No user tracking
- All data stored locally
- No third-party analytics

## Support

Need help? Here's how to reach us:

- Create an [Issue](https://github.com/sahildudhal/ghost_browser/issues)
- Email: sahildudhal@gmail.com
- Join our [Discord](https://discord.gg/ghostbrowser)

## Acknowledgments

- Flutter team for the amazing framework
- All our contributors
- The open-source community

---

<p align="center">
  Made with ❤️ by Team Ghost Browser
  <br>
  <a href="https://github.com/sahildudhal/ghost_browser/stargazers">⭐ Star us on GitHub</a>
</p>