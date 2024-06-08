import 'car.dart';

class CarResponse {
  final String status;
  final List<Car> data;
  final String message;

  CarResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory CarResponse.fromJson(Map<String, dynamic> json) {
    return CarResponse(
      status: json['status'],
      data: List<Car>.from(json['data'].map((car) => Car.fromJson(car))),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((car) => car.toJson()).toList(),
      'message': message,
    };
  }
}


