class DataModel {
  List<dynamic> classes;
  List<dynamic> teachers;
  List<dynamic> ids_classes;
  List<dynamic> ids_teachers;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'classes': classes,
      'teachers': teachers,
      'ids_classes': ids_classes,
      'ids_teachers': ids_teachers,
    };
    return map;
  }

  DataModel.fromMap(Map<String, dynamic> map) {
    classes = map['classes'];
    teachers = map['teachers'];
    ids_classes = map['ids_classes'];
    ids_teachers = map['ids_teachers'];
  }
}

@deprecated
class DataItemModel {
  String id;
  String ver;
  String name;
  String selected;
}
