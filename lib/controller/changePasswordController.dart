




import 'package:get/get.dart';
import 'package:login_app/services/changePasswordService.dart';
import 'package:login_app/global-variable/globals.dart' as globals;


class ChangePasswordController extends GetxController{
ChangePasswordService changePasswordService = ChangePasswordService();
    var datauser = [].obs;

    @override
    void onInit() {
      super.onInit();

    }

    fetchDatauser(Map<String, dynamic> data)  async {
        // Map<String, dynamic> data = {
        //     "username" : "tri",
        //     "passwordOld" : "123456",
        //     "passwordNew" : "456",
        //     "passwordNewConfirm" : "456"
        // };
       Response response = await ChangePasswordService().changePassword(data, globals.token);
        if(response.statusCode == 201){

        }
    }
}