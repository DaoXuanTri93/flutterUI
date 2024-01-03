
import 'dart:convert';

List<TeamApprovalModel> teamApprovalModelFromJson(String str) => List<TeamApprovalModel>.from(json.decode(str).map((x) => TeamApprovalModel.fromJson(x)));

String teamApprovalModelToJson(List<TeamApprovalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamApprovalModel {
  String? stampApprovalId;
  String? staff;
  bool? approval;
  String? officeName;
  String? driverName;
  String? submissionDate;
  String? approvalDate;
  String? stampingBeforeCorrection;
  String? stampingAfterCorrection;
  String? status;
  String? reason;

  TeamApprovalModel({
     this.stampApprovalId,
     this.staff,
     this.approval,
     this.officeName,
     this.driverName,
     this.submissionDate,
     this.approvalDate,
     this.stampingBeforeCorrection,
     this.stampingAfterCorrection,
     this.reason,
    this.status
  });


  TeamApprovalModel.stampingDetail(
      this.stampApprovalId,
      this.approval,
      this.submissionDate,
      this.approvalDate,
      this.stampingBeforeCorrection,
      this.stampingAfterCorrection,
      this.status,
      this.reason);

  factory TeamApprovalModel.fromJson(Map<String, dynamic> json) => TeamApprovalModel(
    stampApprovalId: json["stampApprovalId"].toString(),
    staff: json["staff"].toString(),
    approval: json["approval"],
    officeName: json["officeName"],
    driverName: json["driverName"],
    submissionDate: json["submissionDate"],
    approvalDate: json["approvalDate"],
    stampingBeforeCorrection: json["stampingBeforeCorrection"],
    stampingAfterCorrection: json["stampingAfterCorrection"],
    reason: json["reason"],
    status: json["status"]
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
    "status" : status
  };

  static List<TeamApprovalModel> fromData(List<dynamic> data) {
    return data.map((e) => TeamApprovalModel.fromJson(e)).toList();
  }
}




