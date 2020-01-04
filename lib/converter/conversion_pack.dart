import 'package:flutter/material.dart';
import 'model.dart';

class Convert extends StatefulWidget {
  @override
  _ConvertState createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  Color unitUnderlineColor = Colors.orange;

  String dropdownValueA = 'Inch',
      dropdownValueB = 'Inch',
      dropdownValueU = 'Length';
  var unitList;

  String hintText = "";

  final controllerA = TextEditingController();
  final controllerB = TextEditingController();

  UnitModel um = new UnitModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      unitList = um.lengthUnit;
    });
  }

  void hintProvider({bool index = true}) {
    setState(() {
      if (controllerA.text != '' &&
          controllerB.text !=
              '') // Text field should not be empty to apply conversion operation...
        controllerB.text = um.Calculate(
                unitOf: dropdownValueU,
                unitA: dropdownValueA,
                unitB: dropdownValueB,
                value: double.parse(controllerA.text))
            .toString();
      if (dropdownValueA != dropdownValueB) {
        hintText = um.hintBox(
            unitOf: dropdownValueU,
            unitA: dropdownValueA,
            unitB: dropdownValueB);
      } else {
        hintText = '';
      }
    });
  }

  void changeList(var newList) {
    setState(() {
      unitList = newList;
      dropdownValueA = unitList[0];
      dropdownValueB = unitList[0];
    });
  }

  void Switch() {
    setState(() {
      String temp;
      temp = dropdownValueA;
      dropdownValueA = dropdownValueB;
      dropdownValueB = temp;
    });
    hintProvider();
  }

  void Reset() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      dropdownValueA = dropdownValueB = unitList[0];
      controllerA.text = controllerB.text = '';
    });
    hintProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new DropdownButton<String>(
          icon: Icon(
            Icons.radio_button_checked,
            color: unitUnderlineColor,
          ),
          underline: Container(
            color: unitUnderlineColor,
            height: 3,
          ),
          isExpanded: true,
          value: dropdownValueU,
          onChanged: (String newValue) {
            setState(() {
              dropdownValueU = newValue;
              if (newValue == 'Length') {
                changeList(um.lengthUnit);
                unitUnderlineColor = Colors.orange;
              } else if (newValue == 'Area') {
                changeList(um.areaUnit);
                unitUnderlineColor = Colors.green;
              } else if (newValue == 'Mass') {
                changeList(um.massUnit);
                unitUnderlineColor = Colors.redAccent;
              }
            });
          },
          items: um.Unit.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: controllerA,
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: 'Enter Value...',
            labelText: dropdownValueA,
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            controllerB.text = um.Calculate(
                    unitOf: dropdownValueU,
                    unitA: dropdownValueA,
                    unitB: dropdownValueB,
                    value: double.parse(value))
                .toString();
//                controllerB.text = value;
          },
        ),
        SizedBox(
          height: 10,
        ),
        new DropdownButton<String>(
          isExpanded: true,
          value: dropdownValueA,
          onChanged: (String newValue) {
            setState(() {
              dropdownValueA = newValue;
            });
            hintProvider();
          },
          items: unitList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Text(
          "=",
          style: TextStyle(fontSize: 50),
        ),
        TextField(
          controller: controllerB,
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: dropdownValueB,
            hintText: 'Result value here...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            controllerA.text = um.Calculate(
                    unitOf: dropdownValueU,
                    unitA: dropdownValueB,
                    unitB: dropdownValueA,
                    value: double.parse(value))
                .toString();
          },
        ),
        SizedBox(
          height: 10,
        ),
        new DropdownButton<String>(
          isExpanded: true,
          value: dropdownValueB,
          onChanged: (String newValue) {
            setState(() {
              dropdownValueB = newValue;
            });
            hintProvider(index: false);
          },
          items: unitList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: RaisedButton(
                child: Text(
                  "Switch",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: Switch,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 15),
                // color: Colors.blue.withOpacity(0.8),
                color: Colors.blueAccent[200],
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: RaisedButton(
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                shape: StadiumBorder(),
                onPressed: Reset,
                padding: EdgeInsets.symmetric(vertical: 15),
                // color: Colors.blue.withOpacity(0.8),
                color: Colors.blueAccent[200],
              )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            hintText,
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
