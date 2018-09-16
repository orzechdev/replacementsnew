class ReplacementsModel extends Object {
  ReplacementsModel(this.replacements, this.ids);

  List<ReplacementModel> replacements;
  List<String> ids;
}

class ReplacementModel extends Object {
  ReplacementModel(this.id, this.ver, this.replacement, this.number, this.classNumber, this.defaultInteger);

  ReplacementModel.typeInfo(this.id, this.ver, this.replacement);

  int id;
  String ver;
  String replacement;
  int number;
  int classNumber;
  int defaultInteger;
}