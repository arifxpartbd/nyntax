
class Rates {
  final int hourly;
  final int daily;
  final int weekly;

  Rates({
    required this.hourly,
    required this.daily,
    required this.weekly,
  });

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      hourly: json['hourly'],
      daily: json['daily'],
      weekly: json['weekly'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hourly': hourly,
      'daily': daily,
      'weekly': weekly,
    };
  }
}
