
class Office {
  int officeId;
  String baseName;
  String basePhoto;
  String address;
  String telephoneNumber;
  String manager;
  String driverInformation;
  String drivingRoute;
  String vehicleInformation;
  String drivingSchedule;
  String detailedInformation;
  String coordinate;
  String engravingRangeRadius;

  Office({
    required this.officeId,
    required this.baseName,
    required this.basePhoto,
    required this.address,
    required this.telephoneNumber,
    required this.manager,
    required this.driverInformation,
    required this.drivingRoute,
    required this.vehicleInformation,
    required this.drivingSchedule,
    required this.detailedInformation,
    required this.coordinate,
    required this.engravingRangeRadius,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    officeId: json["officeId"],
    baseName: json["baseName"],
    basePhoto: json["basePhoto"],
    address: json["address"],
    telephoneNumber: json["telephoneNumber"],
    manager: json["manager"],
    driverInformation: json["driverInformation"],
    drivingRoute: json["drivingRoute"],
    vehicleInformation: json["vehicleInformation"],
    drivingSchedule: json["drivingSchedule"],
    detailedInformation: json["detailedInformation"],
    coordinate: json["coordinate"],
    engravingRangeRadius: json["engravingRangeRadius"],
  );

  Map<String, dynamic> toJson() => {
    "officeId": officeId,
    "baseName": baseName,
    "basePhoto": basePhoto,
    "address": address,
    "telephoneNumber": telephoneNumber,
    "manager": manager,
    "driverInformation": driverInformation,
    "drivingRoute": drivingRoute,
    "vehicleInformation": vehicleInformation,
    "drivingSchedule": drivingSchedule,
    "detailedInformation": detailedInformation,
    "coordinate": coordinate,
    "engravingRangeRadius": engravingRangeRadius,
  };
}