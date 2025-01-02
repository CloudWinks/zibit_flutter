class Button {
  int buttonid;
  int seq;
  String name;
  String action;
  String keyid;
  int targetcontrolid;
  int targettableid;
  int targetcontrolmodeid;

  Button({
    required this.buttonid,
    required this.seq,
    required this.name,
    required this.action,
    required this.keyid,
    required this.targetcontrolid,
    required this.targettableid,
    required this.targetcontrolmodeid,
  });

  // Factory constructor to create from JSON
  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      buttonid: json['buttonid'],
      seq: json['seq'],
      name: json['name'],
      action: json['action'],
      keyid: json['keyid'],
      targetcontrolid: json['targetcontrolid'],
      targettableid: json['targettableid'],
      targetcontrolmodeid: json['targetcontrolmodeid'],
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'buttonid': buttonid,
      'seq': seq,
      'name': name,
      'action': action,
      'keyid': keyid,
      'targetcontrolid': targetcontrolid,
      'targettableid': targettableid,
      'targetcontrolmodeid': targetcontrolmodeid,
    };
  }
}