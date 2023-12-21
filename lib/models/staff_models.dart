class Staff {
  String? affiliatedOffice ;
  String? userName;
  String? date;
  String? area;
  String? clockInTime;
  String? clockOutTime;
  String? overtimeClockInTime;
  String? overtimeClockOutTime;
  String? businessTrip;
  String? distance;
  String? meterLink;

  Staff.search(
      this.affiliatedOffice,
      this.userName,
      this.date,
      this.area,
      this.businessTrip
      );

  Staff(
      this.affiliatedOffice,
      this.userName,
      this.date,
      this.area,
      this.clockInTime,
      this.clockOutTime,
      this.overtimeClockInTime,
      this.overtimeClockOutTime,
      this.businessTrip,
      this.distance,
      this.meterLink
      );

  Staff.fromJson(Map<String, dynamic> json) {
    affiliatedOffice = json['affiliatedOffice'];
    userName = json['userName'];
    // date = json['date'];
    // area = json['area'];
    // clockInTime = json['clockInTime'];
    // clockOutTime = json['clockOutTime'];
    // overtimeClockInTime = json['overtimeClockInTime'];
    // overtimeClockOutTime = json['overtimeClockOutTime'];
    // businessTrip = json['businessTrip'];
    // distance = json['distance'];
    // meterLink = json['meterLink'];
  }

}






