class AdditionalCharge {
  String chargeName;
  String chargeValue; // Keep this for display purposes.
  double chargeAmount; // This will be used for calculation.

  AdditionalCharge({required this.chargeName, required this.chargeValue, required this.chargeAmount});

  Map<String, dynamic> toJson() {
    return {
      'chargeName': chargeName,
      'chargeValue': chargeValue,
      'chargeAmount': chargeAmount,
    };
  }

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) {
    return AdditionalCharge(
      chargeName: json['chargeName'],
      chargeValue: json['chargeValue'],
      chargeAmount: json['chargeAmount'],
    );
  }
}
