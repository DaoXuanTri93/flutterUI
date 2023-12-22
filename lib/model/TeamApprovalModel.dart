
import 'dart:convert';

List<TeamApprovalModel> teamApprovalModelFromJson(String str) => List<TeamApprovalModel>.from(json.decode(str).map((x) => TeamApprovalModel.fromJson(x)));

String teamApprovalModelToJson(List<TeamApprovalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamApprovalModel {
  int? stampApprovalId;
  int? staff;
  bool approval;
  String? officeName;
  String? driverName;
  String? submissionDate;
  String? approvalDate;
  String? stampingBeforeCorrection;
  String? stampingAfterCorrection;
  String? reason;

  TeamApprovalModel({
    required this.stampApprovalId,
    required this.staff,
    required this.approval,
    required this.officeName,
    required this.driverName,
    required this.submissionDate,
    required this.approvalDate,
    required this.stampingBeforeCorrection,
    required this.stampingAfterCorrection,
    required this.reason,
  });

  factory TeamApprovalModel.fromJson(Map<String, dynamic> json) => TeamApprovalModel(
    stampApprovalId: json["stampApprovalId"],
    staff: json["staff"],
    approval: json["approval"],
    officeName: json["officeName"],
    driverName: json["driverName"],
    submissionDate: json["submissionDate"],
    approvalDate: json["approvalDate"],
    stampingBeforeCorrection: json["stampingBeforeCorrection"],
    stampingAfterCorrection: json["stampingAfterCorrection"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "stampApprovalId": stampApprovalId,
    "staff": staff,
    "approval": approval,
    "officeName": officeName,
    "driverName": driverName,
    "submissionDate": submissionDate,
    "approvalDate": approvalDate,
    "stampingBeforeCorrection": stampingBeforeCorrection,
    "stampingAfterCorrection": stampingAfterCorrection,
    "reason": reason,
  };

  static List<TeamApprovalModel> fromData(List<dynamic> data) {
    return data.map((e) => TeamApprovalModel.fromJson(e)).toList();
  }
}




