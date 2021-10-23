import 'package:flutter/cupertino.dart';

class CheckProvider extends ChangeNotifier{
  bool _checkIn=false;
  set checkIn(value){
    _checkIn=value;
  }
  get checkIn=>this._checkIn;
}