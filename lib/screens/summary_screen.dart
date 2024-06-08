
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nyntax/local_data/local_database.dart';
import 'package:nyntax/widgets/sumary_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_constant.dart';
import '../model/additional_charge.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {

  String reservationId = '';
  String pickUpDate = '';
  String dropOffDate = '';
  String firstName = '';
  String lastName = '';
  String userEmail = '';
  String userPhone = '';
  String vehicleType = '';
  String vehicleModel = '';
  String weaklyRate = '';
  String dailyRate = '';
  String damageCharge = '';
  String hourlyRate = '';
  String duration = '';

  List<AdditionalCharge> additionalCharges = [];
  double totalAdditionalCharges = 0.0;


  Future<void> loadUserData() async {
    String? reservation = await LocalDatabase.getReservationId();
    String? pkDate = await LocalDatabase.getPickUpDate();
    String? drDate = await LocalDatabase.getReturnDate();
    String? fName = await LocalDatabase.getFirstName();
    String? lName = await LocalDatabase.getLastName();
    String? uEmail = await LocalDatabase.getUserEmail();
    String? uPhone = await LocalDatabase.getUserPhone();
    String? uVehicleM = await LocalDatabase.getSelectModel();
    String? uVehicleT = await LocalDatabase.getSelectVehicleType();
    String? uWeaklyR = await LocalDatabase.getWeekRate();
    String? uDailyR = await LocalDatabase.getDayRate();
    String? uHourlyR = await LocalDatabase.getHourRate();
    String? uDuration = await LocalDatabase.getDuration();

    // Load additional charges
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('selectedCharges');
    if (encodedData != null) {
      List<dynamic> decodedData = jsonDecode(encodedData);
      additionalCharges = decodedData.map((item) => AdditionalCharge.fromJson(item)).toList();

      // Calculate total additional charges
      totalAdditionalCharges = additionalCharges.fold(0.0, (sum, charge) => sum + charge.chargeAmount);
    }
    setState(() {
      reservationId = reservation ?? "";
      pickUpDate = pkDate ?? "";
      dropOffDate = drDate?? "";
      firstName = fName?? "";
      lastName = lName?? "";
      userEmail = uEmail ?? "";
      userPhone = uPhone?? "";
      vehicleType = uVehicleT?? '';
      vehicleModel =uVehicleM ?? "";
      weaklyRate = uWeaklyR?? "";
      dailyRate = uDailyR?? "";
      hourlyRate = uHourlyR?? "";
      duration = uDuration??"";
    });
  }


  @override
  void initState() {
    super.initState();
    loadUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: vehicleInformationForm(),
    );
  }
  Widget vehicleInformationForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reservation Details', style: titleTxt),
            const Divider(thickness: 1, color: appLineColor),
            SummaryCard(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Reservation id "),
                    Text(reservationId)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pickup Date"),
                    Text(pickUpDate)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dropoff Date"),
                    Text(dropOffDate)
                  ],
                )
        
              ],
            )),
        
            Text('Customer Information', style: titleTxt),
            const Divider(thickness: 1, color: appLineColor),
            SummaryCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("First Name"),
                        Text(firstName)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Last Name"),
                        Text(lastName)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Email"),
                        Text(userEmail)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Phone"),
                        Text(userPhone)
                      ],
                    )
        
                  ],
                )),
        
            Text('Vehicle Information', style: titleTxt),
            const Divider(thickness: 1, color: appLineColor),
            SummaryCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Vehicle Type"),
                        Text(vehicleType)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Vehicle Model"),
                        Text(vehicleModel)
                      ],
                    ),
                  ],
                )),
        
            Text('Charge Summary', style: titleTxt),
            const Divider(thickness: 1, color: appLineColor),
        
            SummaryCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Charge",style: subTxt.copyWith(fontWeight: FontWeight.bold),),
                      Text("Total",style: subTxt.copyWith(fontWeight: FontWeight.bold),),
                    ],),
                    const Divider(thickness: 1, color: appLineColor),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(duration),
                    //     Text(weaklyRate)
                    //   ],
                    // ),
                    ...additionalCharges.map((charge) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(charge.chargeName),
                          Text(charge.chargeValue),
                        ],
                      );
                    }).toList(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Net Total",style: subTxt.copyWith(fontWeight: FontWeight.bold),),
                        Text("\$${totalAdditionalCharges.toStringAsFixed(2)}",style: subTxt.copyWith(fontWeight: FontWeight
                        .bold),),
                      ],
                    ),
                  ],
                )),
            
          ],
        ),
      ),
    );
  }
}
