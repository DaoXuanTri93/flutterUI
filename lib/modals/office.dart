class Office {
  String BaseName;
  String Address;
  String LocationPhoneNumber;
  String SiteAdministrator;
  String DriverInformation;
  String DrivingRouteInformation;
  String VehicleInformation;
  String DrivingSchedule;

  Office(
      this.BaseName,
      this.Address,
      this.LocationPhoneNumber,
      this.SiteAdministrator,
      this.DriverInformation,
      this.DrivingRouteInformation,
      this.VehicleInformation,
      this.DrivingSchedule);
  final List<Office> offices = [
    Office(
        'BaseName 1',
        'Address 1',
        'LocationPhoneNumber 1',
        'SiteAdministrator 1',
        'DriverInformation 1',
        'DrivingRouteInformation 1',
        'VehicleInformation 1',
        'DrivingSchedule 1'),
    Office(
        'BaseName 2',
        'Address 2',
        'LocationPhoneNumber 2',
        'SiteAdministrator 2',
        'DriverInformation 2',
        'DrivingRouteInformation 2',
        'VehicleInformation 2',
        'DrivingSchedule 2'),
    Office(
        'BaseName 3',
        'Address 3',
        'LocationPhoneNumber 3',
        'SiteAdministrator 3',
        'DriverInformation 3',
        'DrivingRouteInformation 3',
        'VehicleInformation 3',
        'DrivingSchedule 3'),
  ];
}