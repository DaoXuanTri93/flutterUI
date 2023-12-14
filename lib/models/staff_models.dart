class StaffModel {
  String? userAccount ;
  String? userName;
  String? email;
  String? telephone;
  String? dateOfBirth;
  String? drivingLicenseNumber;
  String? area;
  String? businessTrip;
  String? macAddress;
  String? affiliatedOffice;

  StaffModel(
      this.userAccount,
      this.userName,
      this.email,
      this.telephone,
      this.dateOfBirth,
      this.drivingLicenseNumber,
      this.area,
      this.businessTrip,
      this.macAddress,
      this.affiliatedOffice);

  StaffModel.fromJson(Map<String, dynamic> json) {
    userAccount = json['userAccount'];
    userName = json['userName'];
    email = json['email'];
    telephone = json['telephone'];
    dateOfBirth = json['dateOfBirth'];
    drivingLicenseNumber = json['drivingLicenseNumber'];
    area = json['area'];
    businessTrip = json['businessTrip'];
    macAddress = json['macAddress'];
    userAccount = json['affiliatedOffice'];
  }
}





