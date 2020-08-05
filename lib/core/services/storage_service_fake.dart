import 'package:flutter_foodybite/core/services/storageservice.dart';

class StorageServiceFake extends StorageService {
  int value = 0;
  @override
  Future<int> getCounterValue() async {
    return value;
  }

  @override
  Future<void> saveCounterValue(int value) async {
    this.value = value;
  }

  @override
  Future<int> getNavigateHelperState() {
    // TODO: implement getNavigateHelperState
    throw UnimplementedError();
  }

  @override
  Future<void> saveNavigatorHelperState(int value) {
    // TODO: implement saveNavigatorHelperState
    throw UnimplementedError();
  }
}
