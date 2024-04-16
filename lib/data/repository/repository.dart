import 'dart:core';

import '../../utils/network_result.dart';
import '../network/network_client.dart';

class Repository {
  NetworkClient networkClient;

  // MyDao myDao;

  Repository({required this.networkClient});

  Future<NetworkResult<Map<String, dynamic>>> login(String userName, String password) async {
    var loginResponse = await networkClient.login(userName, password);
    return loginResponse;
  }

  Future<NetworkResult<Map<String, dynamic>>> getAdditional(techId) async {
    var getAdditionalResponse = await networkClient.getAdditional(techId);
    return getAdditionalResponse;
  }

  Future<NetworkResult<Map<String, dynamic>>> updateTech(techId, eligibility) async {
    var getAdditionalResponse = await networkClient.updateTech(techId, eligibility);
    return getAdditionalResponse;
  }

  Future<NetworkResult<Map<String, dynamic>>> updateTechAddition(additionId, eligibility, status) async {
    var getAdditionalResponse = await networkClient.updateTechAddition(additionId, eligibility, status);
    return getAdditionalResponse;
  }

// Future<List<TypeData>> getAllTypeData() async {
//   var databaseList = await myDao.getAllTypeData();
//   return databaseList;
// }
//
// Future<void> insertTypeData(List<TypeData> data) async {
//   await myDao.insertTypeData(data);
// }
//
// Future<void> deleteTypeData() async {
//   await myDao.deleteTypeData();
// }
}
