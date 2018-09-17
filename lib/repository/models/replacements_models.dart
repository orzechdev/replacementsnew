class ReplacementsModel extends Object {
  ReplacementsModel(this.replacements, this.ids);

  List<dynamic> replacements;
  List<dynamic> ids;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'replacements': replacements,
      'ids': ids,
    };
    return map;
  }

  ReplacementsModel.fromMap(Map<String, dynamic> map) {
    replacements = map['replacements'];
    ids = map['ids'];
  }
}

@deprecated
class ReplacementModel extends Object {
  ReplacementModel(this.id, this.ver, this.replacement, this.number, this.classNumber, this.defaultInteger);

  ReplacementModel.typeInfo(this.id, this.ver, this.replacement);

  String id;
  String ver;
  String number;
  String firstNumber;
  String lastNumber;
  String replacement;
  String defaultInteger;
  String classNumber;
}