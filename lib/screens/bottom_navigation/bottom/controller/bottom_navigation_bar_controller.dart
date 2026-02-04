import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as mp;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/login/view/login_view.dart';
import 'package:jovera_finance/screens/auth/signup/view/signup_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/view/calculator_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/view/chat_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/controller/dashboard_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/view/dashboard_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/view/home_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/view/services_view.dart';
import 'package:jovera_finance/screens/main_drawer/model/contact_model.dart';
import 'package:jovera_finance/screens/main_drawer/provider/main_drawer_provider.dart';
import 'package:jovera_finance/utilities/api/api_service.dart';

import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/utilities/localization/locale_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:permission_handler/permission_handler.dart';

typedef ReadFn = T Function<T>(ProviderListenable<T> provider);

Future<void> updateData(ReadFn read) async {
  await read(chatControllerProvider.notifier).getMyApplications();
  await read(dashboardControllerProvider.notifier).getMyApplications();
}

void goToLoginScreen(ReadFn read) {
  AppNavigator.pushAndRemoveUntil(const BottomnavigationBarView());
  read(bottomNavigationBarControllerProvider.notifier).onItemTapped(4);
}

void goToHomeScreen(ReadFn read) {
  AppNavigator.pushAndRemoveUntil(const BottomnavigationBarView());
  read(bottomNavigationBarControllerProvider.notifier).onItemTapped(0);
}

class BottomNavigationBarState {
   BottomNavigationBarState({
    required this.passwordController,
    required this.currentPasswordController,
    required this.deleteReasonController,
    required this.nameController,
    required this.emailController,
    required this.profileWhatsappController,
    required this.confirmPasswordController,
    required this.phoneNumberController,
    required this.callBackFullNameController,
    required this.callBackPhoneController,
    required this.callBackEmailController,
    required this.callBackMessageController,
    required this.appLoadingController,
    required this.contactList,
    this.selectedIndex = 0,
    this.selectedHomeSubPage = 0,
    this.isLogin = true,
    this.selectedContactIndex = 0,
    this.profilePicturePath = '',
    this.currentPasswordIsVisible = false,
    this.passwordIsVisible = false,
    this.confirmPasswordIsVisible = false,
    this.whatsappCountryCode = '',
    this.countryCode = '',
    this.callbackCountryCode = '',
    DateTime? selectedDate,
    this.language = true,
    this.notification = true,
    this.retypePasswordIsVisible = false,
    this.selectedLanguage = '',
    this.appUser,
    this.selectedLoanType = 'Business Loan',
  }) : selectedDate = selectedDate ?? DateTime.now();

  final int selectedIndex;
  final int selectedHomeSubPage;
  final bool isLogin;
  final int selectedContactIndex;
  final String profilePicturePath;
  final TextEditingController passwordController;
  final TextEditingController currentPasswordController;
  final TextEditingController deleteReasonController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController profileWhatsappController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneNumberController;
  final bool currentPasswordIsVisible;
  final bool passwordIsVisible;
  final bool confirmPasswordIsVisible;
  final String whatsappCountryCode;
  final String countryCode;
  final String callbackCountryCode;
  final AppLoadingController appLoadingController;
  final DateTime selectedDate;
  final bool language;
  final bool notification;
  final bool retypePasswordIsVisible;
  final String selectedLanguage;
  final AppUser? appUser;
  final TextEditingController callBackFullNameController;
  final TextEditingController callBackPhoneController;
  final TextEditingController callBackEmailController;
  final TextEditingController callBackMessageController;
  final String selectedLoanType;
  final List<ContactModel> contactList;

