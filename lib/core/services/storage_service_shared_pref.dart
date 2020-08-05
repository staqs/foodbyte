import 'package:shared_preferences/shared_preferences.dart';
import 'storageservice.dart';

class StorageServiceSharedPreferences extends StorageService {
  @override
  Future<int> getCounterValue() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('counter_int_key'));
    return prefs.getInt('counter_int_key') ?? 0;
  }

  @override
  Future<void> saveCounterValue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter_int_key', value);
  }

  @override
  Future<int> getNavigateHelperState() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('navigator_int_key'));
    return prefs.getInt('navigator_int_key') ?? 0;
  }

  @override
  Future<void> saveNavigatorHelperState(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('navigator_int_key', value);
  }
}
