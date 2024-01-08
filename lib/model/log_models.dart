class Log {
  String? logID ;
  String? affiliatedOffice;
  String? type;
  String? operatorName;
  String? date;
  String? kinds;
  String? operationTime;

  Log.search(
      this.logID,
      this.affiliatedOffice,
      this.type,
      this.operatorName,
      this.date,
      this.kinds,
      this.operationTime
      );

  Log(
      this.logID,
      this.affiliatedOffice,
      this.type,
      this.operatorName,
      this.date,
      this.kinds,
      this.operationTime
      );

  Log.fromJson(Map<String, dynamic> json) {
    logID = json['id'].toString();
    affiliatedOffice = json['officeName'];
    type = json['role'];
    operatorName = json['operatorName'];
    date = json['approvalDay'];
    kinds = json['status'];
    operationTime = json['hourApproval'];
  }

  Map<String, dynamic> toJson() => {
    "logID": logID,
    "affiliatedOffice": affiliatedOffice,
    "type": type,
    "operatorName": operatorName,
    "date": date,
    "kinds": kinds,
    "operationTime": operationTime,
  };

  // static List<Staff> fromData(List<dynamic> data) {
  //   return data.map((e) => Staff.fromJson(e)).toList();
  // }
}






