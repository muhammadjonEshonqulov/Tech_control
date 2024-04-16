import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_control/app/app.dart';
import 'package:tech_control/provider/login_provider.dart';
import 'package:tech_control/utils/language/lang_json.dart';
import 'package:tech_control/utils/network_result.dart';

import 'data/database/database.dart';
import 'data/network/network_client.dart';
import 'data/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  var networkClient = NetworkClient();
  // AppDatabase appDatabase = (await $FloorAppDatabase.databaseBuilder('app_database.db').build());

  Repository repository = Repository( networkClient: networkClient);
  NetworkResult state = Loading();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('uz'),
      // Locale('en'),
      // Locale('ru'),
    ],
    path: 'assets/lang',
    assetLoader: JsonAssetLoader(),
    fallbackLocale: const Locale('uz'),
    child: App(repository: repository, state: state),
  ));
}
