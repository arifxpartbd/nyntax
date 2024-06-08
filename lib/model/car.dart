import 'package:nyntax/model/rate.dart';

class Car {
  final String id;
  final String make;
  final String model;
  final int year;
  final String type;
  final int seats;
  final int bags;
  final List<String> features;
  final Rates rates;
  final String imageURL;

  Car({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.type,
    required this.seats,
    required this.bags,
    required this.features,
    required this.rates,
    required this.imageURL,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      type: json['type'],
      seats: json['seats'],
      bags: json['bags'],
      features: List<String>.from(json['features']),
      rates: Rates.fromJson(json['rates']),
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'type': type,
      'seats': seats,
      'bags': bags,
      'features': features,
      'rates': rates.toJson(),
      'imageURL': imageURL,
    };
  }
}
