import 'package:flutter/material.dart';
import 'conversion_pack.dart';
import 'model.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },

      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Convert()        
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          child: Text(
            "# Ravi Agheda",
            style: TextStyle(fontSize: 14,fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
