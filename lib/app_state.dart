import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _cardNumber = prefs.getString('ff_cardNumber') ?? _cardNumber;
    _cardHolderName = prefs.getString('ff_cardHolderName') ?? _cardHolderName;
    _cardName = prefs.getString('ff_cardName') ?? _cardName;
    _zipCode = prefs.getString('ff_zipCode') ?? _zipCode;
  }

  late SharedPreferences prefs;

  String _cardNumber = '';
  String get cardNumber => _cardNumber;
  set cardNumber(String _value) {
    notifyListeners();

    _cardNumber = _value;
    prefs.setString('ff_cardNumber', _value);
  }

  String _cardHolderName = '';
  String get cardHolderName => _cardHolderName;
  set cardHolderName(String _value) {
    notifyListeners();

    _cardHolderName = _value;
    prefs.setString('ff_cardHolderName', _value);
  }

  String _cardName = '';
  String get cardName => _cardName;
  set cardName(String _value) {
    notifyListeners();

    _cardName = _value;
    prefs.setString('ff_cardName', _value);
  }

  String _zipCode = '';
  String get zipCode => _zipCode;
  set zipCode(String _value) {
    notifyListeners();

    _zipCode = _value;
    prefs.setString('ff_zipCode', _value);
  }

  bool _visibleSuperlike = false;
  bool get visibleSuperlike => _visibleSuperlike;
  set visibleSuperlike(bool _value) {
    notifyListeners();

    _visibleSuperlike = _value;
  }

  bool _visibleLike = false;
  bool get visibleLike => _visibleLike;
  set visibleLike(bool _value) {
    notifyListeners();

    _visibleLike = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
