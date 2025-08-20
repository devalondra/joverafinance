import 'dart:convert';

import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/model/visa_application_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/provider/dashboard_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/view/tracking_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class DashboardController extends GetxController {
  Rx<VisaApplicationModel> selectedVisaApplicationModel =
      VisaApplicationModel().obs;
  RxList<VisaApplicationModel> myVisaApplications =
      <VisaApplicationModel>[].obs;

  AppLoadingController appLoadingController = AppLoadingController();
  RxBool isLoading = false.obs;
  @override
  onInit() async {
    await getMyApplications();
    super.onInit();
  }

  @override
  onReady() async {
    await getMyApplications();
    super.onReady();
  }

  Future<void> getMyApplications() async {
    isLoading.value = true;
    appLoadingController.loading();
    DashboardProvider().getMyVisaApplications(
      onSuccess: (response) {
        isLoading.value = false;
        appLoadingController.stop();
        print(response);
        if (response.data != null) {
          myVisaApplications.value = RxList<VisaApplicationModel>.from(
            json
                .decode(json.encode(response.data['leads']))
                .map((x) => VisaApplicationModel.fromJson(x)),
          );
        }
      },
      onError: (error) {
        isLoading.value = false;
        appLoadingController.stop();
        print(error.message);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> getLeadById(int index) async {
    isLoading.value = true;
    appLoadingController.loading();
    DashboardProvider().getLeadById(
      leadId: myVisaApplications[index].id ?? "",
      onSuccess: (response) {
        isLoading.value = false;
        appLoadingController.stop();
        print(response);
        if (response.data != null) {
          selectedVisaApplicationModel.value = VisaApplicationModel.fromJson(
            response.data['lead'],
          );
          Get.to(() => TrackingView());
        }
      },
      onError: (error) {
        isLoading.value = false;
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 1,
        );
      },
    );
  }
}
