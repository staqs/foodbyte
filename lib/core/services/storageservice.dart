abstract class StorageService {
  Future<int> getCounterValue();
  Future<void> saveCounterValue(int value);
  Future<int> getNavigateHelperState();
  Future<void> saveNavigatorHelperState(int value);
}
