Say Hi to riverpod_shared_preferences!

This is an implementation of offline-persistence in Riverpod
using (shared_preferences)[].

## Usage

First, you need to create the connector to shared preferences.
This can be done by creating a storageProvider:
```dart
// e.g. using old `SharedPreferences` APIs
final storageProvider = FutureProvider<LegacyJsonSharedPreferencesStorage>((ref) async {
  // Initialize SharedPreferences. We should share the Storage instance between providers.
  final sharedPreferences = await SharedPreferences.getInstance();
  // Initializing and passing SharedPreferences is optional.
  // If you don't provide it, the storage will create its own instance
  final storage = await LegacyJsonSharedPreferencesStorage.open(sharedPreferences);
  ref.keepAlive();  // I mean, why not
  return storage;
});
```

Then, as always create your state:
- write a `Notifier`
- mix-in `Persistable`
- invoke `persist` inside `Notifier.build`
```dart
class TodosNotifier extends AsyncNotifier<List<Todo>> {
  @override
  FutureOr<List<Todo>> build() async {
    // We call persist at the start of our `build` method.
    // This will:
    // - Read the DB and update the state with the persisted value the first
    //   time this method executes.
    // - Listen to changes on this provider and write those changes to the DB.
    // We "await" for persist to complete to make sure that the decoding is done
    // before we return the state.
    // If you do not care about the decoded value, don't await the future.
    await persist(
      // We pass our JsonSqFliteStorage instance. No need to "await" the Future.
      // Riverpod will take care of that.
      ref.watch(storageProvider.future),
      // A unique key for this state.
      // No other provider should use the same key.
      key: 'todos',
      // By default, state is cached offline only for 2 days.
      // In this example, we tell Riverpod to cache the state forever.
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: jsonEncode,
      decode: (json) {
        final decoded = jsonDecode(json) as List;
        return decoded
            .map((e) => Todo.fromJson(e as Map<String, Object?>))
            .toList();
      },
    ).future;

    // If a state is persisted, we return it. Otherwise we return an empty list.
    return state.value ?? [];
  }

  Future<void> add(Todo todo) async {
    // When modifying the state, no need for any extra logic to persist the change.
    // Riverpod will automatically cache the new state and write it to the DB.
    state = AsyncData([...await future, todo]);
  }
}
```
