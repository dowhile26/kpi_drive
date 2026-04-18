// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskCWProxy {
  Task name(String name);

  Task indicatorToMoId(int indicatorToMoId);

  Task parentId(int parentId);

  Task parentName(String parentName);

  Task order(int order);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Task(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Task(...).copyWith(id: 12, name: "My name")
  /// ```
  Task call({
    String name,
    int indicatorToMoId,
    int parentId,
    String parentName,
    int order,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTask.copyWith(...)` or call `instanceOfTask.copyWith.fieldName(value)` for a single field.
class _$TaskCWProxyImpl implements _$TaskCWProxy {
  const _$TaskCWProxyImpl(this._value);

  final Task _value;

  @override
  Task name(String name) => call(name: name);

  @override
  Task indicatorToMoId(int indicatorToMoId) =>
      call(indicatorToMoId: indicatorToMoId);

  @override
  Task parentId(int parentId) => call(parentId: parentId);

  @override
  Task parentName(String parentName) => call(parentName: parentName);

  @override
  Task order(int order) => call(order: order);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Task(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Task(...).copyWith(id: 12, name: "My name")
  /// ```
  Task call({
    Object? name = const $CopyWithPlaceholder(),
    Object? indicatorToMoId = const $CopyWithPlaceholder(),
    Object? parentId = const $CopyWithPlaceholder(),
    Object? parentName = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return Task(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      indicatorToMoId:
          indicatorToMoId == const $CopyWithPlaceholder() ||
              indicatorToMoId == null
          ? _value.indicatorToMoId
          // ignore: cast_nullable_to_non_nullable
          : indicatorToMoId as int,
      parentId: parentId == const $CopyWithPlaceholder() || parentId == null
          ? _value.parentId
          // ignore: cast_nullable_to_non_nullable
          : parentId as int,
      parentName:
          parentName == const $CopyWithPlaceholder() || parentName == null
          ? _value.parentName
          // ignore: cast_nullable_to_non_nullable
          : parentName as String,
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as int,
    );
  }
}

extension $TaskCopyWith on Task {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTask.copyWith(...)` or `instanceOfTask.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaskCWProxy get copyWith => _$TaskCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  name: json['name'] as String? ?? '',
  indicatorToMoId: (json['indicator_to_mo_id'] as num).toInt(),
  parentId: (json['parent_id'] as num).toInt(),
  parentName: json['parent_name'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'name': instance.name,
  'indicator_to_mo_id': instance.indicatorToMoId,
  'parent_id': instance.parentId,
  'parent_name': instance.parentName,
  'order': instance.order,
};
