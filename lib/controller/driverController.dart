import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:login_app/model/TeamApprovalModel.dart';
import '../global-variable/globals.dart';
import '../services/driverServices.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class DriverController extends GetxController {
  DriverService driverService = DriverService();
  var isLoading = false.obs;
  var driverList = [].obs;
  var diverListSearch = [].obs;
  var officeName = ''.obs;
  final driver = {'userName':"",'staffId':"","dateOfBirth":'',"area":'',"mission":"false","phone":''}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    // Future.delayed(const Duration(seconds: 2), () async {   });
  }

  void fetchData() async {
    try {
      final token = globals.token;
      isLoading(true);
      Response response = await driverService.findAll(token);
      if (response.statusCode == 200) {
        driverList.value = diverListSearch.value = response.body;
        print(response.body);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  void dataSearch(Map<String, dynamic> dataSearch) {
    print("davoday${dataSearch['not-stamped']}");
    driverList.value = diverListSearch
        .where((p0) =>
            (dataSearch['affiliatedOffice'] == ''
                ? true
                : p0['officeName'].contains(dataSearch['affiliatedOffice'])) &&
            (dataSearch['userName'] == ''
                ? true
                : p0['userName'].contains(dataSearch['userName'])) &&
            (dataSearch['date'] == ''
                ? true
                : p0["dayTimeKeeping"] == null
                    ? false
                    : p0["dayTimeKeeping"]
                        .contains(dataSearch["date"].substring(0,10))) &&
            (dataSearch['area'] == ''
                ? true
                : p0["area"] == null
                    ? false
                    : p0["area"].contains(dataSearch["area"])) &&
            ((dataSearch['not-stamped'] == false &&
                    (p0['timeStartDay'] == null && p0['timeEndDay'] == null))
                ? true
                : (dataSearch['not-stamped'] == true &&
                    (p0['timeStartDay'] != null ||
                        p0['timeEndDay'] != null))) &&
            dataSearch['businessTrip'] == p0['workOutside'])
        .toList();

    print(driverList);

  }

  void getDataById(String id) async{
    final token = globals.token;
    Response response = await driverService.getdataById(id,token);
    print(response.statusCode);
    if(response.statusCode == 200){
      driver.value = Map<String,String>.from(response.body);
    }
  }

  void updateDriver(Map<String, dynamic> data,String id) async {
    final token = globals.token;
    print("data" + data['userName']);
    Response response = await driverService.updateDriver(id,token,data);
    if(response.statusCode == 200){
      print(response.body);
    }
  }

  void exportToExcel(){
    final excel = Excel.createExcel();
    final Set<String> listName = <String>{};
    CellStyle cellStyle = CellStyle(
      bold: true,
      italic: true,
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Arial),
      rotation: 0,
    );
    for (var row = 0; row < driverList.length; row++) {
      listName.add(driverList[row]['userName']);
    }
    for (var element in listName) {
      final Sheet sheet = excel[element];
      final cell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
      cell.value =  const TextCellValue("officeName");
      cell.cellStyle = cellStyle;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .value =  const TextCellValue('userName');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .value =  const TextCellValue('dayTimeKeeping');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value =  const TextCellValue('area');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .value =  const TextCellValue('timeStartDay');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .value =  const TextCellValue('timeEndDay');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .value =  const TextCellValue('overTimeStart');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0))
          .value =  const TextCellValue('overTimeEnd');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0))
          .value =  const TextCellValue('workOutside');
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0))
          .value =  const TextCellValue('totalDistance');
      for (var row = 0; row < driverList.length; row++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['officeName']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['userName']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['dayTimeKeeping']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['area']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['timeStartDay']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['timeEndDay']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['overTimeStart']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['overTimeEnd']??"");
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['workOutside'].toString());
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row+1))
            .value =  TextCellValue(driverList[row]['totalDistance'].toString()??"");
      }
      sheet.getColumnAutoFits;
    }

    excel.save(fileName: "MyData.xlsx");
  }
}
