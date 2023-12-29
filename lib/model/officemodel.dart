class OfficeUser {
  String? officeId;
  String? baseName;


  OfficeUser.create();

  OfficeUser(
      this.officeId,
      this.baseName);


  OfficeUser.fromJson(Map<String, dynamic> json) {
    officeId = (json['officeId']).toString();
    baseName = json['baseName'];
  }
}
