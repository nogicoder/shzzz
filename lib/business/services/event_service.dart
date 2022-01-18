import 'package:get/get.dart';
import 'package:shzzz/shared/index.dart';

class EventService extends GetxService {
  var progressVisible = false.obs;
  var errorStream = ''.obs;

  showAppLoading() async {
    Future.delayed(Duration(milliseconds: 300), () {
      if (!progressVisible.value) {
        progressVisible.value = true;
      }
    });
  }

  hideAppLoading() async {
    Future.delayed(Duration(milliseconds: 300), () {
      if (progressVisible.value) {
        progressVisible.value = false;
      }
    });
  }

  showError(String error) async {
    if (errorStream.value.isEmpty) {
      errorStream.value = error;
      DialogUtil.alert(error);
    }
  }

  void hideError() {
    if (errorStream.value.isNotEmpty) errorStream.value = '';
  }

  void fireEvent(AppEvent event, {String? marketControllerTag}) async {
    try {} catch (error) {
      print(error.toString());
    }
  }
}

final EventService eventService = Get.find();
