import 'additional_charge.dart';

class UserFormData {
  final String? reservationId;
  final String? pickUpDate;
  final String? returnDate;
  final String? duration;
  final String? discount;
  final String? firstName;
  final String? lastName;
  final String? userEmail;
  final String? userPhone;
  final String? selectVehicleType;
  final String? selectModel;
  final String? hourRate;
  final String? dayRate;
  final String? weekRate;
  final List<AdditionalCharge>? additionalCharge;

  UserFormData({
    this.reservationId,
    this.pickUpDate,
    this.returnDate,
    this.duration,
    this.discount,
    this.firstName,
    this.lastName,
    this.userEmail,
    this.userPhone,
    this.selectVehicleType,
    this.selectModel,
    this.hourRate,
    this.dayRate,
    this.weekRate,
    this.additionalCharge,
  });

  factory UserFormData.fromJson(Map<String, dynamic> json) {
    var additionalChargeFromJson = json['additionalCharge'] as List?;
    List<AdditionalCharge> additionalChargeList = additionalChargeFromJson != null
        ? additionalChargeFromJson.map((i) => AdditionalCharge.fromJson(i)).toList()
        : [];

    return UserFormData(
      reservationId: json['reservationId'],
      pickUpDate: json['pickUpDate'],
      returnDate: json['returnDate'],
      duration: json['duration'],
      discount: json['discount'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userEmail: json['userEmail'],
      userPhone: json['userPhone'],
      selectVehicleType: json['selectVehicleType'],
      selectModel: json['selectModel'],
      hourRate: json['hourRate'],
      dayRate: json['dayRate'],
      weekRate: json['weekRate'],
      additionalCharge: additionalChargeList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'pickUpDate': pickUpDate,
      'returnDate': returnDate,
      'duration': duration,
      'discount': discount,
      'firstName': firstName,
      'lastName': lastName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'selectVehicleType': selectVehicleType,
      'selectModel': selectModel,
      'hourRate': hourRate,
      'dayRate': dayRate,
      'weekRate': weekRate,
      'additionalCharge': additionalCharge?.map((e) => e.toJson()).toList(),
    };
  }
}


