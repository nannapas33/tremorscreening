import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tremorscreeningv2/backend/dataorganizer.dart';
import 'package:tremorscreeningv2/backend/threshold.dart';

double _fontsize = 20;
double _fontM = 25;
double _fontL = 30;
String text = calthreshold();

class TerminalPage extends StatefulWidget {
  const TerminalPage({Key? key}) : super(key: key);

  @override
  _TerminalPageState createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    String text = calthreshold();
    createJSON(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text('Terminal', style: TextStyle(fontSize: _fontsize)),
        ),
        body: Container(
            child: Column(
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
              Flexible(flex: 2, child: Container(height: 400)),
              Flexible(
                  flex: 3,
                  child: Container(
                      height: 400,
                      child: Text(
                        'สิ้นสุดของแบบทดสอบ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _fontL),
                      ))),
              Flexible(
                flex: 2,
                child: Container(
                    height: 400,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: _fontM),
                    )),
              ),
              Flexible(
                  flex: 4,
                  child: Container(
                      height: 400,
                      child: TextButton(
                          onPressed: () {
                            Phoenix.rebirth(context);
                          },
                          child: Text(
                            'จบการทำงาน',
                            style: TextStyle(
                                fontSize: _fontsize,
                                backgroundColor: Colors.red[900],
                                color: Colors.white),
                          ))))
            ])));
  }
}
