// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChildModelImpl _$$ChildModelImplFromJson(Map<String, dynamic> json) =>
    _$ChildModelImpl(
      childId: (json['childId'] as num?)?.toInt(),
      name: json['name'] as String?,
      age: EChildAge.fromJson(json['age'] as String?),
      gender: EChildGender.fromJson(json['gender'] as String?),
      childImg: json['childImg'] as String?,
      tag: (json['tag'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$ChildModelImplToJson(_$ChildModelImpl instance) =>
    <String, dynamic>{
      'childId': instance.childId,
      'name': instance.name,
      'age': EChildAge.toJson(instance.age),
      'gender': EChildGender.toJson(instance.gender),
      'childImg': instance.childImg,
      'tag': instance.tag,
    };
