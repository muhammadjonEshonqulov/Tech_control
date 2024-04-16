import 'package:flutter/cupertino.dart';
import 'package:tech_control/utils/network_result.dart';

import '../data/repository/repository.dart';

class LoginProvider extends ChangeNotifier {
  // var dbHelper = DBHelper();
  // List<WallpaperModel> wallpapers = [];
  // List<WallpaperModel> favorites = [];
  // List<WallpaperModel> searchWallpapers = [];
  String token = "";
  Repository repository;
  NetworkResult? loginState;

  LoginProvider(this.repository);

  void login(String userName, String password) async {
    loginState = Loading();
    notifyListeners();
    var data = await repository.login(userName, password);
    loginState = data;
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
