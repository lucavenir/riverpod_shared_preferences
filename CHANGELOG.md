## 0.0.3
- changelog ordering was wrong, silly me!
- reverted the optional `SharedPreferences` param change

## 0.0.2

- `LegacyJsonSharedPreferencesStorage.open` now accepts an optional `SharedPreferences` instance to initialize with
- avoid calling `deleteOutOfDate` twice on startup
- removed some useless API, marked as @internal stuff we don't want to export
- applied linting to the project
- added a few inline docs
- added a proper README

## 0.0.1

- Initial version
