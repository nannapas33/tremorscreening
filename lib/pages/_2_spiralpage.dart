import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tremorscreeningv2/backend/dataorganizer.dart';
import 'package:tremorscreeningv2/backend/penPainter.dart';
import 'package:tremorscreeningv2/backend/templatePainter.dart';
import 'package:tremorscreeningv2/pages/_3_verticalpage.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';


double _fontsize = 20;
double _height = 500;
double _width = 350;
double _hgif = 500;
double _wborder = 5;


class SpiralPage extends StatefulWidget {
  SpiralPage({required Key? spiral}) : super(key: spiral);

  static var lhspTS, rhspTS = [];
  static var lhspCO, rhspCO = [];

  @override
  _SpiralPageState createState() => _SpiralPageState();
}

class _SpiralPageState extends State<SpiralPage> {
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Archimedes Spiral',
          style: TextStyle(fontSize: _fontsize),
        ),
      ),
      body: Center(
        child: Container(
          height: _hgif,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/image/spiral.gif'),
            ),
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _RightHand()));
        },
        child: Text('ตกลง',
            style: TextStyle(fontSize: _fontsize, color: Colors.red[900])),
      ),
    );
  }
}

class _RightHand extends StatefulWidget {
  const _RightHand({Key? key}) : super(key: key);

  @override
  __RightHandState createState() => __RightHandState();
}

class __RightHandState extends State<_RightHand> {
  List timeStamp = [];
  List coordn = [];
  DateTime? time;
  double? timesec;


  GlobalKey _RSPkey = GlobalKey();

  void _clear() {
    setState(() {
      timeStamp.clear();
      coordn.clear();
    });
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _clear(),
        heroTag: "btn1",
        tooltip: 'First button',
        child: Icon(Icons.delete),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          _showConfirmDialog();
          SpiralPage.rhspTS = timeStamp;
          SpiralPage.rhspCO = coordn;

        },
        heroTag: "btn2",
        tooltip: 'Second button',
        child: Icon(Icons.check),
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
                      uploadImg(_RSPkey, "RSP");
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
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Archimedes Spiral Right Hand',
          style: TextStyle(fontSize: _fontsize),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[float1(), float2()],
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
                    timesec = (time!.minute * 60) +
                        time!.second +
                        (time!.millisecond * 0.001) +
                        (time!.microsecond * 0.000001);
                    timeStamp.add(timesec);
                    coordn.add(details.localPosition);
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    time = DateTime.now();
                    timesec = (time!.minute * 60) +
                        time!.second +
                        (time!.millisecond * 0.001) +
                        (time!.microsecond * 0.000001);
                    timeStamp.add(timesec);
                    coordn.add(details.localPosition);
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    time = DateTime.now();
                    timesec = (time!.minute * 60) +
                        time!.second +
                        (time!.millisecond * 0.001) +
                        (time!.microsecond * 0.000001);
                    timeStamp.add(timesec);
                    coordn.add(null);
                  });
                },
                child: RepaintBoundary(
                    key: _RSPkey,
                    child: Stack(
                      children: <Widget>[
                        CustomPaint(
                          child: Container(
                            height: _height,
                            width: _width,
                          ),
                          painter: TemplatePainter(0),
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
        ],
      ),
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
  List coordn = [];
  DateTime? time;
  double? timesec;
  GlobalKey _LSPkey = GlobalKey();

  void _clear() {
    setState(() {
      timeStamp.clear();
      coordn.clear();
    });
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _clear(),
        heroTag: "btn1",
        tooltip: 'First button',
        child: Icon(Icons.delete),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          _showConfirmDialog();
          SpiralPage.lhspTS = timeStamp;
          SpiralPage.lhspCO = coordn;
        },
        heroTag: "btn2",
        tooltip: 'Second button',
        child: Icon(Icons.check),
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
                      uploadImg(_LSPkey, "LSP");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VerticalPage()));
                    },
                    child: Text('ใช่',
                        style: TextStyle(
                            fontSize: _fontsize, color: Colors.red[900])))
              ]);
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            'Archimedes Spiral Left Hand',
            style: TextStyle(fontSize: _fontsize),
          ),
        ),
        floatingActionButton: AnimatedFloatingActionButton(
            //Fab list
            fabButtons: <Widget>[float1(), float2()],
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
                        timesec = (time!.minute * 60) +
                            time!.second +
                            (time!.millisecond * 0.001) +
                            (time!.microsecond * 0.000001);
                        timeStamp.add(timesec);
                        coordn.add(details.localPosition);
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        time = DateTime.now();
                        timesec = (time!.minute * 60) +
                            time!.second +
                            (time!.millisecond * 0.001) +
                            (time!.microsecond * 0.000001);
                        timeStamp.add(timesec);
                        coordn.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        time = DateTime.now();
                        timesec = (time!.minute * 60) +
                            time!.second +
                            (time!.millisecond * 0.001) +
                            (time!.microsecond * 0.000001);
                        timeStamp.add(timesec);
                        coordn.add(null);
                      });
                    },
                    child: RepaintBoundary(
                        key: _LSPkey,
                        child: Stack(
                          children: <Widget>[
                            CustomPaint(
                              child: Container(
                                height: _height,
                                width: _width,
                              ),
                              painter: TemplatePainter(0),
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
            ]));
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
