import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/additional_provider.dart';
import '../utils/network_result.dart';

class MyDialog extends StatefulWidget {
  final String eligibility;
  final String techId;

  const MyDialog(this.eligibility, this.techId, {super.key});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  late String selectedValue;
  late AdditionalProvider provider;

  @override
  void initState() {
    selectedValue = widget.eligibility;
    provider = Provider.of<AdditionalProvider>(context, listen: false);
    provider.status = "updateTech";
    provider.state = Loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Texnikani o\'zgartirish'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Holatini o\'zgartirish'),
          DropdownButton<String>(
            value: selectedValue,
            items: ["Yangi", "Ishlaydi", "Yaroqsiz"]
                .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
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
            provider.eligibility = selectedValue;
            String status = selectedValue == "Yaroqsiz" ? "3" : (selectedValue == "Ishlaydi" ? "2" : "1");
            Provider.of<AdditionalProvider>(context, listen: false).updateTech(widget.techId, status);
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
          child: Text('Yuborish'),
        ),
      ],
    );
  }
}