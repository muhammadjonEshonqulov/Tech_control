import 'package:flutter/cupertino.dart';
import 'package:tech_control/utils/network_result.dart';
import 'package:tech_control/utils/utils.dart';

import '../data/repository/repository.dart';

class AdditionalProvider extends ChangeNotifier {
  // var dbHelper = DBHelper();
  // List<WallpaperModel> wallpapers = [];
  // List<WallpaperModel> favorites = [];
  // List<WallpaperModel> searchWallpapers = [];
  String token = "";
  Repository repository;
  NetworkResult state;
  String status = "";
  String eligibility = "";

  AdditionalProvider(this.repository, this.state);

  void getAdditional(techId) async {
    var data = await repository.getAdditional(techId);
    state = data;
    notifyListeners();
  }

  void updateTech(techId, eligibility) async {
    // state = const Loading();
    // notifyListeners();
    // kprint("updateTech : $state");
    // status = "updateTech";
    notifyListeners();
    var data = await repository.updateTech(techId, eligibility);
    state = data;
    notifyListeners();
  }

  void updateTechAddition(additionId, eligibility, status) async {
    // state = const Loading();
    // status = "updateTechAddition";
    notifyListeners();
    var data = await repository.updateTechAddition(additionId, eligibility, status);
    state = data;
    notifyListeners();
  }
//
// void getFavoriteWallpapers() async {
//   favorites = await repository.login();
//   notifyListeners();
// }
//
// void addFavorite(WallpaperModel model) async {
//   repository.addFavorite(model);
//   getFavoriteWallpapers();
//   notifyListeners();
// }
//
// void removeFavorite(WallpaperModel model) async {
//   repository.removeFavorite(model);
//   notifyListeners();
// }
//
// void selectFavorite(WallpaperModel model) {
//   repository.selectFavorite(model);
//   notifyListeners();
// }
//
// void addToCategory(WallpaperModel model) async {
//   repository.addToCategory(model);
//   notifyListeners();
// }
}
