import 'package:flutter/material.dart';
import 'package:nyntax/screens/vehicle_information_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_constant.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';

class CustomerInformationScreen extends StatefulWidget {
  const CustomerInformationScreen({super.key});

  @override
  State<CustomerInformationScreen> createState() =>
      _CustomerInformationScreenState();
}

class _CustomerInformationScreenState extends State<CustomerInformationScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('userEmail', emailController.text);
    await prefs.setString('userPhone', phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: customerForm(),
    );
  }
  Widget customerForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information', style: titleTxt),
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
                      TextSpan(text: "First Name", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      controller: firstNameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please type your first name";
                        }
                        return null;
                      },
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Last Name", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      controller: lastNameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please type your last name";
                        }
                        return null;
                      },
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Email", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      controller: emailController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please type your email";
                        }
                        return null;
                      },
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "Phone", style: subTxt),
                      TextSpan(
                          text: "*", style: subTxt.copyWith(color: Colors.red))
                    ])),
                    AppInputField(
                      controller: phoneController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please type your phone no";
                        }
                        return null;
                      },
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
            onPress: () async{
              if(formKey.currentState!.validate()){
                await saveData();
                if(mounted){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const VehicleInformationScreen();
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
