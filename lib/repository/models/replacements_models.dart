class ReplacementsModel extends Object {
  ReplacementsModel(this.replacements, this.ids);

  List<ReplacementItemModel> replacements;
  List<dynamic> ids;

  Map<String, dynamic> toMap() {
    List<dynamic> replacementsMap = List();
    replacements.forEach((dataItemModel) =>
        replacementsMap.add(dataItemModel.toMap())
    );
    var map = <String, dynamic>{
      'replacements': replacements,
      'ids': ids,
    };
    return map;
  }

  ReplacementsModel.fromMap(Map<String, dynamic> map) {
    replacements = List();
    map['replacements'].forEach((replacementItemModel) {
      if (replacementItemModel['number'] != null) {
        replacements.add(ReplacementItemModel(replacementItemModel['id'], replacementItemModel['ver'], replacementItemModel['replacement'], replacementItemModel['number'], replacementItemModel['class_number'], replacementItemModel['default_integer']));
      } else {
        replacements.add(ReplacementItemModel.typeInfo(replacementItemModel['id'], replacementItemModel['ver'], replacementItemModel['replacement']));
      }
    });
    ids = map['ids'];
  }
}

class ReplacementItemModel extends Object {
  String id;
  String ver;
  String number;
  String firstNumber;
  String lastNumber;
  String replacement;
  String defaultInteger;
  String classNumber;

  ReplacementItemModel(this.id, this.ver, this.replacement, this.number, this.classNumber, this.defaultInteger);

  ReplacementItemModel.typeInfo(this.id, this.ver, this.replacement);

  Map<String, dynamic> toMap({String setFirstNumber: '0', String setLastNumber: '0'}) {
    var map = <String, dynamic>{
      'id': id,
      'ver': ver,
      'number': number,
      'first_number': firstNumber != null ? firstNumber : setFirstNumber,
      'last_number': lastNumber != null ? lastNumber : setLastNumber,
      'replacement': replacement,
      'default_integer': defaultInteger,
      'class_number': classNumber,
    };
    return map;
  }

  ReplacementItemModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ver = map['ver'];
    number = map['number'];
    firstNumber = map['first_number'];
    lastNumber = map['last_number'];
    replacement = map['replacement'];
    defaultInteger = map['default_integer'];
    classNumber = map['class_number'];
  }
}