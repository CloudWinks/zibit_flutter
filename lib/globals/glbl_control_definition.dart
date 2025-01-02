import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zibit_flutter/data/CWButton.dart';
import 'package:zibit_flutter/data/CWField.dart';
import 'package:zibit_flutter/data/CWParameter.dart';

class ControlDefinition extends ChangeNotifier {
  int controlId;
  int controltype;
  int mode;
  String name;
  String layout;
  int formatid;
  int menutype;
  int gridcolumns;
  bool titlebar;
  String title;
  String titlefield;
  String titleimagefield;
  bool pickcontact;
  bool getgeo;
  int targetcontrolid;
  int targetcontrolmode;
  List<Field> fields;
  List<Parameter> params;
  List<Button> buttons;
 // List<Action> actions;

  ControlDefinition({
    required this.controlId,
    required this.controltype,
    required this.mode,
    required this.name,
    required this.layout,
    required this.formatid,
    required this.menutype,
    required this.gridcolumns,
    required this.titlebar,
    required this.title,
    required this.titlefield,
    required this.titleimagefield,
    required this.pickcontact,
    required this.getgeo,
    required this.targetcontrolid,
    required this.targetcontrolmode,
    required this.fields,
    required this.params,
    required this.buttons,
    //required this.actions,
  });

  // Factory constructor to create from JSON
  factory ControlDefinition.fromJson(Map<String, dynamic> json) {
    return ControlDefinition(
      controlId: json['controlId'],
      controltype: json['controltype'],
      mode: json['mode'],
      name: json['name'],
      layout: json['layout'],
      formatid: json['formatid'],
      menutype: json['menutype'],
      gridcolumns: json['gridcolumns'],
      titlebar: json['titlebar'],
      title: json['title'],
      titlefield: json['titlefield'],
      titleimagefield: json['titleimagefield'],
      pickcontact: json['pickcontact'],
      getgeo: json['_getgeo'],
      targetcontrolid: json['targetcontrolid'],
      targetcontrolmode: json['targetcontrolmode'],
      fields: List<Field>.from(json['fields'].map((x) => Field.fromJson(x))),
      params: List<Parameter>.from(json['params'].map((x) => Parameter.fromJson(x))),
      buttons: List<Button>.from(json['buttons'].map((x) => Button.fromJson(x))),
//      actions: List<Action>.from(json['actions'].map((x) => Action.fromJson(x))),
    );
  }
}