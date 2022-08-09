import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert' show jsonEncode, utf8;
import 'dart:typed_data' show ByteData, Uint8List;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../pages/_1_infopage.dart';
import '../pages/_2_spiralpage.dart';
import '../pages/_3_verticalpage.dart';
import '../pages/_4_horizontalpage.dart';
import '../pages/_5_letterpage.dart';
import '../pages/_5.5_THletterpage.dart';

class _JSobj {
  String name = InfoPage.firstname! + ' ' + InfoPage.surname!;
  String age = InfoPage.age!;
  String sex = InfoPage.sex!;
  String id = InfoPage.id!;
  String domhand = InfoPage.domhand!;
  String
      spRcX = list2str(SpiralPage.rhspCO,'dx'),
      spRcY = list2str(SpiralPage.rhspCO,'dy'),
      spRsT = SpiralPage.rhspTS.toString(),
      spLcX = list2str(SpiralPage.lhspCO,'dx'),
      spLcY = list2str(SpiralPage.lhspCO,'dy'),
      spLsT = SpiralPage.lhspTS.toString(),

      vlRcX = list2str(VerticalPage.rhvlCO,'dx'),
      vlRcY = list2str(VerticalPage.rhvlCO,'dy'),
      vlRsT = VerticalPage.rhvlTS.toString(),
      vlLcX = list2str(VerticalPage.lhvlCO,'dx'),
      vlLcY = list2str(VerticalPage.lhvlCO,'dy'),
      vlLsT = VerticalPage.lhvlTS.toString(),

      hlRcX = list2str(HorizontalPage.rhhlCO,'dx'),
      hlRcY = list2str(HorizontalPage.rhhlCO,'dy'),
      hlRsT = HorizontalPage.rhhlTS.toString(),
      hlLcX = list2str(HorizontalPage.lhhlCO,'dx'),
      hlLcY = list2str(HorizontalPage.lhhlCO,'dy'),
      hlLsT = HorizontalPage.lhhlTS.toString(),

      wlRcX = list2str(LetterPage.rhwlCO,'dx'),
      wlRcY = list2str(LetterPage.rhwlCO,'dy'),
      wlRsT = LetterPage.rhwlTS.toString(),
      wlLcX = list2str(LetterPage.lhwlCO,'dx'),
      wlLcY = list2str(LetterPage.lhwlCO,'dy'),
      wlLsT = LetterPage.lhwlTS.toString(),

      THlRcX = list2str(THLettersPage.rhTHlCO,'dx'),
      THlRcY = list2str(THLettersPage.rhTHlCO,'dy'),
      THlRsT = THLettersPage.rhTHlTS.toString(),
      THlLcX = list2str(THLettersPage.lhTHlCO,'dx'),
      THlLcY = list2str(THLettersPage.lhTHlCO,'dy'),
      THlLsT = THLettersPage.lhTHlTS.toString()

  ;

  _JSobj();

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'Age': age,
        'Sex': sex,
        'Dominant Hand': domhand,

        'Spiral R dx': spRcX,
        'Spiral R dy': spRcY,
        'Spiral R Timestamp': spRsT,
        'Spiral L dX': spLcX,
        'Spiral L dY': spLcY,
        'Spiral L Timestamp': spLsT,

        'Vertical R dx': vlRcX,
        'Vertical R dy': vlRcY,
        'Vertical R Timestamp': vlRsT,
        'Vertical L dx': vlLcX,
        'Vertical L dy': vlLcY,
        'Vertical L Timestamp': vlLsT,

        'Horizontal R dx': hlRcX,
        'Horizontal R dy': hlRcY,
        'Horizontal R Timestamp': hlRsT,
        'Horizontal L dx': hlLcX,
        'Horizontal L dy': hlLcY,
        'Horizontal L Timestamp': hlLsT,

        'Letters R dx': wlRcX,
        'Letters R dy': wlRcY,
        'Letters R Timestamp': wlRsT,
        'Letters L dx': wlLcX,
        'Letters L dy': wlLcY,
        'Letters L Timestamp': wlLsT,

        'TH Letters R dx' : THlRcX,
        'TH Letters R dy' : THlRcY,
        'TH Letters R Timestamp' : THlRsT,
        'TH Letters L dx' : THlLcX,
        'TH Letters L dy' : THlLcY,
        'TH Letters L Timestamp' : THlLsT,

      };
}

String list2str(List coordn, String axis){
  String COORtemp = '';
  List dX = [];
  List dY = [];
  bool isNull;
  String wholedata = '';

  if(axis == 'dx'){
    for (int i = 0; i < coordn.length; i++) {
      isNull = (coordn[i] == null);
      if (isNull) {coordn[i] ?? dX.add("null");}
      else {dX.add((coordn[i].dx).toStringAsFixed(2));}
      COORtemp = dX[i];
      wholedata = wholedata + COORtemp;
      wholedata = wholedata + ', ';
    }
  }
  else if (axis == 'dy'){
    for (int i = 0; i < coordn.length; i++) {
      isNull = (coordn[i] == null);
      if (isNull) {coordn[i] ?? dY.add("null");}
      else {dY.add((coordn[i].dy).toStringAsFixed(2));}
      COORtemp = dY[i];
      wholedata = wholedata + COORtemp;
      wholedata = wholedata + ', ';
    }
  }
  return wholedata;
}

Future createJSON(context) async {
  await Firebase.initializeApp();

  var _json = _JSobj();
  String json = jsonEncode(_json);
  var jsonData = utf8.encode(json);
  Uint8List JSON = Uint8List.fromList(jsonData);

  firebase_storage.UploadTask uploadJSON;
  firebase_storage.Reference ref = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child(InfoPage.id!)
      .child("${InfoPage.id}_rawdata.json");

  uploadJSON = ref.putData(JSON);
}

Future uploadImg(GlobalKey widgetkey, String label) async {
  await Firebase.initializeApp();

  RenderRepaintBoundary boundary =
  widgetkey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();

  firebase_storage.UploadTask uploadImg;
  firebase_storage.Reference refImg = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child(InfoPage.id!)
      .child("${InfoPage.id}_$label.png");

  uploadImg = refImg.putData(pngBytes);
}
