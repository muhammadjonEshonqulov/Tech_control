import 'dart:convert';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tech_control/app/app.dart';
import 'package:tech_control/app/router.dart';
import 'package:tech_control/provider/additional_provider.dart';
import 'package:tech_control/utils/utils.dart';
import 'package:tech_control/widgets/updateAdditionalDialog.dart';

import '../utils/network_result.dart';
import '../widgets/updateTechDialog.dart';

class AdditionScreen extends StatefulWidget {
  final String id;

  const AdditionScreen({super.key, required this.id});

  @override
  State<AdditionScreen> createState() => _AdditionScreenState();
}

class _AdditionScreenState extends State<AdditionScreen> {
  late AdditionalProvider provider;
  late Widget _widget;
  var eligibility = '0';
  var inventary = '';
  var building = '';
  var room = '';
  List<dynamic> techs = [];

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    provider = Provider.of<AdditionalProvider>(context, listen: false);
    provider.status = "getAdditional";
    provider.getAdditional(widget.id);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Card(
          elevation: 2.0, // cardElevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Container(
            height: kToolbarHeight,
            color: Color(0xFF0A6F9B),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    router.go(Routes.qr_scan);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(right: 16.0),
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "Tech Control",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                // Add other widgets as needed
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Consumer<AdditionalProvider>(builder: (context, value, child) {
              if (value.status == "getAdditional") {
                // kprint(value.state);
                // kprint(value.state is Loading);
                if (value.state is Loading) {
                  kprint('Loading...');
                  return const Center(child: CircularProgressIndicator());
                } else if (value.state is Error) {
                  return Center(child: Text('Xatolik: ${value.state.message.toString() ?? ''}'));
                } else if (value.state is Success) {
                  try {
                    var eligibilityValue = value.state.data['technic']['eligibility'].toString();
                    if (eligibilityValue != null) {
                      if (eligibilityValue == "1") {
                        eligibility = 'Yangi';
                      } else if (eligibilityValue == "2") {
                        eligibility = 'Ishlaydi';
                      } else {
                        eligibility = 'Yaroqsiz';
                      }
                    }
                    var tasks = value.state.data['additionals'];
                    techs = tasks ?? [];
                    inventary = value.state.data['technic']['internal_inventory'] ?? '';
                    building = value.state.data['technic']['building']['name'] ?? '';
                    room = value.state.data['technic']['room']['name'] ?? '';
                    kprint('tasks->$techs');
                    _widget = Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Ichki inventor:',
                                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      inventary,
                                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Holati:',
                                          style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Builder(builder: (context) {
                                          return Text(
                                            eligibility,
                                            style: const TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                          );
                                        })
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () {
                                          _showDialog(context, eligibility);
                                          // setState(() {
                                          //   eligibility = 'jhjhhg';
                                          // });
                                        },
                                        child: Container(height: 24, child: Image.asset('assets/images/pencil.png'))),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Bino:',
                                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      building,
                                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Xona:',
                                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      room,
                                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    color: Color(0xFF120B64),
                                    child: Center(child: Text('Nomi', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w700))),
                                  )),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.white,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    color: Color(0xFF120B64),
                                    child: Center(child: Text('Holati', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w700))),
                                  )),
                              Container(
                                width: 1,
                                color: Colors.white,
                                height: 50,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    color: Color(0xFF120B64),
                                    child: Center(child: Text('Mavjudligi', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w700))),
                                  )),
                              Container(
                                width: 1,
                                color: Colors.white,
                                height: 50,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    color: Color(0xFF120B64),
                                    child: Center(
                                        child: Container(
                                      height: 24,
                                      child: Image.asset(
                                        'assets/images/pencil.png',
                                        color: Colors.white,
                                      ),
                                    )),
                                  ))
                            ],
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: techs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 1,
                                        color: Color(0xFFC6BDBD),
                                        height: 50,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 49,
                                            color: Colors.white,
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Center(
                                                  child: Text(techs[index]['tip']['text'], style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat', fontWeight: FontWeight.w700))),
                                            ),
                                          )),
                                      Container(
                                        width: 1,
                                        color: Color(0xFFC6BDBD),
                                        height: 50,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 50,
                                            color: Colors.white,
                                            child: Center(
                                                child: Text(techs[index]['condition'] == "1" ? "Yaroqsiz" : (techs[index]['condition'] == "2" ? "Nosoz" : "Soz"),
                                                    style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat', fontWeight: FontWeight.w700))),
                                          )),
                                      Container(
                                        width: 1,
                                        color: Color(0xFFC6BDBD),
                                        height: 50,
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 50,
                                            color: Colors.white,
                                            child: Center(
                                                child: Text(techs[index]['status'] == 1 ? 'Bor' : "Yo'q",
                                                    style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat', fontWeight: FontWeight.w700))),
                                          )),
                                      Container(
                                        width: 1,
                                        color: Color(0xFFC6BDBD),
                                        height: 50,
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.white,
                                            child: Center(
                                                child: InkWell(
                                              onTap: () {
                                                _showDialogUpdateAdditional(
                                                    context,
                                                    techs[index]['tip']['text'],
                                                    techs[index]['condition'] == "1" ? "Yaroqsiz" : (techs[index]['condition'] == "2" ? "Nosoz" : "Soz"),
                                                    techs[index]['_id'] ?? "",
                                                    techs[index]['status'] == 1 ? "Bor" : "Yo'q");
                                              },
                                              child: Container(
                                                height: 24,
                                                child: Image.asset(
                                                  'assets/images/pencil.png',
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            )),
                                          )),
                                      Container(
                                        width: 1,
                                        color: Color(0xFFC6BDBD),
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Color(0xFFC6BDBD),
                                    height: 1,
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    );
                    return _widget;
                  } catch (e) {
                    return Text("error -> $e");
                  }
                }
                kprint("else -> ${value.state}");
                return Text("else -> ${value.state}");
              } else if (value.status == "updateTech") {
                if (value.state is Error) {
                  return Center(child: Text('Xatolik: ${value.state?.message.toString() ?? ''}'));
                } else if (value.state is Loading) {
                  kprint("Loading...");
                  return Stack(
                    children: [_widget, Center(child: CircularProgressIndicator())],
                  );
                } else if (value.state is Success) {
                  Future.delayed(Duration.zero, () {
                    kprint('Muvaffaqiyatli o\'zgartirildi');
                    snack(context, 'Muvaffaqiyatli o\'zgartirildi');
                  });
                  provider.status = "getAdditional";
                  provider.state = Loading();
                  provider.getAdditional(widget.id);
                  return _widget;
                } else {
                  return Text("my text");
                }
              } else if (value.status == "updateTechAddition") {
                if (value.state is Error) {
                  return Center(child: Text('Xatolik: ${value.state?.message.toString() ?? ''}'));
                } else if (value.state is Loading) {
                  kprint("Loading...");
                  return Stack(
                    children: [_widget, Center(child: CircularProgressIndicator())],
                  );
                } else if (value.state is Success) {
                  Future.delayed(Duration.zero, () {
                    kprint('Muvaffaqiyatli o\'zgartirildi');
                    snack(context, 'Muvaffaqiyatli o\'zgartirildi');
                  });
                  provider.status = "getAdditional";
                  provider.state = Loading();
                  provider.getAdditional(widget.id);
                  // Future.delayed(Duration.zero, () {
                  //   setState(() {
                  //     eligibility = '0';
                  //   });
                  // });
                  return _widget;
                } else {
                  return Text("sdvjhshjsdvjhsvj");
                }
              } else {
                return _widget;
              }
            }),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A6F9B),
              ),
              onPressed: () async {
                String copy = 'additional#$inventary#$eligibility#$building#$room#${jsonEncode(techs)}';
                Clipboard.setData(ClipboardData(text: copy));

                await LaunchApp.openApp(
                  androidPackageName: 'uz.rttm.support',
                  iosUrlScheme: '',
                  appStoreLink: '',
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('So\'rovnoma yuborish'),
              ),
            ),
          )
        ],
      ),
    ));
  }

  void _showDialog(BuildContext context, String eligibility) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(eligibility, widget.id);
      },
    );
  }

  void _showDialogUpdateAdditional(BuildContext context, String name, String eligibility, String additionId, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialogUpdateAdditional(name, eligibility, additionId, status);
      },
    );
  }
}
