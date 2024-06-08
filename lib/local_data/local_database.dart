import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static const String reservationId = 'reservationId';
  static const String pickUpDate = 'pickUpDate';
  static const String returnDate = 'returnDate';
  static const String duration = 'duration';
  static const String discount = 'discount';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String userEmail = 'userEmail';
  static const String userPhone = 'userPhone';
  static const String selectVehicleType = 'selectVehicleType';
  static const String selectModel = 'selectModel';
  static const String hourRate = 'hourRate';
  static const String dayRate = 'dayRate';
  static const String weekRate = 'weekRate';
  static const String selectedCharges = 'selectedCharges';

  static Future<String?> getReservationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(reservationId);
  }

  static Future<String?> getPickUpDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(pickUpDate);
  }

  static Future<String?> getReturnDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(returnDate);
  }

  static Future<String?> getDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(duration);
  }

  static Future<String?> getDiscount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(discount);
  }

  static Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(firstName);
  }

  static Future<String?> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastName);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail);
  }

  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhone);
  }

  static Future<String?> getSelectVehicleType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectVehicleType);
  }

  static Future<String?> getSelectModel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectModel);
  }

  static Future<String?> getHourRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(hourRate);
  }

  static Future<String?> getDayRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dayRate);
  }

  static Future<String?> getWeekRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(weekRate);
  }

  static Future<String?> getSelectedCharges() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectedCharges);
  }

}