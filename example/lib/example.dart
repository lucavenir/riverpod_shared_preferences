import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_shared_preferences/legacy.dart';

part 'example.freezed.dart';
part 'example.g.dart';
// A example showcasing LegacyJsonSharedPreferencesStorage using code generation.

@riverpod
Future<LegacyJsonSharedPreferencesStorage> storage(Ref ref) async {
  // Initialize storage. We should share the Storage instance between providers.
  final result = await LegacyJsonSharedPreferencesStorage.open();
  ref.keepAlive();
  return result;
}

/// A serializable Todo class. We're using Freezed for simple serialization.
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String description,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

@riverpod
@JsonPersist()
class TodosNotifier extends _$TodosNotifier {
  @override
  FutureOr<List<Todo>> build() async {
    // We call persist at the start of our `build` method.
    // This will:
    // - Read the DB and update the state with the persisted value the first
    //   time this method executes.
    // - Listen to changes on this provider and write those changes to the DB.
    // We "await" for persist to complete to make sure that the decoding is done
    // before we return the state.
    final storage = ref.watch(storageProvider.future);
    await persist(
      // We pass our LegacyJsonSharedPreferencesStorage instance. No need to "await" the Future.
      // Riverpod will take care of that.
      storage,
      // By default, state is cached offline only for 2 days.
      // In this example, we tell Riverpod to cache the state forever.
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
    );

    // If a state is persisted, we return it. Otherwise we return an empty list.
    return state.value ?? [];
  }

  Future<void> add(Todo todo) async {
    // When modifying the state, no need for any extra logic to persist the change.
    // Riverpod will automatically cache the new state and write it to the DB.
    state = AsyncData([...await future, todo]);
  }
}
