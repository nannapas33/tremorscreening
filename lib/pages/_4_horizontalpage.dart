import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tremorscreeningv2/backend/dataorganizer.dart';
import 'package:tremorscreeningv2/backend/penPainter.dart';
import 'package:tremorscreeningv2/backend/templatePainter.dart';

import '_5_letterpage.dart';

double _fontsize = 20;
double _height = 350;
double _width = 500;
double _wgif = 450;
double _wborder = 5;

class HorizontalPage extends StatefulWidget {
  const HorizontalPage({Key? key}) : super(key: key);
  static var lhhlTS,rhhlTS = [];
  static var lhhlCO,rhhlCO = [];

  @override
  _HorizontalPageState createState() => _HorizontalPageState();
}
class _HorizontalPageState extends State<HorizontalPage> {

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_fontsize + 3),
        child:AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Horizontal Line',style: TextStyle(fontSize: _fontsize)),
      ),),
      body: Center(
        child: Container(
          width: _wgif,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/image/horizontal.gif'),
            ),
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _RightHand()));
        },
        child: Text('ตกลง',style: TextStyle(fontSize: _fontsize, color: Colors.red[900]),
      ),
    ));
  }
}

class _RightHand extends StatefulWidget {
  const _RightHand({Key? key}) : super(key: key);

  @override
  __RightHandState createState() => __RightHandState();
}
class __RightHandState extends State<_RightHand> {
  List timeStamp = [];
  List<Offset?> coordn = [];
  DateTime? time; double? timesec;
  GlobalKey _RHLkey = GlobalKey();

  void _clear() {
    setState(() {
      timeStamp.clear();
      coordn.clear();
    });
  }

  void _redo() {
    setState(() {
      var index = getIndex(coordn);

      if (index == 0) {
        coordn.clear();
        timeStamp.clear();
      } else {
        coordn.removeRange(index, coordn.length);
        timeStamp.removeRange(index, timeStamp.length);
      }
    });
  }

  int getIndex(List list) {
    var wherenull, NoN, reverse;
    int temp, index;

    wherenull = list.where((x) => x == null);
    NoN = wherenull.length;

    if (NoN == 1) {
      index = 0;
    } else {
      reverse = new List.from(list.reversed);
      temp = reverse.indexOf(null, 2);
      index = list.length - temp;
    }
    return index;
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _redo(),
        heroTag: "btn1",
        tooltip: 'First button',
        child: Icon(Icons.refresh_outlined),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          _showConfirmDialog();
          HorizontalPage.rhhlTS = timeStamp;
          HorizontalPage.rhhlCO = coordn;

        },
        heroTag: "btn2",
        tooltip: 'Second button',
        child: Icon(Icons.check),
      ),
    );
  }

  Widget float3() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () =>_clear(),
        heroTag: "btn3",
        tooltip: 'Third button',
        child: Icon(Icons.delete),
      ),
    );
  }

  void _showConfirmDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              title: Text('ดำเนินการต่อ?',
                  style:
                  TextStyle(fontSize: _fontsize, color: Colors.red[900],fontWeight: FontWeight.bold)),
              content: Text(
                'ท่านตรวจสอบข้อมูลเรียบร้อยแล้ว?',
                style: TextStyle(fontSize: _fontsize),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ไม่',
                        style: TextStyle(
                            fontSize: _fontsize, color: Colors.red[900]))),
                TextButton(
                    onPressed: () {
                      uploadImg(_RHLkey, "RHL");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => _LeftHand()));
                    },
                    child: Text('ใช่',
                        style: TextStyle(
                            fontSize: _fontsize, color: Colors.red[900])))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: PreferredSize(
          preferredSize: Size.fromHeight(_fontsize),
          child:AppBar(
          backgroundColor: Colors.red[900],
          title: Text('Horizontal Line Right Hand',style: TextStyle(fontSize: _fontsize)),
        ),),

         */
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
          fabButtons: <Widget>[float3(), float1(), float2()],
          colorStartAnimation: Colors.redAccent,
          colorEndAnimation: Colors.grey,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(
          child: GestureDetector(
              onPanDown: (details) {
                setState(() {
                  time = DateTime.now();
                  timesec = (time!.minute*60)
                      + time!.second
                      + (time!.millisecond*0.001)+
                      (time!.microsecond * 0.000001);
                  timeStamp.add(timesec);
                  coordn.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  time = DateTime.now();
                  timesec = (time!.minute*60)
                      + time!.second
                      + (time!.millisecond*0.001)+
                      (time!.microsecond * 0.000001);
                  timeStamp.add(timesec);
                  coordn.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  time = DateTime.now();
                  timesec = (time!.minute*60)
                      + time!.second
                      + (time!.millisecond*0.001)+
                      (time!.microsecond * 0.000001);
                  timeStamp.add(timesec);
                  coordn.add(null);
                });
              },
              child: RepaintBoundary(
                  key: _RHLkey,
                  child: Stack(
                    children: <Widget>[
                      CustomPaint(
                        child: Container(
                          height: _height,
                          width: _width,
                        ),
                        painter: TemplatePainter(2),
                      ),
                      CustomPaint(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: _wborder,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: _height,
                          width: _width,
                        ),
                        painter: PenPainter(coordn),
                      ),
                    ],
                  ))),
        ),
      ],)
    );
  }
}

