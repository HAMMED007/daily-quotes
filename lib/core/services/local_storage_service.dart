import 'package:shared_preferences/shared_preferences.dart';

import '../others/logger_customizations/custom_logger.dart';

class LocalStorageService {
  final log = CustomLogger(className: 'Local Storage Service');
  static SharedPreferences? _preferences;

  ///
  /// List of const keys
  ///

  static const String notificationsCountKey = 'notificationsCount';
  static const String newRandomQuoteIndexofTheDayKey =
      'newRandomQuoteIndexofTheDay';
  static const String lastDateOfTheDayQuoteKey = 'lastDateOfTheDayQuote';
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';

  ///
  /// Setters and getters
  ///
  int get newRandomQuoteIndexofTheDay =>
      _getFromDisk(newRandomQuoteIndexofTheDayKey) ?? 0;
  set newRandomQuoteIndexofTheDay(int index) =>
      _saveToDisk(newRandomQuoteIndexofTheDayKey, index);

  String get lastDateOfTheDayQuote =>
      _getFromDisk(lastDateOfTheDayQuoteKey) ?? '2022-11-19 12:42:27.612519';
  set lastDateOfTheDayQuote(String date) =>
      _saveToDisk(lastDateOfTheDayQuoteKey, date);

  int get setNotificationsCount => _getFromDisk(notificationsCountKey) ?? 0;
  set setNotificationsCount(int count) =>
      _saveToDisk(notificationsCountKey, count);

  dynamic get accessToken => _getFromDisk(accessTokenKey);
  set accessToken(token) => _saveToDisk(accessTokenKey, token);

  dynamic get refreshToken => _getFromDisk(refreshTokenKey);

  ///
  ///initializing instance
  ///
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    log.d('@_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T? content) {
    log.d('@_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }

    if (content == null) {
      _preferences!.remove(key);
    }
  }
}
