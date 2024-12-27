class ObjButton {
  final String text;
  final int group;
  final int id;
  final int seq;
  final int action;
  final String key;
  final int targetIntentId;
  final int targetTableId;
  final int targetDatasourceId;
  final int targetModeId;
  String? value;

  ObjButton({
    required this.text,
    required this.group,
    required this.id,
    required this.seq,
    required this.action,
    required this.key,
    required this.targetIntentId,
    required this.targetTableId,
    required this.targetDatasourceId,
    required this.targetModeId,
    this.value,
  });

  String getText() {
    return text;
  }

  int getGroup() {
    return group;
  }

  int getId() {
    return id;
  }

  int getSeq() {
    return seq;
  }

  int getAction() {
    return action;
  }

  String getKey() {
    return key;
  }

  int getTargetDatasourceId() {
    return targetDatasourceId;
  }

  int getTargetIntentId() {
    return targetIntentId;
  }

  int getTargetModeId() {
    return targetModeId;
  }

  int getTargetTableId() {
    return targetTableId;
  }

  String? getValue() {
    return value;
  }

  void setValue(String value) {
    this.value = value;
  }
}
