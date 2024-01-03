import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login_app/controller/stampingApprovalController.dart';

import '../const/const.dart';

class StampingApprovalScreen extends StatefulWidget {
  const StampingApprovalScreen({super.key});

  @override
  State<StampingApprovalScreen> createState() => _StampingApprovalScreenState();
}

class _StampingApprovalScreenState extends State<StampingApprovalScreen> {
  final _controller =
      Get.put<StampingApprovalController>(StampingApprovalController());
  final TextEditingController _subDate = TextEditingController();
  final TextEditingController _approvalDate = TextEditingController();
  final _ischeck = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(stampingPage,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(submissionDate,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                TextFormField(
                  controller: _subDate,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      focusColor: Colors.red,
                      hintText: 'yyyy/MM/dd',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onTap: () async {
                    DateTime? datepicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025));
                    if (datepicker != null) {
                      setState(() {
                        _subDate.text =
                            DateFormat('yyyy/MM/dd').format(datepicker);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(approvalDate,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                TextFormField(
                  controller: _approvalDate,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      focusColor: Colors.red,
                      hintText: 'yyyy/MM/dd',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onTap: () async {
                    DateTime? datepicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025));
                    if (datepicker != null) {
                      setState(() {
                        _approvalDate.text =
                            DateFormat('yyyy/MM/dd').format(datepicker);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(approvalStatus,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    Obx(() => Checkbox(
                        value: _ischeck.value,
                        onChanged: (value) =>
                            {_ischeck.value = !_ischeck.value})),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> dataSearch = {
                        'submissionDate': _subDate.text,
                        'approvalDate': _approvalDate.text,
                        'approval': _ischeck.value
                      };
                      _controller.dataSearch(dataSearch);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text('検索')),
              ],
            ),
            Text('- - -',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.w100,
                )),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: _controller.stamingApproval.length,
                  itemBuilder: (context, index) {
                    final items = _controller.stamingApproval[index];
                    return GestureDetector(
                      onTap: () {
                        _controller.showDetailStampingApproval(
                            items.stampApprovalId.toString());
                      },
                      child: Card(
                        color: Colors.grey[350],
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'SubmissionDate: ',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${items.submissionDate}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black54))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'ApprovalDate: ',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          '${items.approvalDate == null || items.approvalDate == '' ? '-' : items.approvalDate}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black54))
                                    ],
                                  ),
                                ],
                              ),
                              items.status == 'PENDING'
                                  ? Text(
                                      '${items.status}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow[900]),
                                    )
                                  : items.status == 'REFUSE'
                                      ? Text(
                                          '${items.status}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        )
                                      : Text('${items.status}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
