import '../../../../global_entity_model/localized_text/localized_text_entity.dart';

class LocalizedTextModel extends LocalizedTextEntity {
  LocalizedTextModel({required super.ru, required super.uz});

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) {
    return LocalizedTextModel(ru: json['ru'], uz: json['uz']);
  }

  Map<String, dynamic> toJson() {
    return {'uz': uz, 'ru': ru};
  }


}
