import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/stampingApprovalController.dart';

class StampingApprovalDetail extends StatelessWidget {
  StampingApprovalDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final controller =
    Get.put<StampingApprovalController>(StampingApprovalController());
    final controllerOffice = controller.detailStampingApproval;
    final stampings = controllerOffice.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stamping Approval Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range_outlined,
                        color: Colors.grey[700], size: 50),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Submission Date: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              stampings['submissionDate'] == null
                                  ? '-'
                                  : stampings['submissionDate'].toString(),
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Approval Date: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                                stampings['approvalDate'] == null
                                    ? '-'
                                    : stampings['approvalDate'].toString(),
                                style: TextStyle(fontSize: 15))
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_filled_outlined,
                        color: Colors.grey[700], size: 50),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Stamping Before: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              stampings['stampingBeforeCorrection'] == null
                                  ? '-'
                                  : stampings['stampingBeforeCorrection']
                                  .toString(),
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Stamping After: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                                stampings['stampingAfterCorrection'] == null
                                    ? '-'
                                    : stampings['stampingAfterCorrection']
                                    .toString(),
                                style: TextStyle(fontSize: 15))
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.assignment_late_outlined,
                        color: Colors.grey[700], size: 50),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Status: ',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    stampings['status'].toString() == 'PENDING'
                        ? Text(
                      stampings['status'] == null
                          ? '-'
                          : stampings['status'].toString(),
                      style: TextStyle(
                          color: Colors.yellow[900], fontSize: 15),
                    )
                        : stampings['status'].toString() == 'REFUSE'
                        ? Text(
                      stampings['status'] == null
                          ? '-'
                          : stampings['status'].toString(),
                      style:
                      TextStyle(color: Colors.red, fontSize: 15),
                    )
                        : Text(
                        stampings['status'] == null
                            ? '-'
                            : stampings['status'].toString(),
                        style: TextStyle(
                            color: Colors.green, fontSize: 15)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.account_balance_wallet_outlined,
                        color: Colors.grey[700], size: 50),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Reason: ',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      stampings['reason'] == null
                          ? '-'
                          : stampings['reason'].toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
