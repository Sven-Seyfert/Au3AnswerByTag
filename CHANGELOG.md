#####

# Changelog

All notable changes to "Au3AnswerByTag" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Go to [legend](#legend---types-of-changes) for further information about the types of changes.

## [Unreleased]

## [0.3.0] - 2022-03-10

### Changed

- Go back to MS Outlook window after copy action instead of previous window.
- Version bump.

### Fixed

- Adding signature multiple times for copy action (guard checks for exists state).

## [0.2.0] - 2022-03-09

### Added

- Toggle for show or hide additional message boxes before save or update actions.
- Toggle for the minimize or not minimize the program after the copy action.
- Functionality of append a defined signature to the answer when copy action is triggered.
- Reload button for the list of tags.
- Auto-completion (type in the search tag) functionality to the dropdown "List of tags".
- Additional question (message box) in case of opening the config file.

### Changed

- GUI design for better user experience.
- Keyboard shortcuts to show the GUI, to copy the answer and to reload the list of tags.
- Starting behavior of the program. It starts in the background and will popup by the shortcut `Ctrl+1`.
- Update the Quill Editor version from v1.3.6 to v1.3.7.

### Fixed

- Known [issue](https://github.com/quilljs/quill/issues/861) of Quill Rich Text Editor about the default block tag.
- Work-around of SQLite bug regarding database not found exception.

## [0.1.0] - 2022-03-02

### Added

- All repository data and dependencies.

[Unreleased]: https://github.com/Sven-Seyfert/Au3AnswerByTag/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/Sven-Seyfert/Au3AnswerByTag/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/Sven-Seyfert/Au3AnswerByTag/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/Sven-Seyfert/Au3AnswerByTag/releases/tag/v0.1.0

---

### Legend - Types of changes

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Fixed` for any bug fixes.
- `Removed` for now removed features.
- `Security` in case of vulnerabilities.

##

[To the top](#)
