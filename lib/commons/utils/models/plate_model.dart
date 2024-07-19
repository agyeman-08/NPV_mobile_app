class PlateModel {
  final String address;
  final String classOfLincense;
  final String contact;
  final String dateOfBirth;
  final String dateOfIssue;
  final String expiryDate;
  final String lincenseNo;
  final String model;
  final String name;
  final String nationality;

  PlateModel({
    required this.address,
    required this.classOfLincense,
    required this.contact,
    required this.dateOfBirth,
    required this.dateOfIssue,
    required this.expiryDate,
    required this.lincenseNo,
    required this.model,
    required this.name,
    required this.nationality,
  });

  factory PlateModel.fromMap(Map<String, dynamic> map) {
    return PlateModel(
      address: map['Address'] as String,
      classOfLincense: map['Class of Lincense'] as String,
      contact: map['Contact'] as String,
      dateOfBirth: map['Date of Birth'] as String,
      dateOfIssue: map['Date of Issue'] as String,
      expiryDate: map['Expiry Date'] as String,
      lincenseNo: map['Lincense No'] as String,
      model: map['Model'] as String,
      name: map['Name'] as String,
      nationality: map['Nationality'] as String,
    );
  }
}