  BottomNavigationBarState copyWith({
    int? selectedIndex,
    int? selectedHomeSubPage,
    bool? isLogin,
    int? selectedContactIndex,
    String? profilePicturePath,
    bool? currentPasswordIsVisible,
    bool? passwordIsVisible,
    bool? confirmPasswordIsVisible,
    String? whatsappCountryCode,
    String? countryCode,
    String? callbackCountryCode,
    DateTime? selectedDate,
    bool? language,
    bool? notification,
    bool? retypePasswordIsVisible,
    String? selectedLanguage,
    AppUser? appUser,
    String? selectedLoanType,
  }) {
    return BottomNavigationBarState(
      passwordController: passwordController,
      currentPasswordController: currentPasswordController,
      deleteReasonController: deleteReasonController,
      nameController: nameController,
      emailController: emailController,
      profileWhatsappController: profileWhatsappController,
      confirmPasswordController: confirmPasswordController,
      phoneNumberController: phoneNumberController,
      callBackFullNameController: callBackFullNameController,
      callBackPhoneController: callBackPhoneController,
      callBackEmailController: callBackEmailController,
      callBackMessageController: callBackMessageController,
      appLoadingController: appLoadingController,
      contactList: contactList,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedHomeSubPage: selectedHomeSubPage ?? this.selectedHomeSubPage,
      isLogin: isLogin ?? this.isLogin,
      selectedContactIndex: selectedContactIndex ?? this.selectedContactIndex,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath,
      currentPasswordIsVisible:
          currentPasswordIsVisible ?? this.currentPasswordIsVisible,
      passwordIsVisible: passwordIsVisible ?? this.passwordIsVisible,
      confirmPasswordIsVisible:
          confirmPasswordIsVisible ?? this.confirmPasswordIsVisible,
      whatsappCountryCode: whatsappCountryCode ?? this.whatsappCountryCode,
      countryCode: countryCode ?? this.countryCode,
      callbackCountryCode: callbackCountryCode ?? this.callbackCountryCode,
      selectedDate: selectedDate ?? this.selectedDate,
      language: language ?? this.language,
      notification: notification ?? this.notification,
      retypePasswordIsVisible:
          retypePasswordIsVisible ?? this.retypePasswordIsVisible,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      appUser: appUser ?? this.appUser,
      selectedLoanType: selectedLoanType ?? this.selectedLoanType,
    );
  }
}

