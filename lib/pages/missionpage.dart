import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/controller/missionController.dart';
import 'package:login_app/services/missionServices.dart';

class MissionPage extends StatelessWidget {
  MissionPage({super.key});
  final MissionController controller = Get.put(MissionController());
  final MissionServices missionServices = MissionServices();
  @override
  Widget build(BuildContext context) {
    print("hello");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission detail'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              MissionServices().showFormRegisterMission(context, controller);
            },
          ),
        ],
      ),
      body: Obx(() {
        List _todo = controller.listMission.value;
        return _todo.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXFt7AgX2KbHPoO7-ZrgnF-lnjfu2m3iwmlw&usqp=CAU"),
                    const Text(
                      'No data',
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _todo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Thời gian\n${_todo[index]["startDay"]} - ${_todo[index]["endDay"]}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                Text('Ngày tạo: ${_todo[index]["startDay"]}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12))
                              ]),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 100,
                            child: Text(_todo[index]["statusMission"],
                                style: TextStyle(
                                    color:
                                        _todo[index]["statusMission"] == "PENDING"
                                            ? Colors.red
                                            : _todo[index]["statusMission"] ==
                                                    "APPROVED"
                                                ? Colors.green
                                                : Colors.grey,
                                    fontWeight: FontWeight.w900)),
                          ),
                          PopupMenuButton<int>(
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                  value: 1, child: Text("Chỉnh sửa")),
                              PopupMenuItem(
                                  value: 2,
                                  child: _todo[index]["statusMission"] ==
                                          "CANCELLING"
                                      ? const Text("Bỏ hủy")
                                      : const Text("Hủy")),
                            ],
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  missionServices.showFormRegisterMission(
                                      context, controller,
                                      start: _todo[index]["startDay"],
                                      end: _todo[index]["endDay"],
                                      id: _todo[index]["id"]);
                                  break;
                                case 2:
                                  missionServices.cancelMisson(
                                      context, _todo[index]["id"], controller);
                                  break;
                                default:
                              }
                            },
                          )
                        ]),
                  );
                },
              );
      }),
    );
  }
}
