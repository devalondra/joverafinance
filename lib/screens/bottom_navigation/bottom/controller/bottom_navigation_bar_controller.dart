import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as mp;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/auth/login/controller/login_controller.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/login/view/login_view.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/screens/auth/signup/view/signup_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/view/calculator_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/view/dashboard_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/view/home_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/view/services_view.dart';
import 'package:jovera_finance/screens/main_drawer/model/contact_model.dart';
import 'package:jovera_finance/screens/main_drawer/provider/main_drawer_provider.dart';
import 'package:jovera_finance/utilities/api/api_service.dart';

import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/utilities/services/translation_service.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomNavigationBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt selectedHomeSubPage = 0.obs;
  RxBool isLogin = true.obs;

  AuthManager authManager = Get.find();

  RxList<Widget> widgetOptions = <Widget>[].obs;
  @override
  onInit() async {
    super.onInit();
    widgetOptions.value = <Widget>[
      const HomeView(),
      loggedIn()
          ? const ServicesView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      const CalculatorView(),
      loggedIn()
          ? const DashboardView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      loggedIn()
          ? const DashboardView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
    ];

    language.value = selectedLanguage.value == 'en_US';
    await checkNotificationStatus();
    populateUserData();
  }

  bool loggedIn() {
    if (authManager.isLogged.value) {
      return true;
    } else {
      Get.lazyPut<LoginController>(() => LoginController());
      Get.lazyPut<SignUpController>(() => SignUpController());
      return false;
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void changelogin() {
    widgetOptions.value = <Widget>[
      const HomeView(),
      loggedIn()
          ? const ServicesView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      const CalculatorView(),
      loggedIn()
          ? const DashboardView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      loggedIn()
          ? const DashboardView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
    ];
    widgetOptions.refresh();
  }

  RxInt selectedContactIndex = 0.obs;

  RxString profilePicturePath = ''.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> currentPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> deleteReasonController =
      TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<TextEditingController> profileWhatsappController =
      TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  RxBool currentPasswordIsVisible = false.obs;
  RxBool passwordIsVisible = false.obs;
  RxBool confirmPasswordIsVisible = false.obs;
  RxString whatsappCountryCode = ''.obs;
  RxString countryCode = ''.obs;
  AppLoadingController appLoadingController = AppLoadingController();
  var selectedDate = DateTime.now().obs;
  RxBool language = true.obs;
  RxBool notification = true.obs;
  RxBool retypePasswordIsVisible = false.obs;
  RxString selectedLanguage = TranslationService().getLocale().toString().obs;
  AppUser? appUser;

  void changeLanguage(String languageCode) {
    TranslationService().changeLocale(languageCode);
    selectedLanguage.value = languageCode;
  }

  Future<void> checkNotificationStatus() async {
    final NotificationService notificationService = Get.find();
    notification.value = await notificationService.areNotificationsEnabled();
  }

  final List<ContactModel> contactList = [
    ContactModel(icon: "assets/icons/contact_icon.svg", title: "Help"),
    ContactModel(icon: "assets/icons/address_icon.svg", title: "Address"),
    ContactModel(icon: "assets/icons/call_icon.svg", title: "Call Back"),
  ];
  Future<void> changePassword() async {
    appLoadingController.loading();
    MainDrawerProvider().changePassword(
      newPassword: passwordController.value.text,
      currentPassword: currentPasswordController.value.text,

      onSuccess: (response) {
        appLoadingController.stop();
        print(response);
        appTools.showSuccessSnackBar("Password Reset Successful.");
        passwordController.value.clear();
        confirmPasswordController.value.clear();
        currentPasswordController.value.clear();
        Get.back();
      },
      onError: (error) {
        appLoadingController.stop();
        print(error.message);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during request, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    appLoadingController.loading();
    MainDrawerProvider().deleteAccount(
      reason: deleteReasonController.value.text,

      onSuccess: (response) {
        appLoadingController.stop();
        appTools.showSuccessSnackBar(
          "Request for Deleting the account is submitted successfully. After short review, you will be notified.",
        );

        deleteReasonController.value.clear();
      },
      onError: (error) {
        appLoadingController.stop();

        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during request, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> openNotificationSettings(bool value) async {
    final notificationService = Get.find<NotificationService>();

    if (Platform.isAndroid) {
      const platform = MethodChannel('app.settings.channel');
      try {
        await platform.invokeMethod('openNotificationSettings');
        if (value) {
          await notificationService.initFirebaseNotification();
          final enabledNow =
              await notificationService.areNotificationsEnabled();
          notification.value = enabledNow;
        }

        final enabledNow = await notificationService.areNotificationsEnabled();
        notification.value = enabledNow;
      } on PlatformException catch (e) {
        appTools.showErrorSnackBar("Something went wrong $e");
      }
    } else if (Platform.isIOS) {
      await openAppSettings();
    }
  }

  Future<void> toggleNotificationPermission(bool value) async {
    await openNotificationSettings(value);
  }

  populateUserData() {
    appUser = authManager.appUser.value;
    nameController.value.text = appUser?.name ?? "";

    emailController.value.text = appUser?.email ?? "";
    phoneNumberController.value.text = appUser?.phone ?? "";
    profilePicturePath.value = appUser?.picture ?? "";
    profileWhatsappController.value.text = appUser?.whatsapp ?? "";
    whatsappCountryCode.value = '';
    countryCode.value = '';
  }

  Future<void> editProfile() async {
    Map<String, dynamic> resultMap = await getProfileFormData();
    appLoadingController.loading();
    MainDrawerProvider().editProfile(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        appLoadingController.stop();
        final ApiService apiService = Get.find();
        await apiService.getUserDataByToken(authManager.getToken()!);
        populateUserData();
        appTools.showSuccessSnackBar("Profile updated.");
        Get.back();
      },
      onError: (error) {
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during request, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<Map<String, dynamic>> getProfileFormData() async {
    Map<String, dynamic> profileFormData = {};

    if (nameController.value.text != appUser?.name)
      profileFormData["name"] = nameController.value.text;

    if (profileWhatsappController.value.text.isNotEmpty &&
        ("${whatsappCountryCode.value}${profileWhatsappController.value.text}" !=
            appUser?.whatsapp)) {
      profileFormData["w_phone"] =
          "${profileWhatsappController.value.text.startsWith("+") ? "" : "+"}${whatsappCountryCode.value}${profileWhatsappController.value.text}";
    }
    print(profileFormData);
    if (profilePicturePath.isNotEmpty) {
      if (!profilePicturePath.startsWith("https")) {
        String ext = profilePicturePath.value.split('.').last.toLowerCase();
        profileFormData["picture"] = await mp.MultipartFile.fromFile(
          profilePicturePath.value,
          contentType: MediaType(
            ext == 'pdf' ? 'application' : 'image',
            ext == 'jpg' ? 'jpeg' : ext,
          ),
          filename:
              "profile_picture_${profilePicturePath.value.split('/').last}",
        );
      }
    }
    return profileFormData;
  }

  selectProfilePicture(context) {
    FilePickerResult? doc;
    DocumentPicker().documentPickerWidget(
      context,

      () async {
        Get.back();
        doc = await FilePicker.platform.pickFiles(type: FileType.image);

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          profilePicturePath.value = file.path;
        } else {}
      },

      () async {
        Get.back();
      },

      () async {
        Get.back();

        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        if (image != null) {
          File file = File(image.path);
          profilePicturePath.value = file.path;
        } else {}
      },
    );
  }

  Future<bool> showNotificationsDialog(value) async {
    return await Get.dialog<bool>(
          AlertDialog(
            backgroundColor: AppColors.black2,
            title: MainText(
              text: "Update Notification Permissions",

              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: fullHeight * 0.015),
                MainText(
                  text:
                      "You can navigate to Settings to change notification preferences and App may restart to apply settings.",
                  fontSize: 14,
                ),
                SizedBox(height: fullHeight * 0.015),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: MainText(text: "Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  toggleNotificationPermission(value);
                },
                child: MainText(
                  text: "Go To Settings",
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
