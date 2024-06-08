import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyntax/api_service/api_call.dart';
import 'package:nyntax/blocs/vehicle_bloc/vehicle_event.dart';
import 'package:nyntax/blocs/vehicle_bloc/vehicle_state.dart';
import 'package:nyntax/model/car.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInit()) {
    ApiCall apiCall = ApiCall();
    List<String> vehicleTypes = [];
    List<Car> _allCars = [];


    on<CallVehicle>((event, emit) async {
      emit(VehicleLoading());

      try {
        final response = await apiCall.callCar();

        vehicleTypes = response.data.map((car) => car.type).toSet().toList();

        final List<Car> filteredCars =
        response.data.where((car) => car.type == vehicleTypes[event.typeIndex]).toList();

        emit(VehicleDataLoaded(cars: filteredCars, typeList: vehicleTypes));
      } catch (e) {
        emit(VehicleLoadFailed(vehicleLoadError: e.toString()));
      }
    });

    on<SelectVehicleType>((event, emit) async {
      emit(VehicleLoading());

      try {
        final response = await apiCall.callCar();

        final List<Car> filteredCars =
        response.data.where((car) => car.type == event.selectedType).toList();

        emit(VehicleDataLoaded(cars: filteredCars, typeList: vehicleTypes ));
      } catch (e) {
        emit(VehicleLoadFailed(vehicleLoadError: e.toString()));
      }
    });

    on<FilterCars>((event, emit) {
      if (state is VehicleDataLoaded) {
        final currentState = state as VehicleDataLoaded;
        final text = event.model.toLowerCase();
        final type = event.selectedType?.toLowerCase();

        final filteredCars = _allCars.where((car) {
          final matchesModel = car.model.toLowerCase().contains(text);
          final matchesType = type == null || car.type.toLowerCase() == type;
          return matchesModel && matchesType;
        }).toList();

        emit(VehicleDataLoaded(cars: filteredCars, typeList: currentState.typeList));
      }
    });
  }
}
