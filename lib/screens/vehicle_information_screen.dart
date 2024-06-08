import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyntax/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:nyntax/blocs/vehicle_bloc/vehicle_event.dart';
import 'package:nyntax/blocs/vehicle_bloc/vehicle_state.dart';
import 'package:nyntax/model/car.dart';
import 'package:nyntax/screens/additional_charge_screen.dart';
import 'package:nyntax/widgets/app_dropdown_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_constant.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';
import '../widgets/car_card_item.dart';

class VehicleInformationScreen extends StatefulWidget {
  const VehicleInformationScreen({super.key});

  @override
  State<VehicleInformationScreen> createState() =>
      _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {
  String? selectedType;
  TextEditingController modelController = TextEditingController();
  List<Car> filteredCars = [];

  String selectedModel = "";
  String selectedHourRate = "";
  String selectedDayRate = "";
  String selectedWeekRate = "";
  String saveSelectType = "";

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectVehicleType', saveSelectType ?? "");
    await prefs.setString('selectModel', selectedModel);
    await prefs.setString('hourRate', selectedHourRate);
    await prefs.setString('dayRate', selectedDayRate);
    await prefs.setString('weekRate', selectedWeekRate);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VehicleBloc>(context).add(CallVehicle(typeIndex: 0));
    modelController.addListener(_onModelChanged);
  }

  @override
  void dispose() {
    modelController.removeListener(_onModelChanged);
    modelController.dispose();
    super.dispose();
  }

  void _onModelChanged() {
    setState(() {
      _filterCars();
    });
  }

  void _filterCars() {
    final text = modelController.text.toLowerCase();
    final type = selectedType?.toLowerCase();

    setState(() {
      final currentState = BlocProvider.of<VehicleBloc>(context).state;
      if (currentState is VehicleDataLoaded) {
        filteredCars = currentState.cars.where((car) {
          final matchesModel = car.model.toLowerCase().contains(text);
          final matchesType = type == null || car.type.toLowerCase() == type;
          return matchesModel && matchesType;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            if (state is VehicleLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is VehicleLoadFailed) {
              return Center(child: Text(state.vehicleLoadError));
            }
            if (state is VehicleDataLoaded) {
              if (filteredCars.isEmpty) {
                filteredCars = state.cars;
              }
              return vehicleInformationForm(state.cars, state.typeList);
            } else {
              return const Center(child: Text("No car information"));
            }
          },
        ),
      ),
    );
  }

  Widget vehicleInformationForm(List<Car> cars, List<String> typeList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vehicle Information', style: titleTxt),
          const Divider(thickness: 1, color: appLineColor),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: appFieldColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Vehicle Type", style: subTxt),
                        TextSpan(
                          text: "*",
                          style: subTxt.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  AppDropdownField(
                    items: typeList,
                    value: selectedType ?? typeList[0],
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue;
                        _filterCars();
                        BlocProvider.of<VehicleBloc>(context).add(
                          SelectVehicleType(selectedType: selectedType!),
                        );
                      });
                    },
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Vehicle Model", style: subTxt),
                        TextSpan(
                          text: "*",
                          style: subTxt.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  AppInputField(
                    controller: modelController,
                    iconData: Icons.search_rounded,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCars.length,
              itemBuilder: (context, index) {
                final filterCar = filteredCars[index];
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        saveSelectType = filterCar.type.toString();
                        selectedModel = filterCar.model.toString();
                        selectedHourRate = filterCar.rates.hourly.toString();
                        selectedDayRate = filterCar.rates.daily.toString();
                        selectedWeekRate = filterCar.rates.weekly.toString();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("You Select $selectedModel car")));
                    },
                    child: CarCadItem(filterCar: filterCar));
              },
            ),
          ),
          const SizedBox(height: 10),
          AppButton(
            onPress: selectedModel.isNotEmpty
                ? () async {
                    await saveData();
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AdditionalChargeScreen();
                          },
                        ),
                      );
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
