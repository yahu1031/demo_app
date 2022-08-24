// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'car.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CarModel _$CarModelFromJson(Map<String, dynamic> json) {
  return _CarModel.fromJson(json);
}

/// @nodoc
mixin _$CarModel {
  String get brand => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarModelCopyWith<CarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarModelCopyWith<$Res> {
  factory $CarModelCopyWith(CarModel value, $Res Function(CarModel) then) =
      _$CarModelCopyWithImpl<$Res>;
  $Res call({String brand, String model, String color, String number});
}

/// @nodoc
class _$CarModelCopyWithImpl<$Res> implements $CarModelCopyWith<$Res> {
  _$CarModelCopyWithImpl(this._value, this._then);

  final CarModel _value;
  // ignore: unused_field
  final $Res Function(CarModel) _then;

  @override
  $Res call({
    Object? brand = freezed,
    Object? model = freezed,
    Object? color = freezed,
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      brand: brand == freezed
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CarModelCopyWith<$Res> implements $CarModelCopyWith<$Res> {
  factory _$$_CarModelCopyWith(
          _$_CarModel value, $Res Function(_$_CarModel) then) =
      __$$_CarModelCopyWithImpl<$Res>;
  @override
  $Res call({String brand, String model, String color, String number});
}

/// @nodoc
class __$$_CarModelCopyWithImpl<$Res> extends _$CarModelCopyWithImpl<$Res>
    implements _$$_CarModelCopyWith<$Res> {
  __$$_CarModelCopyWithImpl(
      _$_CarModel _value, $Res Function(_$_CarModel) _then)
      : super(_value, (v) => _then(v as _$_CarModel));

  @override
  _$_CarModel get _value => super._value as _$_CarModel;

  @override
  $Res call({
    Object? brand = freezed,
    Object? model = freezed,
    Object? color = freezed,
    Object? number = freezed,
  }) {
    return _then(_$_CarModel(
      brand: brand == freezed
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CarModel extends _CarModel {
  _$_CarModel(
      {required this.brand,
      required this.model,
      required this.color,
      required this.number})
      : super._();

  factory _$_CarModel.fromJson(Map<String, dynamic> json) =>
      _$$_CarModelFromJson(json);

  @override
  final String brand;
  @override
  final String model;
  @override
  final String color;
  @override
  final String number;

  @override
  String toString() {
    return 'CarModel(brand: $brand, model: $model, color: $color, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CarModel &&
            const DeepCollectionEquality().equals(other.brand, brand) &&
            const DeepCollectionEquality().equals(other.model, model) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.number, number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(brand),
      const DeepCollectionEquality().hash(model),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(number));

  @JsonKey(ignore: true)
  @override
  _$$_CarModelCopyWith<_$_CarModel> get copyWith =>
      __$$_CarModelCopyWithImpl<_$_CarModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CarModelToJson(
      this,
    );
  }
}

abstract class _CarModel extends CarModel {
  factory _CarModel(
      {required final String brand,
      required final String model,
      required final String color,
      required final String number}) = _$_CarModel;
  _CarModel._() : super._();

  factory _CarModel.fromJson(Map<String, dynamic> json) = _$_CarModel.fromJson;

  @override
  String get brand;
  @override
  String get model;
  @override
  String get color;
  @override
  String get number;
  @override
  @JsonKey(ignore: true)
  _$$_CarModelCopyWith<_$_CarModel> get copyWith =>
      throw _privateConstructorUsedError;
}
