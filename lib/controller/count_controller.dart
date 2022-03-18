import 'package:get/get.dart';

class CountController extends GetxController {
  var adult_count = 0.obs;
  var child_count = 0.obs;
  incrementAdult(){
    adult_count++;
  }
  decrementAdult(){
    adult_count--;
  }
  incrementChild(){
    child_count++;
  }
  decrementChild(){
    child_count--;
  }
}