class _LeftHand extends StatefulWidget {
  const _LeftHand({Key? key}) : super(key: key);

  @override
  __LeftHandState createState() => __LeftHandState();
}
class __LeftHandState extends State<_LeftHand> {
  List timeStamp = [];
  List<Offset?> coordn = [];
  DateTime? time; double? timesec;
  GlobalKey _LHLkey = GlobalKey();

  void _clear() {
    setState(() {
      timeStamp.clear();
      coordn.clear();
    });
  }

  void _redo() {
    setState(() {
      var index = getIndex(coordn);

      if (index == 0) {
        coordn.clear();
        timeStamp.clear();
      } else {
        coordn.removeRange(index, coordn.length);
        timeStamp.removeRange(index, timeStamp.length);
      }
    });
  }

  int getIndex(List list) {
    var wherenull, NoN, reverse;
    int temp, index;

    wherenull = list.where((x) => x == null);
    NoN = wherenull.length;

    if (NoN == 1) {
      index = 0;
    } else {
      reverse = new List.from(list.reversed);
      temp = reverse.indexOf(null, 2);
      index = list.length - temp;
    }
    return index;
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _redo(),
        heroTag: "btn1",
        tooltip: 'First button',
        child: Icon(Icons.refresh_outlined),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          _showConfirmDialog();
          HorizontalPage.lhhlTS = timeStamp;
          HorizontalPage.lhhlCO = coordn;
        },
        heroTag: "btn2",
        tooltip: 'Second button',
        child: Icon(Icons.check),
      ),
    );
  }

  Widget float3() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _clear(),
        heroTag: "btn3",
        tooltip: 'Third button',
        child: Icon(Icons.delete),
      ),
    );
  }

  void _showConfirmDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
              title: Text('ดำเนินการต่อ?',
                  style:
                  TextStyle(fontSize: _fontsize, color: Colors.red[900],fontWeight: FontWeight.bold)),
              content: Text(
                'ท่านตรวจสอบข้อมูลเรียบร้อยแล้ว?',
                style: TextStyle(fontSize: _fontsize),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ไม่',
                        style: TextStyle(
                            fontSize: _fontsize, color: Colors.red[900]))),
                TextButton(
                    onPressed: () {
                      uploadImg(_LHLkey, "LHL");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LetterPage()));
                    },
                    child: Text('ใช่',
                        style: TextStyle(
                            fontSize: _fontsize, color: Colors.red[900])))
              ]);
        });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Horizontal Line Left Hand',style: TextStyle(fontSize: _fontsize)),
      ),

       */
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
          fabButtons: <Widget>[float3(), float1(), float2()],
          colorStartAnimation: Colors.redAccent,
          colorEndAnimation: Colors.grey,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(
          child: GestureDetector(
              onPanDown: (details) {
                setState(() {
                  time = DateTime.now();
                  timesec = (time!.minute*60)
                      + time!.second
                      + (time!.millisecond*0.001)+
                      (time!.microsecond * 0.000001);
                  timeStamp.add(timesec);
                  coordn.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  time = DateTime.now();
                  timesec = (time!.minute*60)
                      + time!.second
                      + (time!.millisecond*0.001)+
                      (time!.microsecond * 0.000001);
                  timeStamp.add(timesec);
                  coordn.add(details.localPosition);

                });
              },
              onPanEnd: (details) {
                setState(() {
                  time = DateTime.now();
                  timesec = (time!.minute*60)
                      + time!.second
                      + (time!.millisecond*0.001)+
                      (time!.microsecond * 0.000001);
                  timeStamp.add(timesec);
                  coordn.add(null);
                });
              },
              child: RepaintBoundary(
                  key: _LHLkey,
                  child: Stack(
                    children: <Widget>[
                      CustomPaint(
                        child: Container(
                          height: _height,
                          width: _width,
                        ),
                        painter: TemplatePainter(2),
                      ),
                      CustomPaint(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: _wborder,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: _height,
                          width: _width,
                        ),
                        painter: PenPainter(coordn),
                      ),
                    ],
                  ))),
        ),
      ],)

    );
  }
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
