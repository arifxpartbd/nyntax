
import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectVehicleType extends VehicleEvent{
  final String selectedType;

  SelectVehicleType({required this.selectedType});
  @override
  List<Object?> get props => [selectedType];
}


class CallVehicle extends VehicleEvent {
  final int typeIndex;
  final String? selectedModel;
  CallVehicle({required this.typeIndex, this.selectedModel});

  @override
  List<Object?> get props => [typeIndex];
}

class FilterCars extends VehicleEvent {
  final String model;
  final String? selectedType;

  FilterCars({required this.model, required this.selectedType});

  @override
  List<Object?> get props => [model, selectedType];
}