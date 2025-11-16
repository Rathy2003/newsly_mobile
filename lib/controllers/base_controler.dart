
import 'package:get/state_manager.dart';

class BaseControler<T> extends GetxController {
  var isLoading = false.obs;
  var hasError =  false.obs;
  var errorMessage = "".obs;
  Rx<T?> data = Rx<T?>(null); 

  Future<void> APICalling(Future<T> Function() dataFetching) async{
    try {
      isLoading.value = true;
      hasError.value = false;
      T result = await dataFetching();
      data.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    }finally{
      Future.delayed(Duration(seconds: 3)).then((value) => isLoading.value = false);
    }
  }
}