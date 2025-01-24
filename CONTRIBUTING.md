# Contributing to Ghost Browser

First off, thank you for considering contributing to Ghost Browser! It's people like you that make Ghost Browser such a great tool.

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct:

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* Use a clear and descriptive title
* Describe the exact steps which reproduce the problem
* Provide specific examples to demonstrate the steps
* Describe the behavior you observed after following the steps
* Explain which behavior you expected to see instead and why
* Include screenshots if possible
* Include your environment details (OS, Flutter version, etc.)

### Suggesting Enhancements

If you have a suggestion for the project, we'd love to hear it. Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* A clear and descriptive title
* A detailed description of the proposed feature
* Any possible drawbacks
* Screenshots or sketches if applicable

### Pull Requests

1. Fork the repo and create your branch from `main`
2. If you've added code that should be tested, add tests
3. If you've changed APIs, update the documentation
4. Ensure the test suite passes
5. Make sure your code follows the existing code style
6. Include a description of your changes

## Development Process

1. Clone the repository
```bash
git clone https://github.com/SAHILDUDHAL21/ghost_browser.git
```

2. Create a branch
```bash
git checkout -b feature/your-feature-name
```

3. Make your changes
   - Follow the [Flutter style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
   - Write meaningful commit messages
   - Keep your changes focused and atomic

4. Test your changes
```bash
flutter test
```

5. Push your changes
```bash
git push origin feature/your-feature-name
```

6. Create a Pull Request

## Style Guidelines

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

### Dart Style Guide

* Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
* Use `dart format` to format your code
* Run `flutter analyze` to check for issues

### Documentation

* Use Dart doc comments for documentation
* Keep comments up-to-date
* Document both public and private APIs
* Include examples in documentation when possible

## Project Structure

```
ghost_browser/
├── android/          # Android specific files
├── ios/             # iOS specific files
├── windows/         # Windows specific files
├── lib/
│   ├── screens/     # Screen files
│   │   ├── bookmarks.dart
│   │   ├── downloads.dart
│   │   ├── history.dart
│   │   └── settings.dart
│   └── main.dart    # Application entry point
├── assets/
│   ├── icons/       # App icons
│   └── images/      # Images and graphics
├── test/            # Test files
└── pubspec.yaml     # Dependencies and app metadata
```

## Getting Help

If you need help, you can:

* Create an issue with the "question" label
* Email the maintainers at sahildudhal21@gmail.com
* Visit YouTube channel [@SahilDudhal-zw1ls](https://youtube.com/@SahilDudhal-zw1ls)

## Recognition

Contributors who make significant improvements will be added to the README.md under the "Contributors" section.

## Additional Notes

### Issue and Pull Request Labels

* `bug`: Something isn't working
* `enhancement`: New feature or request
* `documentation`: Improvements or additions to documentation
* `good first issue`: Good for newcomers
* `help wanted`: Extra attention is needed
* `question`: Further information is requested

Thank you for contributing to Ghost Browser! 🚀

---

This guide was inspired by various open source projects and is licensed under the MIT License.
