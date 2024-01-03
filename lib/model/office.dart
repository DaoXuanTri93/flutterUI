class Office {
  String? officeId;
  String? baseName;
  String? basePhoto;
  String? address;
  String? telephoneNumber;
  String? manager;
  String? driverInformation;
  String? drivingRoute;
  String? vehicleInformation;
  String? drivingSchedule;
  String? detailedInformation;
  String? coordinate;
  String? engravingRangeRadius;

  Office(
      this.officeId,
      this.baseName,
      this.basePhoto,
      this.address,
      this.telephoneNumber,
      this.manager,
      this.driverInformation,
      this.drivingRoute,
      this.vehicleInformation,
      this.drivingSchedule,
      this.detailedInformation,
      this.coordinate,
      this.engravingRangeRadius);

  Office.search(
      this.baseName,
      this.address,
      this.telephoneNumber,
      this.manager,
      this.driverInformation,
      this.drivingRoute,
      this.vehicleInformation,
      this.drivingSchedule);
  Office.changeData(
      this.baseName,
      this.address,
      this.telephoneNumber,
      this.manager,
      this.basePhoto,
      this.detailedInformation,
      this.coordinate,
      this.engravingRangeRadius);

  Office.fromJson(Map<String, dynamic> json) {
    officeId = (json['officeId']).toString();
    baseName = json['baseName'];
    basePhoto = json['basePhoto'];
    address = json['address'];
    telephoneNumber = json['telephoneNumber'];
    manager = json['manager'];
    driverInformation = json['driverInformation'];
    drivingRoute = json['drivingRoute'];
    vehicleInformation = json['vehicleInformation'];
    drivingSchedule = json['drivingSchedule'];
    detailedInformation = json['detailedInformation'];
    coordinate = json['coordinate'];
    engravingRangeRadius = json['engravingRangeRadius'];
  }
}
