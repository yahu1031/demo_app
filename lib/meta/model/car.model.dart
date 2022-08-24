import 'package:freezed_annotation/freezed_annotation.dart';

part 'car.model.freezed.dart';
part 'car.model.g.dart';

@freezed
class CarModel with _$CarModel{
  const CarModel._();
  factory CarModel({
    required String brand,
    required String model,
    required String color,
    required String number,
  }) = _CarModel;

  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
}