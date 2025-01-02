import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  // Fields corresponding to the SQL table columns
  int _appid;
  String? _appname;
  int _targettableid;
  int _targetmode;
  int _targetdatasourceid;
  int _applogoid;
  int _titleimageid;
  int _apptype;
  int? _seq;
  String? _baseurl;

  // Constructor
  AppModel({
    required int appid,
    String? appname,
    int targettableid = 0,
    int targetmode = 0,
    int targetdatasourceid = 0,
    int applogoid = 0,
    int titleimageid = 0,
    int apptype = 0,
    int? seq,
    String? baseurl,
  })  : _appid = appid,
        _appname = appname,
        _targettableid = targettableid,
        _targetmode = targetmode,
        _targetdatasourceid = targetdatasourceid,
        _applogoid = applogoid,
        _titleimageid = titleimageid,
        _apptype = apptype,
        _seq = seq,
        _baseurl = baseurl;

  // Getters
  int get appid => _appid;
  String? get appname => _appname;
  int get targettableid => _targettableid;
  int get targetmode => _targetmode;
  int get targetdatasourceid => _targetdatasourceid;
  int get applogoid => _applogoid;
  int get titleimageid => _titleimageid;
  int get apptype => _apptype;
  int? get seq => _seq;
  String? get baseurl => _baseurl;

  // Setters with notifyListeners for state changes
  set appname(String? value) {
    _appname = value;
    notifyListeners();
  }

  set targettableid(int value) {
    _targettableid = value;
    notifyListeners();
  }

  set targetmode(int value) {
    _targetmode = value;
    notifyListeners();
  }

  set targetdatasourceid(int value) {
    _targetdatasourceid = value;
    notifyListeners();
  }

  set applogoid(int value) {
    _applogoid = value;
    notifyListeners();
  }

  set titleimageid(int value) {
    _titleimageid = value;
    notifyListeners();
  }

  set apptype(int value) {
    _apptype = value;
    notifyListeners();
  }

  set seq(int? value) {
    _seq = value;
    notifyListeners();
  }

  set baseurl(String? value) {
    _baseurl = value;
    notifyListeners();
  }

  // Method to update app data
  void updateAppData({
    int? appid,
    String? appname,
    int? targettableid,
    int? targetmode,
    int? targetdatasourceid,
    int? applogoid,
    int? titleimageid,
    int? apptype,
    int? seq,
    String? baseurl,
  }) {
    _appid = appid ?? _appid;
    _appname = appname ?? _appname;
    _targettableid = targettableid ?? _targettableid;
    _targetmode = targetmode ?? _targetmode;
    _targetdatasourceid = targetdatasourceid ?? _targetdatasourceid;
    _applogoid = applogoid ?? _applogoid;
    _titleimageid = titleimageid ?? _titleimageid;
    _apptype = apptype ?? _apptype;
    _seq = seq ?? _seq;
    _baseurl = baseurl ?? _baseurl;
    notifyListeners();
  }

  // Factory method to create from JSON
  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      appid: json['_appid'] ?? 0,
      appname: json['_appname'],
      targettableid: json['_targettableid'] ?? 0,
      targetmode: json['_targetmode'] ?? 0,
      targetdatasourceid: json['_targetdatasourceid'] ?? 0,
      applogoid: json['_applogoid'] ?? 0,
      titleimageid: json['_titleimageid'] ?? 0,
      apptype: json['_apptype'] ?? 0,
      seq: json['_seq'],
      baseurl: json['_baseurl'],
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      '_appid': _appid,
      '_appname': _appname,
      '_targettableid': _targettableid,
      '_targetmode': _targetmode,
      '_targetdatasourceid': _targetdatasourceid,
      '_applogoid': _applogoid,
      '_titleimageid': _titleimageid,
      '_apptype': _apptype,
      '_seq': _seq,
      '_baseurl': _baseurl,
    };
  }
}