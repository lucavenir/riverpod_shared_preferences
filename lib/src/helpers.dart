import 'package:clock/clock.dart';

typedef RiverpodSharedPreferencesHelpersTypedef = Never;

extension Helpers on RiverpodSharedPreferencesHelpersTypedef {
  static DateTime? computeExpirationTime({required Duration? ttl}) {
    if (ttl == null) return null;
    return clock.now().toUtc().add(ttl);
  }

  static String computeRiverpodKey(String key) {
    if (key.isEmpty) {
      throw ArgumentError(
        "key must not be empty; "
        "please provide a valid key so that it can be stored with `riverpod_shared_preferences`",
      );
    }
    if (key.contains('§')) {
      throw ArgumentError(
        "key '$key' contains a reserved character: '$_separator'; "
        "please use a key without such symbol, as `riverpod_shared_preferences` does not support it.",
      );
    }
    return '$_prefix$key';
  }

  static const String _separator = '§';
  static const String _prefix = 'riverpod$_separator';
}
