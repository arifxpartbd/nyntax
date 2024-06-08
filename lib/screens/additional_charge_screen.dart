import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nyntax/screens/summary_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_constant.dart';
import '../widgets/app_button.dart';
import '../widgets/checkbox_item.dart';
import '../model/additional_charge.dart'; // Import your AdditionalCharge model

class AdditionalChargeScreen extends StatefulWidget {
  const AdditionalChargeScreen({super.key});

  @override
  State<AdditionalChargeScreen> createState() => _AdditionalChargeScreenState();
}

class _AdditionalChargeScreenState extends State<AdditionalChargeScreen> {
  List<bool> checkboxValues = [false, false, false];
  List<AdditionalCharge> additionalCharges = [
    AdditionalCharge(chargeName: 'Collision Damage Waiver', chargeValue: '\$9.00', chargeAmount: 9.00),
    AdditionalCharge(chargeName: 'Liability Insurance', chargeValue: '\$15.00', chargeAmount: 15.0),
    AdditionalCharge(chargeName: 'Rental Tax', chargeValue: '\$11.5', chargeAmount: 11.5),
  ];

  List<AdditionalCharge> selectedCharges = [];

  void saveSelectedCharges() {
    selectedCharges.clear();
    for (int i = 0; i < checkboxValues.length; i++) {
      if (checkboxValues[i]) {
        selectedCharges.add(additionalCharges[i]);
      }
    }
  }

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(selectedCharges.map((charge) => charge.toJson()).toList());
    await prefs.setString('selectedCharges', encodedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: additionalChargesForm(),
    );
  }

  Widget additionalChargesForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Charges', style: titleTxt),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(additionalCharges.length, (index) {
                  return CustomCheckboxListItem(
                    text: additionalCharges[index].chargeName,
                    price: additionalCharges[index].chargeValue,
                    value: checkboxValues[index],
                    onChanged: (bool? value) {
                      setState(() {
                        checkboxValues[index] = value!;
                      });
                    },
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          AppButton(
            onPress: () async{
              saveSelectedCharges();
              await saveData();
              if(mounted){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const SummaryScreen();
                }));
              }
            },
          ),
        ],
      ),
    );
  }
}
