import 'dart:convert';

List<MissionApprovalModel> missionApprovalFromJson(String str) =>
    List<MissionApprovalModel>.from(
        json.decode(str).map((x) => MissionApprovalModel.fromJson(x)));

String missionApprovalToJson(List<MissionApprovalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MissionApprovalModel {
  String? id;
  String? userName;
  String? endDay;
  String? startDay;
  String? statusMission;

  MissionApprovalModel({
     this.id,
     this.userName,
     this.endDay,
     this.startDay,
     this.statusMission,
  });

  factory MissionApprovalModel.fromJson(Map<String, dynamic> json) =>
      MissionApprovalModel(
        id: json["id"].toString(),
        userName: json["userName"],
        endDay: json["endDay"],
        startDay: json["startDay"],
        statusMission: json["statusMission"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "endDay": endDay,
        "startDay": startDay,
        "statusMission": statusMission,
      };

  static List<MissionApprovalModel> fromData(List<dynamic> data) {
    return data.map((e) => MissionApprovalModel.fromJson(e)).toList();
  }
}
