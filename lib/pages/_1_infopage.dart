import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '_2_spiralpage.dart';
import 'package:nanoid/nanoid.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({required Key? info}) : super(key: info);

  static String? firstname, surname, sex, domhand, id;
  static var age;
  static int? hand;
  static var dpr;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int? sex, domhand;
  TextEditingController firstcontrol = TextEditingController(),
      surcontrol = TextEditingController(),
      agecontrol = TextEditingController();
  DateTime time = DateTime.now();
  var id = nanoid(3);
  double _fontsize = 20;
  double _edge = 7;


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    String year = (time.year).toString().substring(2);
    InfoPage.id = "$year${time.month}${time.day}${time.hour}${time.minute}-$id";

    if (InfoPage.firstname != null) {
      InfoPage.firstname = null;
      InfoPage.surname = null;
      InfoPage.age = null;
      InfoPage.sex = null;
      InfoPage.domhand = null;
    }
  }

  void _showConfirmDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              title: Text(
                'ดำเนินการต่อ?',
                style: TextStyle(
                    fontSize: _fontsize,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),
              ),
              content: Text(
                'ท่านตรวจสอบข้อมูลเรียบร้อยแล้ว?',
                style: TextStyle(fontSize: _fontsize),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ไม่',
                      style: TextStyle(
                          fontSize: _fontsize, color: Colors.red[900]),
                    )),
                TextButton(
                    onPressed: () {
                      InfoPage.dpr = MediaQuery.of(context).devicePixelRatio;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SpiralPage(
                                    spiral: null,
                                  )));
                    },
                    child: Text(
                      'ใช่',
                      style: TextStyle(
                          fontSize: _fontsize, color: Colors.red[900]),
                    ))
              ]);
        });
  } // Show Confirm Dialog

  void _showFillBlankDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              title: Text(
                'เกิดข้อผิดพลาด',
                style: TextStyle(
                    fontSize: _fontsize,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),
              ),
              content: Text(
                'กรุณากรอกข้อมูลให้ครบถ้วน',
                style: TextStyle(fontSize: _fontsize),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ตกลง',
                      style: TextStyle(
                          fontSize: _fontsize, color: Colors.red[900]),
                    )),
              ]);
        });
  } // Show Error (null)


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(_fontsize + 5),
        child:AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            'Info Page',
            style: TextStyle(fontSize: _fontsize),
          ),
        ),),
        body: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(_edge),
                        child: Text(
                          'ชื่อ - นามสกุล',
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("ID: ${InfoPage.id!}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: _fontsize - 5, color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.all(_edge),
                          child: TextField(
                              style: TextStyle(fontSize: _fontsize),
                              controller: firstcontrol,
                              onChanged: (text) {
                                InfoPage.firstname = text;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'ชื่อ'))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.all(_edge),
                          child: TextField(
                              style: TextStyle(fontSize: _fontsize),
                              controller: surcontrol,
                              onChanged: (text) {
                                InfoPage.surname = text;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'สกุล'))),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(_edge),
                        child: Text(
                          'อายุ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(_edge),
                          child: Text(
                            'เพศ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: _fontsize),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(_edge),
                        child: Text(
                          'มือข้างที่ถนัด',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.all(_edge),
                        child: TextField(
                            style: TextStyle(fontSize: _fontsize),
                            controller: agecontrol,
                            onChanged: (text) {
                              InfoPage.age = text;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'กรุณากรอกเป็นตัวเลข'))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(_edge),
                      child: DropdownButton(
                        isExpanded: true,
                        value: sex,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        hint: Text(
                          'เลือก',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: _fontsize),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'หญิง',
                              style: TextStyle(fontSize: _fontsize),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'ชาย',
                              style: TextStyle(fontSize: _fontsize),
                            ),
                            value: 2,
                          )
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            sex = value!;
                            if (sex == 1) {
                              InfoPage.sex = 'F';
                            } else if (sex == 2) {
                              InfoPage.sex = 'M';
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(_edge),
                      child: DropdownButton(
                        isExpanded: true,
                        value: domhand,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        hint: Text(
                          'เลือก',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: _fontsize),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'ขวา',
                              style: TextStyle(fontSize: _fontsize),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'ซ้าย',
                              style: TextStyle(fontSize: _fontsize),
                            ),
                            value: 2,
                          )
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            domhand = value!;
                            if (domhand == 1) {
                              InfoPage.domhand = 'R';
                              InfoPage.hand = 1;
                            } else if (domhand == 2) {
                              InfoPage.domhand = 'L';
                              InfoPage.hand = 2;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ]),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 150,
                      height: 80,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red[900],
                            elevation: 5,
                          ),
                          child: Text(
                            'ถัดไป',
                            style: TextStyle(fontSize: _fontsize -5),
                          ),
                          onPressed: () {
                            if (InfoPage.sex == null ||
                                InfoPage.domhand == null ||
                                InfoPage.firstname == null ||
                                InfoPage.surname == null ||
                                InfoPage.age == null) {
                              _showFillBlankDialog();
                            } else {
                              _showConfirmDialog();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  //---------------------------Clear Orientation Setting------------------------
  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }
}
