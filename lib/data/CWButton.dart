class Button {
  int buttonid;
  int seq;
  String? name;
  String? action;
  String? keyid;
  int? targetcontrolid;
  int? targettableid;
  int? targetcontrolmodeid;

  Button({
    required this.buttonid,
    required this.seq,
    this.name,
    this.action,
    this.keyid,
    this.targetcontrolid,
    this.targettableid,
    this.targetcontrolmodeid,
  });

  // Factory constructor to create from JSON
  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      buttonid: json['buttonid'] ?? 0,
      seq: json['seq'] ?? 0,
      name: json['name'],
      // Handle action field as either int or string
      action: json['action'] != null ? json['action'].toString() : null,
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
