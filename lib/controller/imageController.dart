import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../auth/authentical.dart';
import '../services/uploadImage.dart';

class ImageController extends GetxController {
  ImageConnect imageConnect = ImageConnect();
  late final token;

  void createEnterDistance(String startingPoint, String firstKilometerPhoto) async {
    Map<String, dynamic> data = {
      "startingPoint": startingPoint,
      "firstKilometerPhoto": firstKilometerPhoto,
    };
    print(data);
    print(token);
    await imageConnect.createEnterDistance(data, token!);
    Get.snackbar('CREATE', 'CREATE SUCCESS.');
  }

  Future updateEnterDistance(String endPoint, String lastKilometerPhoto) async {
    Map<String, dynamic> data = {
      "endPoint": endPoint,
      "lastKilometerPhoto": lastKilometerPhoto
    };
    Response findOneDriver = await imageConnect.updateEnterDistance(data, token!);
    print(findOneDriver.statusCode);
    if(findOneDriver.statusCode != 201){
      Get.snackbar('ERROR', findOneDriver.body["message"]);
      return;
    }
    Get.snackbar('UPDATE', 'UPDATE SUCCESS.');
  }

  @override
  void onInit() {
    AuthenticationManager abstract = AuthenticationManager();
    token = abstract.getToken();
    super.onInit();
  }
}
