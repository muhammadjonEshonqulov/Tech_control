import 'package:floor/floor.dart';

@entity
class TypeData {
  @primaryKey
  int id;
  String? text;

  TypeData({required this.text, required this.id});

  factory TypeData.fromJson(Map<String, dynamic> json) {
    return TypeData(text: json['text'], id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['_id'] = id;
    return data;
  }
}
