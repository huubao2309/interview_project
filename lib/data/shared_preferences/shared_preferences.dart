import 'package:shared_preferences/shared_preferences.dart';

// ignore: slash_for_doc_comments
/**
 * MissingPluginException(No implementation found for method getAll on channel flutter: plugins.flutter.io/shared_preferences)
 * >>> https://github.com/renefloor/flutter_cached_network_image/issues/50
 *
 * cách fix:
    // ignore: slash_for_doc_comments
    Run Flutter clean (or remove your build manually)
    if u are on IOS run pod install
    and then => Flutter run
 */
class SPref {
  SPref._internal();

  static final SPref instance = SPref._internal();

  Future set(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  dynamic get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  dynamic getOrDefault(String key, Object defaultValue) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? defaultValue;
  }
}
