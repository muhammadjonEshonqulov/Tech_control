import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_control/utils/utils.dart';

import '../app/router.dart';
import '../data/database/cache.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    init();
    super.initState();
  }

  late AnimationController _animatedController;
  late CurvedAnimation _curvedAnimation;

  init() {
    _animatedController = AnimationController(duration: const Duration(seconds: 1), vsync: this)
      ..forward()
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          var token = await cache.getString(cache.token);
          kprint('token->$token');
          if (token == null) {
            router.go(Routes.login);
          } else {
            router.go(Routes.qr_scan);
          }
        }
      });
    _curvedAnimation = CurvedAnimation(parent: _animatedController, curve: Curves.elasticOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
          child: Text(
        "app_name".tr(),
        style: TextStyle(color: ColorsUtils.colorPrimary, fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
      )),
    ));
  }
}
