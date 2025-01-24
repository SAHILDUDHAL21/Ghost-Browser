# Ghost Browser

<p align="center">
  <img src="assets/icon.png" alt="Ghost Browser Logo" width="200" style="border-radius: 30px;"/>
</p>

A lightweight, privacy-focused FOSS (Free & Open Source Software) web browser built with Flutter. Ghost Browser provides a clean and intuitive interface while prioritizing user privacy and performance.

## 🚀 Features

- 🔒 **Privacy Focused**: No tracking, no telemetry, just pure browsing
- 🌙 **Dark Mode**: Comfortable browsing in low-light conditions
- 📚 **Bookmarks**: Save and organize your favorite websites
- 📝 **History**: Track your browsing history with easy management
- 🔍 **Clean Interface**: Minimalist design for distraction-free browsing
- 📱 **Cross Platform**: Supports both Windows and Android

### 📥 Download

You can download the latest release from our [GitHub Releases](https://github.com/SAHILDUDHAL21/Ghost-Browser/releases) page:

  #### 🪟 Windows

[<img src="https://github.com/machiav3lli/oandbackupx/blob/034b226cea5c1b30eb4f6a6f313e4dadcbb0ece4/badge_github.png"
alt="Get it on GitHub"
height="80">](https://github.com/SAHILDUDHAL21/Ghost-Browser/releases/download/v1.0.0/Ghost.Browser.windows.exe)

  #### 🤖 Android

[<img src="https://github.com/machiav3lli/oandbackupx/blob/034b226cea5c1b30eb4f6a6f313e4dadcbb0ece4/badge_github.png"
alt="Get it on GitHub" 
height="80">](https://github.com/SAHILDUDHAL21/Ghost-Browser/releases/download/v1.0.0/Ghost-Browser-release.apk)


## 📱 Screenshots & Demo

<p align="center">
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/home-dark.png" width="200" alt="Home Screen"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/home.png" width="200" alt="Home Screen"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/search.png" width="200" alt="Search Results"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/history.png" width="200" alt="History"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/bookmarks.png" width="200" alt="Bookmarks"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/settings.png" width="200" alt="Settings"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/web.png" width="200" alt="web"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/web2.png" width="200" alt="web2"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/clear-history.png" width="200" alt="clear-history"/>
  <img src="https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/assets/Screenshots/about.png" width="200" alt="about"/>
</p>

### 🎥 Video Demo
<p align="center">
  <iframe 
    width="600" 
    height="338"
    src="https://www.youtube.com/embed/Jp84YNBkZHM?autoplay=1&mute=1&controls=1&loop=1"
    title="Ghost Browser Demo"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen
    style="border-radius: 25px;"
  ></iframe>
</p>

### 📖 More Details
For a detailed breakdown of the project and development insights, check out my [LinkedIn post]() about building this app.

## 🖥️ Installation

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
- Run in development mode

### 🔧 Troubleshooting

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


## 📚 Technical Details

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

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please read our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 🧑‍🤝‍🧑 Development Team

- **Sahil Dudhal** - [GitHub](https://github.com/SAHILDUDHAL21)
- **Pratik Kawadwale** - [GitHub](https://github.com/pratikkawadwale)

## 📜 Version History

- v1.0.0 (2024-01)
  - Initial release
  - Basic browsing functionality
  - Bookmarks and history
  - Dark mode support

## 🔮 Future Features Implementation

- [ ] Ad blocking support
- [ ] Cross-device sync
- [ ] Password manager
- [ ] Custom themes
- [ ] Tab groups

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/SAHILDUDHAL21/Ghost-Browser/blob/main/LICENSE) file for details.

## 🔒 Privacy Policy

Ghost Browser is committed to user privacy:

- No data collection
- No telemetry
- No user tracking
- All data stored locally
- No third-party analytics

## 📞 Support

Need help? Here's how to reach us:

- Create an [Issue](https://github.com/SAHILDUDHAL21/Ghost-Browser/issues)
- YouTube: [@SahilDudhal-zw1ls](https://youtube.com/@SahilDudhal-zw1ls)

## 🤝 Acknowledgments

- Flutter team for the amazing framework
- All our contributors
- The open-source community

---

<p align="center">
  Made with ❤️ by Team Ghost Browser
  <br>
  <a href="https://github.com/SAHILDUDHAL21/Ghost-Browser/stargazers">⭐ Star us on GitHub</a>
</p>
