import 'package:equatable/equatable.dart';

import '../../model/car.dart';

abstract class VehicleState extends Equatable {
  @override
  List<Object?> get props => [];

}

class VehicleInit extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleDataLoaded extends VehicleState {
  final List<String> typeList;

  final List<Car> cars; // Change this to accept a list of Car objects

  VehicleDataLoaded({required this.cars, required this.typeList,});

  @override
  List<Object?> get props => [cars, typeList];
}

class VehicleLoadFailed extends VehicleState {
  final String vehicleLoadError;

  VehicleLoadFailed({required this.vehicleLoadError});

  @override
  List<Object?> get props => [vehicleLoadError];
}