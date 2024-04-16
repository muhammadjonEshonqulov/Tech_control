import 'dart:convert';

import '../../utils/api_helper.dart';
import '../../utils/network_result.dart';

class NetworkClient {
  final apiHelper = ApiHelper();

  Future<NetworkResult<Map<String, dynamic>>> login(userName, password) async {
    return apiHelper.myPost("auth/login", json.encode({"login": userName, "password": password}));
  }

  Future<NetworkResult<Map<String, dynamic>>> me() async {
    return apiHelper.myGet("auth/me", {});
  }

  Future<NetworkResult<Map<String, dynamic>>> getAdditional(techId) async {
    return apiHelper.myGet("api/techniques/additional", {"techId": techId});
  }

  Future<NetworkResult<Map<String, dynamic>>> updateTech(techId, eligibility) async {
    return apiHelper.myPatch("api/techniques/$techId", json.encode({"eligibility": eligibility}));
  }

  Future<NetworkResult<Map<String, dynamic>>> updateTechAddition(additionId, condition, status) async {
    return apiHelper.myPatch("api/techniques/additional/$additionId", json.encode({"status": status,"condition":condition}));
  }
}
