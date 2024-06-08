import 'dart:convert';
import 'package:nyntax/model/car_response.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class ApiCall {
  final String baseUrl = "https://exam-server-7c41747804bf.herokuapp.com/carsList";

  Future<CarResponse> callCar() async{
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      log('car data: $jsonResponse');
      return CarResponse.fromJson(jsonResponse);
    }else{
      throw Exception("Failed to load car data");
    }
  }
}