import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nyntax/app_constant.dart';
import 'package:nyntax/screens/customer_information_screen.dart';
import 'package:nyntax/widgets/app_data_time_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';

class ReservationDetailsScreen extends StatefulWidget {
  const ReservationDetailsScreen({super.key});

  @override
  State<ReservationDetailsScreen> createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  TextEditingController reservationIdController = TextEditingController();
  TextEditingController pickUpDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('reservationId', reservationIdController.text);
    await prefs.setString('pickUpDate', pickUpDateController.text);
    await prefs.setString('returnDate', returnDateController.text);
    await prefs.setString('duration', durationController.text);
    await prefs.setString('discount', discountController.text);
  }

  void updateDuration() {
    if (pickUpDateController.text.isNotEmpty &&
        returnDateController.text.isNotEmpty) {
      DateTime pickUpDate = DateTime.parse(pickUpDateController.text);
      DateTime returnDate = DateTime.parse(returnDateController.text);

      String duration = calculateDuration(pickUpDate, returnDate);
      durationController.text = duration;
    }
  }

  Future<void> appDateTimePicker(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        //controller.text = DateFormat('h:mm a, dd MMMM yyyy').format(selectedDateTime);
        controller.text = selectedDateTime.toIso8601String();
        updateDuration(); // Update duration after selecting date and time
      }
    }
  }

  String calculateDuration(DateTime start, DateTime end) {
    Duration difference = end.difference(start);
    int days = difference.inDays;
    int weeks = days ~/ 7;
    int remainingDays = days % 7;

    String result = '';
    if (weeks > 0) {
      result += '$weeks Week${weeks > 1 ? 's' : ''} ';
    }
    if (remainingDays > 0) {
      result += '$remainingDays Day${remainingDays > 1 ? 's' : ''}';
    }

    return result.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: reservationForm(),
    );
  }

  Widget reservationForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reservation Details', style: titleTxt),
          const Divider(
            thickness: 1,
            color: appLineColor,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: appFieldColor)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Reservation ID", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      controller: reservationIdController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please type Reservation ID";
                        }
                        return null;
                      },
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Pickup Date", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      controller: pickUpDateController,
                      onlyRead: true,
                      onPress: () =>
                          appDateTimePicker(context, pickUpDateController),
                      iconData: Icons.calendar_today_outlined,
                      hintText: "Select Date and Time",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Select Pickup Date";
                        }
                        return null;
                      },
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Return Date", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      onlyRead: true,
                      controller: returnDateController,
                      onPress: () =>
                          appDateTimePicker(context, returnDateController),
                      iconData: Icons.calendar_today_outlined,
                      hintText: "Select Date and Time",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Select Return Date";
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Duration",
                              style: subTxt,
                            )),
                        Expanded(
                            flex: 3,
                            child: AppInputField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please type Duration";
                                }
                                return null;
                              },
                              controller: durationController,
                              hintText: "1 Week 2 Days",
                              onlyRead: true, // Make it read-only
                            )),
                      ],
                    ),
                    Text(
                      "Discount",
                      style: subTxt,
                    ),
                    AppInputField(
                      controller: discountController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          AppButton(
            onPress: () async {
              if (formKey.currentState!.validate()) {
                await saveData();
                if (mounted) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CustomerInformationScreen();
                  }));
                }
              }
            },
          )
        ],
      ),
    );
  }
}
