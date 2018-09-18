class DataModel {
  List<DataItemModel> classes;
  List<DataItemModel> teachers;
  List<dynamic> ids_classes;
  List<dynamic> ids_teachers;

  Map<String, dynamic> toMap() {
    List<dynamic> classesMap = List();
    classes.forEach((dataItemModel) =>
      classesMap.add(dataItemModel.toMap())
    );
    List<dynamic> teachersMap = List();
    teachers.forEach((dataItemModel) =>
        teachersMap.add(dataItemModel.toMap())
    );
    var map = <String, dynamic>{
      'classes': classesMap,
      'teachers': teachersMap,
      'ids_classes': ids_classes,
      'ids_teachers': ids_teachers,
    };
    return map;
  }

  DataModel.fromMap(Map<String, dynamic> map) {
    classes = List();
    map['classes'].forEach((dataItemModel) =>
      classes.add(DataItemModel.fromMap(dataItemModel))
    );
    teachers = List();
    map['teachers'].forEach((dataItemModel) =>
      teachers.add(DataItemModel.fromMap(dataItemModel))
    );
    ids_classes = map['ids_classes'];
    ids_teachers = map['ids_teachers'];
  }
}

class DataItemModel {
  String id;
  String ver;
  String name;
  String type;
  String selected;

  DataItemModel(this.id, this.ver, this.name);

  Map<String, dynamic> toMap({String setType: '0', String setSelected: '0'}) {
    var map = <String, dynamic>{
      'id': id,
      'ver': ver,
      'name': name,
      'type': type != null ? type : setType,
      'selected': selected != null ? selected : setSelected,
    };
    return map;
  }

  DataItemModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ver = map['ver'];
    name = map['name'];
    type = map['type'];
    selected = map['selected'];
  }
}
