import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/const/const.dart';

import '../controller/imageController.dart';
import 'package:http/http.dart' as http;

class UploadImageNew extends StatelessWidget {
  UploadImageNew({super.key});

  ImageController imageController = Get.put(ImageController());

  final Rx<File> _firstKilometerPhoto = File('').obs;

  final Rx<File> _lastKilometerPhoto = File('').obs;

  String? __firstKilometerPhotoURL;

  String? _lastKilometerPhotoURL;


  final _startingPoint = TextEditingController().obs;

  final _endPoint = TextEditingController().obs;

  // upload clound
  Future<void> _uploadImageStartingPoint() async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/dqnnru99w/image/upload');
    if (_firstKilometerPhoto.value!.path == '') {
      var saveImage = imageController.createEnterDistance(_startingPoint.value.text, '');
      _startingPoint.value.text = '';
      _firstKilometerPhoto.value = File('');
      return saveImage;
    }

    var request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'huklfdqx'
      ..files.add(await http.MultipartFile.fromPath(
          'file', _firstKilometerPhoto.value!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);

      final url = jsonMap['url'];
      __firstKilometerPhotoURL = url;
      if (__firstKilometerPhotoURL == '') {
        __firstKilometerPhotoURL = null;
      }
      imageController.createEnterDistance(_startingPoint.value.text, __firstKilometerPhotoURL!);
      _startingPoint.value.text = '';
      _firstKilometerPhoto.value = File('');

    }
  }

  Future<void> _uploadImageEndPoint() async {
    final url =
    Uri.parse('https://api.cloudinary.com/v1_1/dqnnru99w/image/upload');

    if(_endPoint.value.text.trim() == ''){
      Get.snackbar('kilomet không được bỏ trống', 'Vui lòng nhập lại !!!');
      return;
    }

    if (_lastKilometerPhoto.value!.path == '') {
      var saveImage1 = imageController.updateEnterDistance(_endPoint.value.text, '');
      _endPoint.value.text = '';
      _lastKilometerPhoto.value = File('');
      return saveImage1;
    }
    var request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'huklfdqx'
      ..files.add(await http.MultipartFile.fromPath(
          'file', _lastKilometerPhoto.value!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);

      final url = jsonMap['url'];
      _lastKilometerPhotoURL = url;
      if (_lastKilometerPhotoURL == '') {
        _lastKilometerPhotoURL = null;
      }
      imageController.updateEnterDistance(_endPoint.value.text, _lastKilometerPhotoURL!);
      _endPoint.value.text = '';
      _lastKilometerPhoto.value = File('');

    }
  }

  Future<void> _pickImageFromCameraStartingPoint() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;

    _firstKilometerPhoto.value = File(returnedImage!.path);
    var result = await FlutterImageCompress.compressAndGetFile(
      _firstKilometerPhoto.value!.absolute.path,
      _firstKilometerPhoto.value!.path + 'compressed.jpg',
      quality: 50,
    );
    _firstKilometerPhoto.value = File(result!.path);
  }

  Future<void> _pickImageFromCameraEndPoint() async {
    final returnedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    _lastKilometerPhoto.value = File(returnedImage!.path);
    var result = await FlutterImageCompress.compressAndGetFile(
      _lastKilometerPhoto.value!.absolute.path,
      _lastKilometerPhoto.value!.path + 'compressed1.jpg',
      quality: 50,
    );
    _lastKilometerPhoto.value = File(result!.path);
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final _formKey1 = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("距離入力画面",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("スタート距離:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (value){
                                if(value!.trim().isEmpty){
                                  return notEmpty.toString() ;
                                }
                              },
                              controller: _startingPoint.value,
                              keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0))),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: ElevatedButton(onPressed: (){
                                      _pickImageFromCameraStartingPoint();
                                    }, child: Text('choose file', style: TextStyle(color: Colors.black54)),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(LinearBorder.none),
                                        backgroundColor: MaterialStateProperty.all(Colors.grey),

                                      ),),
                                  ),
                                  SizedBox(width: 10,),
                                  Obx(
                                        () => _firstKilometerPhoto.value.path != ''
                                        ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Image.file(_firstKilometerPhoto.value!,
                                              height: 100, width: 100),
                                          IconButton(
                                              onPressed: () {
                                                _firstKilometerPhoto.value = File('');
                                              },
                                              icon: Icon(Icons.cancel))
                                        ],
                                      ),
                                    )
                                        : Text('No file chosen'),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(onPressed: (){
                              if(_formKey.currentState!.validate()){
                                EasyLoading.show();
                                _uploadImageStartingPoint();
                              }},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                ),
                                child: Text("スタートメーター写真をアップロード", style: TextStyle(color: Colors.white),)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),


                      Text("終了距離:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value){
                                  if(value!.trim().isEmpty){
                                    return notEmpty.toString() ;
                                  }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: _endPoint.value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0))),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3 ),
                                child: Row(
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      _pickImageFromCameraEndPoint();
                                    },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(LinearBorder.none),
                                          backgroundColor: MaterialStateProperty.all(Colors.grey),

                                        ),
                                        child: Text('choose file', style: TextStyle(color: Colors.black54))),
                                    SizedBox(width: 10,),
                                    Obx(() => _lastKilometerPhoto.value.path != ''
                                        ? Row(
                                      children: [
                                        Image.file(
                                          _lastKilometerPhoto.value!,
                                          height: 100,
                                          width: 100,
                                        ),
                                        // IconButton(onPressed: (){}, icon: Icon(Icons.cancel))
                                        IconButton(onPressed: (){
                                          _lastKilometerPhoto.value = File('');
                                        }, icon: Icon(Icons.cancel))
                                      ],
                                    )
                                        : Text('No file chosen')),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(onPressed: (){
                              if(_formKey1.currentState!.validate()){
                                EasyLoading.show();
                                _uploadImageEndPoint();
                              }
                            },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                ),
                                child: Text("終了メーター写真をアップロード", style: TextStyle(color: Colors.white),))
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
