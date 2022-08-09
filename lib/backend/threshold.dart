import 'dart:math';
import 'package:collection/collection.dart';
import 'package:tremorscreeningv2/pages/_1_infopage.dart';
import '../pages/_2_spiralpage.dart';
import '../pages/_3_verticalpage.dart';
import '../pages/_4_horizontalpage.dart';
import '../pages/_5_letterpage.dart';
import '../pages/_5.5_THletterpage.dart';

String calthreshold() {
  String result;
  int VspR,VspL,VvlR,VvlL,VhlR,VhlL,VwlR,VwlL,VTHlR,VTHlL,temp;
  List
      spRcX = list2double(SpiralPage.rhspCO, 'dx'),
      spRcY = list2double(SpiralPage.rhspCO, 'dy'),
      spRsT = SpiralPage.rhspTS,
      spLcX = list2double(SpiralPage.lhspCO, 'dx'),
      spLcY = list2double(SpiralPage.lhspCO, 'dy'),
      spLsT = SpiralPage.lhspTS,

      vlRcX = list2double(VerticalPage.rhvlCO, 'dx'),
      vlRcY = list2double(VerticalPage.rhvlCO, 'dy'),
      vlRsT = VerticalPage.rhvlTS,
      vlLcX = list2double(VerticalPage.lhvlCO, 'dx'),
      vlLcY = list2double(VerticalPage.lhvlCO, 'dy'),
      vlLsT = VerticalPage.lhvlTS,

      hlRcX = list2double(HorizontalPage.rhhlCO, 'dx'),
      hlRcY = list2double(HorizontalPage.rhhlCO, 'dy'),
      hlRsT = HorizontalPage.rhhlTS,
      hlLcX = list2double(HorizontalPage.lhhlCO, 'dx'),
      hlLcY = list2double(HorizontalPage.lhhlCO, 'dy'),
      hlLsT = HorizontalPage.lhhlTS,

      wlRcX = list2double(LetterPage.rhwlCO,'dx'),
      wlRcY = list2double(LetterPage.rhwlCO,'dy'),
      wlRsT = LetterPage.rhwlTS,
      wlLcX = list2double(LetterPage.lhwlCO,'dx'),
      wlLcY = list2double(LetterPage.lhwlCO,'dy'),
      wlLsT = LetterPage.lhwlTS,

      THlRcX = list2double(THLettersPage.rhTHlCO,'dx'),
      THlRcY = list2double(THLettersPage.rhTHlCO,'dy'),
      THlRsT = THLettersPage.rhTHlTS,
      THlLcX = list2double(THLettersPage.lhTHlCO,'dx'),
      THlLcY = list2double(THLettersPage.lhTHlCO,'dy'),
      THlLsT = THLettersPage.lhTHlTS
  ;

  VspR = thresholdcut(calV(spRcX,spRcY,spRsT));
  VspL = thresholdcut(calV(spLcX,spLcY,spLsT));
  VvlR = thresholdcut(calV(vlRcX,vlRcY,vlRsT));
  VvlL = thresholdcut(calV(vlLcX,vlLcY,vlLsT));
  VhlR = thresholdcut(calV(hlRcX,hlRcY,hlRsT));
  VhlL = thresholdcut(calV(hlLcX,hlLcY,hlLsT));
  VwlR = thresholdcut(calV(wlRcX,wlRcY,wlRsT));
  VwlL = thresholdcut(calV(wlLcX,wlLcY,wlLsT));
  VTHlR = thresholdcut(calV(THlRcX,THlRcY,THlRsT));
  VTHlL = thresholdcut(calV(THlLcX,THlLcY,THlLsT));

  temp = VspR+VspL+VvlR+VvlL+VhlR+VhlL+VwlR+VwlL+VTHlR+VTHlL;
  if(temp>=5){
    result = 'ท่านมีความเสี่ยงเป็นโรคพาร์กินสัน';
  }
  else{
    result = 'ท่านไม่มีความเสี่ยงเป็นโรคพาร์กินสัน';
  }
  print(result);
  return result;
}

double calV(dx,dy,t) {
  double velocity;
  double temp;
  List<double> S = [];
  for(int i=0; i<dx.length-2; i++){
    S.add(sqrt((pow((dx[i+1] - dx[i]),2)) + (pow((dy[i+1] - dy[i]),2))));
  }
  temp = (S.sum)*(InfoPage.dpr);
  if (temp == 0) {
    velocity = 0;
  }
  else{
    velocity = temp/(t[t.length-1] - t[0]);
  }
  return velocity;
}

int thresholdcut(V) {
  int pass;
  double threshold = 2204.724409449;
  if(V>= threshold){
    pass = 1;
  } else{
    pass = 0;
  }
  return pass;
}

List list2double(List<dynamic> coordn, String axis) {
  List<double> COOR = [];
  List<double> dX = [];
  List<double> dY = [];
  bool isNull;

  if (axis == 'dx') {
    for (int i = 0; i < coordn.length-1; i++) {
      isNull = (coordn[i] == null);
      if (isNull) {
        coordn[i] ?? dX.add(0);
      }
      else {
        dX.add((coordn[i].dx));
      }
      COOR = dX;
    }
  } else if (axis == 'dy') {
    for (int i = 0; i < coordn.length-1; i++) {
      isNull = (coordn[i] == null);
      if (isNull) {
        coordn[i] ?? dY.add(0);
      }
      else {
        dY.add((coordn[i].dy));
      }
    }
    COOR = dY;
  }
  return COOR;
}
