import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/model/visa_application_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/provider/dashboard_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/view/tracking_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class DashboardState {
   DashboardState({
    required this.appLoadingController,
   required this.selectedVisaApplicationModel,
    this.myVisaApplications = const <VisaApplicationModel>[],
    this.isLoading = false,
  });

  final VisaApplicationModel selectedVisaApplicationModel;
  final List<VisaApplicationModel> myVisaApplications;
  final AppLoadingController appLoadingController;
  final bool isLoading;

  DashboardState copyWith({
    VisaApplicationModel? selectedVisaApplicationModel,
    List<VisaApplicationModel>? myVisaApplications,
    bool? isLoading,
  }) {
    return DashboardState(
      appLoadingController: appLoadingController,
      selectedVisaApplicationModel:
          selectedVisaApplicationModel ?? this.selectedVisaApplicationModel,
      myVisaApplications: myVisaApplications ?? this.myVisaApplications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController(this.ref)
    : super(
        DashboardState(
          appLoadingController: AppLoadingController(),
          selectedVisaApplicationModel: VisaApplicationModel(),
        ),
      ) {
    getMyApplications();
  }

  final Ref ref;

  VisaApplicationModel get selectedVisaApplicationModel =>
      state.selectedVisaApplicationModel;
  List<VisaApplicationModel> get myVisaApplications => state.myVisaApplications;
  AppLoadingController get appLoadingController => state.appLoadingController;
  bool get isLoading => state.isLoading;

  set selectedVisaApplicationModel(VisaApplicationModel value) {
    state = state.copyWith(selectedVisaApplicationModel: value);
  }

  set myVisaApplications(List<VisaApplicationModel> value) {
    state = state.copyWith(myVisaApplications: value);
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> getMyApplications() async {
    if (!ref.read(authManagerProvider).isLogged) {
      return;
    }

    isLoading = true;
    appLoadingController.loading();
    DashboardProvider().getMyVisaApplications(
      onSuccess: (response) {
        isLoading = false;
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null) {
          myVisaApplications =
              json.decode(json.encode(response.data['leads']))
                  .map<VisaApplicationModel>(
                    (x) => VisaApplicationModel.fromJson(x),
                  )
                  .toList();
          if (kDebugMode) print(myVisaApplications);
          //myVisaApplications.clear();
        }
      },
      onError: (error) {
        isLoading = false;
        appLoadingController.stop();
        if (kDebugMode) print(error.message);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> getLeadById(int index) async {
    isLoading = true;
    appLoadingController.loading();
    DashboardProvider().getLeadById(
      leadId: myVisaApplications[index].id ?? "",
      onSuccess: (response) {
        isLoading = false;
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null) {
          selectedVisaApplicationModel = VisaApplicationModel.fromJson(
            response.data['lead'],
          );
          AppNavigator.push(TrackingView());
        }
      },
      onError: (error) {
        isLoading = false;
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 1,
        );
      },
    );
  }

  @override
  void dispose() {
    appLoadingController.dispose();
    super.dispose();
  }
}

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  return DashboardController(ref);
});
