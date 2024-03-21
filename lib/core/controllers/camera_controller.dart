import 'package:get/get.dart';

class DetectController extends GetxController{
  RxInt cameraVal=0.obs;

  toggleCamera() {
    cameraVal.value = cameraVal.value==0?1:0;

  }


}