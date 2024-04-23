import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tech_control/app/router.dart';
import 'package:tech_control/data/repository/repository.dart';
import 'package:tech_control/provider/additional_provider.dart';
import 'package:tech_control/utils/network_result.dart';

import '../provider/login_provider.dart';

class App extends StatelessWidget {
  final Repository repository;
  final NetworkResult state;

  const App({super.key, required this.repository, required this.state});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xff3E67B7)));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider(repository)),
        ChangeNotifierProvider(create: (_) => AdditionalProvider(repository, state)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: false,
        ),
        builder: EasyLoading.init(),
        routerConfig: router,
      ),
    );
  }
}

void snack(BuildContext context, String mes) {
  final snackBar = SnackBar(content: Text(mes), duration: const Duration(seconds: 1));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

BuildContext? _dialogContext;

void showLoading(context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      _dialogContext = context;
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void hideLoading() {
  if (_dialogContext != null) {
    Navigator.of(_dialogContext!).pop();
    _dialogContext = null;
  }
}