class BottomNavigationBarController
    extends StateNotifier<BottomNavigationBarState> {
  BottomNavigationBarController(this.ref)
    : super(
        BottomNavigationBarState(
          passwordController: TextEditingController(),
          currentPasswordController: TextEditingController(),
          deleteReasonController: TextEditingController(),
          nameController: TextEditingController(),
          emailController: TextEditingController(),
          profileWhatsappController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          phoneNumberController: TextEditingController(),
          callBackFullNameController: TextEditingController(),
          callBackPhoneController: TextEditingController(),
          callBackEmailController: TextEditingController(),
          callBackMessageController: TextEditingController(),
          appLoadingController: AppLoadingController(),
          contactList: [
            ContactModel(icon: "assets/icons/contact_icon.svg", title: "Help"),
            ContactModel(icon: "assets/icons/address_icon.svg", title: "Address"),
            ContactModel(icon: "assets/icons/call_icon.svg", title: "Call Back"),
          ],
        ),
      ) {
    _init();
  }

  final Ref ref;
  int get selectedIndex => state.selectedIndex;
  int get selectedHomeSubPage => state.selectedHomeSubPage;
  bool get isLogin => state.isLogin;
  set isLogin(bool value) => state = state.copyWith(isLogin: value);
  set selectedIndex(int value) => state = state.copyWith(selectedIndex: value);
  set selectedHomeSubPage(int value) =>
      state = state.copyWith(selectedHomeSubPage: value);

  Future<void> _init() async {
    selectedLanguage = ref.read(localeControllerProvider).toString();

    language = selectedLanguage == 'en_US';
    await checkNotificationStatus();
    populateUserData();
  }

  bool loggedIn() {
    if (ref.read(authManagerProvider).isLogged) {
      return true;
    } else {
      return false;
    }
  }

  void onItemTapped(int index) {
    selectedIndex = index;
  }

  void setIndex(int index) {
    onItemTapped(index);
  }

  List<Widget> get widgetOptions => <Widget>[
    const HomeView(),
    const ServicesView(),
    const CalculatorView(),
    loggedIn()
        ? const ChatView()
        : isLogin
        ? LoginView()
        : SignupView(),
    loggedIn()
        ? const DashboardView()
        : isLogin
        ? LoginView()
        : SignupView(),
  ];

  int get selectedContactIndex => state.selectedContactIndex;
  set selectedContactIndex(int value) =>
      state = state.copyWith(selectedContactIndex: value);

  String get profilePicturePath => state.profilePicturePath;
  set profilePicturePath(String value) =>
      state = state.copyWith(profilePicturePath: value);
  TextEditingController get passwordController => state.passwordController;
  TextEditingController get currentPasswordController =>
      state.currentPasswordController;
  TextEditingController get deleteReasonController => state.deleteReasonController;
  TextEditingController get nameController => state.nameController;
  TextEditingController get emailController => state.emailController;

  TextEditingController get profileWhatsappController =>
      state.profileWhatsappController;
  TextEditingController get confirmPasswordController =>
      state.confirmPasswordController;

  TextEditingController get phoneNumberController => state.phoneNumberController;
  bool get currentPasswordIsVisible => state.currentPasswordIsVisible;
  set currentPasswordIsVisible(bool value) =>
      state = state.copyWith(currentPasswordIsVisible: value);
  bool get passwordIsVisible => state.passwordIsVisible;
  set passwordIsVisible(bool value) =>
      state = state.copyWith(passwordIsVisible: value);
  bool get confirmPasswordIsVisible => state.confirmPasswordIsVisible;
  set confirmPasswordIsVisible(bool value) =>
      state = state.copyWith(confirmPasswordIsVisible: value);
  String get whatsappCountryCode => state.whatsappCountryCode;
  set whatsappCountryCode(String value) =>
      state = state.copyWith(whatsappCountryCode: value);
  String get countryCode => state.countryCode;
  set countryCode(String value) => state = state.copyWith(countryCode: value);
  String get callbackCountryCode => state.callbackCountryCode;
  set callbackCountryCode(String value) =>
      state = state.copyWith(callbackCountryCode: value);
  AppLoadingController get appLoadingController => state.appLoadingController;
  DateTime get selectedDate => state.selectedDate;
  set selectedDate(DateTime value) => state = state.copyWith(selectedDate: value);
  bool get language => state.language;
  set language(bool value) => state = state.copyWith(language: value);
  bool get notification => state.notification;
  set notification(bool value) => state = state.copyWith(notification: value);
  bool get retypePasswordIsVisible => state.retypePasswordIsVisible;
  set retypePasswordIsVisible(bool value) =>
      state = state.copyWith(retypePasswordIsVisible: value);
  String get selectedLanguage => state.selectedLanguage;
  set selectedLanguage(String value) =>
      state = state.copyWith(selectedLanguage: value);
  AppUser? get appUser => state.appUser;
  set appUser(AppUser? value) => state = state.copyWith(appUser: value);

  TextEditingController get callBackFullNameController =>
      state.callBackFullNameController;
  TextEditingController get callBackPhoneController =>
      state.callBackPhoneController;
  TextEditingController get callBackEmailController =>
      state.callBackEmailController;
  TextEditingController get callBackMessageController =>
      state.callBackMessageController;

  String get selectedLoanType => state.selectedLoanType;
  set selectedLoanType(String value) =>
      state = state.copyWith(selectedLoanType: value);

  List<ContactModel> get contactList => state.contactList;

  void changeLanguage(String languageCode) {
    ref.read(localeControllerProvider.notifier).setLocale(languageCode);
    selectedLanguage = languageCode;
  }

  Future<void> checkNotificationStatus() async {
    final NotificationService notificationService =
        ref.read(notificationServiceProvider);
    notification = await notificationService.areNotificationsEnabled();
  }


  Future<void> changePassword() async {
    appLoadingController.loading();
    MainDrawerProvider().changePassword(
      newPassword: passwordController.text,
      currentPassword: currentPasswordController.text,

      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        appTools.showSuccessSnackBar("Password Reset Successful.");
        passwordController.clear();
        confirmPasswordController.clear();
        currentPasswordController.clear();
        AppNavigator.pop();
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.message);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during request, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> requestCallBack() async {
    appLoadingController.loading();
    MainDrawerProvider().requestCallBack(
      name: callBackFullNameController.text,
      phone:
          "${callBackPhoneController.text.startsWith("+") ? "" : "+"}$callbackCountryCode${callBackPhoneController.text}",
      email: callBackEmailController.text,
      description: callBackMessageController.text,
      product: selectedLoanType,

      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        AppNavigator.pop();
        appTools.showSuccessSnackBar(
          'Your request has been submitted. We will get back to you soon.',
        );
        callBackFullNameController.clear();
        callBackPhoneController.clear();
        callBackEmailController.clear();
        callBackMessageController.clear();
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.message);
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
      reason: deleteReasonController.text,

      onSuccess: (response) {
        appLoadingController.stop();
        appTools.showSuccessSnackBar(
          "Request for Deleting the account is submitted successfully. After short review, you will be notified.",
        );

        deleteReasonController.clear();
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
    final notificationService = ref.read(notificationServiceProvider);

    if (Platform.isAndroid) {
      const platform = MethodChannel('app.settings.channel');
      try {
        await platform.invokeMethod('openNotificationSettings');
        if (value) {
          await notificationService.initFirebaseNotification();
          final enabledNow =
              await notificationService.areNotificationsEnabled();
          notification = enabledNow;
        }

        final enabledNow = await notificationService.areNotificationsEnabled();
        notification = enabledNow;
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
    appUser = ref.read(authManagerProvider).appUser;
    nameController.text = appUser?.name ?? "";

    emailController.text = appUser?.email ?? "";
    phoneNumberController.text = appUser?.phone ?? "";
    profilePicturePath = appUser?.picture ?? "";
    profileWhatsappController.text = appUser?.whatsapp ?? "";
    whatsappCountryCode = '';
    countryCode = '';
  }

  Future<void> editProfile() async {
    Map<String, dynamic> resultMap = await getProfileFormData();
    appLoadingController.loading();
    MainDrawerProvider().editProfile(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        appLoadingController.stop();
        final ApiService apiService = ref.read(apiServiceProvider);
        final token = ref.read(authManagerProvider.notifier).getToken();
        if (token != null) {
          await apiService.getUserDataByToken(token);
        }
        populateUserData();
        appTools.showSuccessSnackBar("Profile updated.");
        AppNavigator.pop();
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

    if (nameController.text != appUser?.name) {
      profileFormData["name"] = nameController.text;
    }

    if (profileWhatsappController.text.isNotEmpty &&
        ("$whatsappCountryCode${profileWhatsappController.text}" !=
            appUser?.whatsapp)) {
      profileFormData["w_phone"] =
          "${profileWhatsappController.text.startsWith("+") ? "" : "+"}$whatsappCountryCode${profileWhatsappController.text}";
    }
    if (kDebugMode) print(profileFormData);
    if (profilePicturePath.isNotEmpty) {
      if (!profilePicturePath.startsWith("https")) {
        String ext = profilePicturePath.split('.').last.toLowerCase();
        profileFormData["picture"] = await mp.MultipartFile.fromFile(
          profilePicturePath,
          contentType: MediaType(
            ext == 'pdf' ? 'application' : 'image',
            ext == 'jpg' ? 'jpeg' : ext,
          ),
          filename:
              "profile_picture_${profilePicturePath.split('/').last}",
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
        AppNavigator.pop();
        doc = await FilePicker.platform.pickFiles(type: FileType.image);

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          profilePicturePath = file.path;
        } else {}
      },

      () async {
        AppNavigator.pop();
      },

      () async {
        AppNavigator.pop();

        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        if (image != null) {
          File file = File(image.path);
          profilePicturePath = file.path;
        } else {}
      },
    );
  }

  Future<bool> showNotificationsDialog(value) async {
    return await AppNavigator.showDialog<bool>(
          builder: (_) {
            return AlertDialog(
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
                onPressed: () => AppNavigator.pop(false),
                child: MainText(text: "Cancel"),
              ),
              TextButton(
                onPressed: () {
                  AppNavigator.pop();
                  toggleNotificationPermission(value);
                },
                child: MainText(
                  text: "Go To Settings",
                  color: AppColors.primary,
                ),
              ),
            ],
          );
          },
        ) ??
        false;
  }

  @override
  void dispose() {
    passwordController.dispose();
    currentPasswordController.dispose();
    deleteReasonController.dispose();
    nameController.dispose();
    emailController.dispose();
    profileWhatsappController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    callBackFullNameController.dispose();
    callBackPhoneController.dispose();
    callBackEmailController.dispose();
    callBackMessageController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final bottomNavigationBarControllerProvider =
    StateNotifierProvider<BottomNavigationBarController, BottomNavigationBarState>(
      (ref) {
  return BottomNavigationBarController(ref);
});
