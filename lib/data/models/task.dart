import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
@CopyWith()
class Task {
  final String name;
  @JsonKey(name: 'indicator_to_mo_id')
  final int indicatorToMoId;
  @JsonKey(name: 'parent_id')
  final int parentId;
  @JsonKey(name: 'parent_name')
  final String parentName;
  final int order;

  Task({
    this.name = '',
    required this.indicatorToMoId,
    required this.parentId,
    required this.parentName,
    required this.order,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
