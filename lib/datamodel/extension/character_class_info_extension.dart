import 'package:collection/collection.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/subclass.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';

extension CharacterClassInfoExtension on CharacterClassInfo {
  bool matchClass(Class5e cl) =>
      cl.name == className && cl.source == classSource;

  Class5e? getClass() =>
      DataModel5e.classes.firstWhereOrNull((x) => matchClass(x));

  bool matchSubClass(SubClass subClass) =>
      subClass.className == className &&
      subClass.classSource == classSource &&
      subClass.name == subClassName &&
      subClass.source == subClassSource;

  SubClass? getSubClass() =>
      DataModel5e.subClasses.firstWhereOrNull((x) => matchSubClass(x));
}
