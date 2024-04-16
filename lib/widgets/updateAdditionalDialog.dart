import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/additional_provider.dart';
import '../utils/network_result.dart';

class MyDialogUpdateAdditional extends StatefulWidget {
  final String name;
  final String eligibility;
  final String status;
  final String additionId;

  const MyDialogUpdateAdditional(this.name, this.eligibility, this.additionId, this.status, {super.key});

  @override
  _MyDialogUpdateAdditionalState createState() => _MyDialogUpdateAdditionalState();
}

class _MyDialogUpdateAdditionalState extends State<MyDialogUpdateAdditional> {
  late String status;
  late String eligibility;
  late AdditionalProvider provider;

  @override
  void initState() {
    status = widget.status;
    eligibility = widget.eligibility;
    provider = Provider.of<AdditionalProvider>(context, listen: false);
    provider.status = "updateTechAddition";
    provider.state = Loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Qo\'shimcha qurilmani o\'zgartirish', style:  TextStyle(fontWeight: FontWeight.w700, fontSize: 16, fontFamily: 'Montserrat'),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style:  TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Montserrat'),),
          SizedBox(height: 15,),
          Text('Mavjudligini o\'zgartirish', style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Montserrat'),),
          DropdownButton<String>(
            value: status,
            items: ["Bor", "Yo'q"]
                .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                status = value!;
              });
            },
          ),
          Text('Holatini o\'zgartirish'),
          DropdownButton<String>(
            value: eligibility,
            items: ["Yaroqsiz", "Nosoz", "Soz"]
                .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                eligibility = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Bekor qilish'),
        ),
        ElevatedButton(
          onPressed: () {
            // provider.eligibility = selectedValue;
            // String status = selectedValue == "Yaroqsiz" ? "3" : (selectedValue == "Ishlaydi" ? "2" : "1");
            Provider.of<AdditionalProvider>(context, listen: false).updateTechAddition(widget.additionId,eligibility == "Yaroqsiz" ? "1" : (eligibility == "Nosoz" ? "2" : "3"), status == "Bor" ? "1" : "0");
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
          child: Text('Yuborish'),
        ),
      ],
    );
  }
}