import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendPollScreen extends StatefulWidget {
  const SendPollScreen({super.key});

  @override
  State<SendPollScreen> createState() => _SendPollScreenState();
}

class _SendPollScreenState extends State<SendPollScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
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

                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
                Text(
                  "So\'rovnoma yuborish",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Add other widgets as needed
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    ));
  }
}
