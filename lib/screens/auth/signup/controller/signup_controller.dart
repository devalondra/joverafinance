import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as mp;
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/signup/provider/signup_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_context.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class SignUpState {
   SignUpState({
    required this.passwordController,
    required this.retypePasswordController,
    required this.otpController,
    required this.genderController,
    required this.appLoadingController,
    required this.dateOfBirthController,
    required this.emailController,
    required this.nameController,
    required this.lastNameController,
    required this.phoneController,
    required this.whatsappController,
    required this.phoneFocus,
    this.passwordIsVisible = false,
    this.countryCode = '971',
    this.whatsappCode = '971',
    this.profilePicturePath = '',
    DateTime? selectedDate,
    this.retypePasswordIsVisible = false,
    this.otp = 0000,
  }) : selectedDate = selectedDate ?? DateTime.now();

  final TextEditingController passwordController;
  final TextEditingController retypePasswordController;
  final TextEditingController otpController;
  final TextEditingController genderController;
  final bool passwordIsVisible;
  final String countryCode;
  final String whatsappCode;
  final String profilePicturePath;
  final AppLoadingController appLoadingController;
  final TextEditingController dateOfBirthController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController whatsappController;
  final FocusNode phoneFocus;
  final DateTime selectedDate;
  final bool retypePasswordIsVisible;
  final int otp;

  SignUpState copyWith({
    bool? passwordIsVisible,
    String? countryCode,
    String? whatsappCode,
    String? profilePicturePath,
    DateTime? selectedDate,
    bool? retypePasswordIsVisible,
    int? otp,
  }) {
    return SignUpState(
      passwordController: passwordController,
      retypePasswordController: retypePasswordController,
      otpController: otpController,
      genderController: genderController,
      appLoadingController: appLoadingController,
      dateOfBirthController: dateOfBirthController,
      emailController: emailController,
      nameController: nameController,
      lastNameController: lastNameController,
      phoneController: phoneController,
      whatsappController: whatsappController,
      phoneFocus: phoneFocus,
      passwordIsVisible: passwordIsVisible ?? this.passwordIsVisible,
      countryCode: countryCode ?? this.countryCode,
      whatsappCode: whatsappCode ?? this.whatsappCode,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath,
      selectedDate: selectedDate ?? this.selectedDate,
      retypePasswordIsVisible:
          retypePasswordIsVisible ?? this.retypePasswordIsVisible,
      otp: otp ?? this.otp,
    );
  }
}

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(this.ref)
    : super(
        SignUpState(
          passwordController: TextEditingController(),
          retypePasswordController: TextEditingController(),
          otpController: TextEditingController(),
          genderController: TextEditingController(),
          appLoadingController: AppLoadingController(),
          dateOfBirthController: TextEditingController(),
          emailController: TextEditingController(),
          nameController: TextEditingController(),
          lastNameController: TextEditingController(),
          phoneController: TextEditingController(),
          whatsappController: TextEditingController(),
          phoneFocus: FocusNode(),
        ),
      );

  final Ref ref;

  TextEditingController get passwordController => state.passwordController;
  TextEditingController get retypePasswordController =>
      state.retypePasswordController;
  TextEditingController get otpController => state.otpController;
  TextEditingController get genderController => state.genderController;
  bool get passwordIsVisible => state.passwordIsVisible;
  String get countryCode => state.countryCode;
  String get whatsappCode => state.whatsappCode;
  String get profilePicturePath => state.profilePicturePath;
  AppLoadingController get appLoadingController => state.appLoadingController;
  TextEditingController get dateOfBirthController =>
      state.dateOfBirthController;
  TextEditingController get emailController => state.emailController;
  TextEditingController get nameController => state.nameController;
  TextEditingController get lastNameController => state.lastNameController;
  TextEditingController get phoneController => state.phoneController;
  TextEditingController get whatsappController => state.whatsappController;
  FocusNode get phoneFocus => state.phoneFocus;
  DateTime get selectedDate => state.selectedDate;
  bool get retypePasswordIsVisible => state.retypePasswordIsVisible;
  int get otp => state.otp;

  set passwordIsVisible(bool value) {
    state = state.copyWith(passwordIsVisible: value);
  }

  set countryCode(String value) {
    state = state.copyWith(countryCode: value);
  }

  set whatsappCode(String value) {
    state = state.copyWith(whatsappCode: value);
  }

  set profilePicturePath(String value) {
    state = state.copyWith(profilePicturePath: value);
  }

  set selectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }

  set retypePasswordIsVisible(bool value) {
    state = state.copyWith(retypePasswordIsVisible: value);
  }

  set otp(int value) {
    state = state.copyWith(otp: value);
  }

  Future<Map<String, dynamic>> getProfileFormData() async {
    Map<String, dynamic> profileFormData = {};

    profileFormData["name"] = nameController.text;

    profileFormData["phone"] = "+$countryCode${phoneController.text}";

    profileFormData["password"] = passwordController.text;

    profileFormData["email"] = emailController.text;
    profileFormData["fcmToken"] = await appTools.getFCMTokenForDevice();

    // profileFormData["w_phone"] =
    //     "+${whatsappCode.value}${whatsappController.value.text}";

    // if (profilePicturePath.isNotEmpty) {
    //   String ext = profilePicturePath.value.split('.').last.toLowerCase();
    //   profileFormData["picture"] = await mp.MultipartFile.fromFile(
    //     profilePicturePath.value,
    //     contentType: MediaType(
    //       ext == 'pdf' ? 'application' : 'image',
    //       ext == 'jpg' ? 'jpeg' : ext,
    //     ),
    //     filename: "profile_picture_${profilePicturePath.value.split('/').last}",
    //   );
    // }
    if (kDebugMode) print(profileFormData);
    return profileFormData;
  }

  Future<void> signup() async {
    Map<String, dynamic> resultMap = await getProfileFormData();
    appLoadingController.loading();
    SignupProvider().signup(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) {
        appLoadingController.stop();
        secretLogin();
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.response);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during registration, Please try again later',
          timer: 0,
        );
      },
    );
  }

  Future<void> secretLogin() async {
    appLoadingController.loading();
    SignupProvider().secretLogin(
      email: emailController.text,
      password: passwordController.text,

      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          ref
              .read(authManagerProvider.notifier)
              .setUser(AppUser.fromJson(responseData));
        } else if (response.data is Map<String, dynamic>) {
          ref
              .read(authManagerProvider.notifier)
              .setUser(AppUser.fromJson(response.data));
        }
        ref.read(authManagerProvider.notifier).login();
        ref
            .read(bottomNavigationBarControllerProvider.notifier)
            .onItemTapped(0);
        emailController.clear();
        passwordController.clear();
        retypePasswordController.clear();
        phoneController.clear();
        appTools.showSuccessSnackBar(
          "Congratulations. Your account is ready to use.".tr,
        );
        AppNavigator.pushAndRemoveUntil(BottomnavigationBarView());
      },
      onError: (error) {
        appLoadingController.stop();

        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during registration, Please try again later',
          timer: 1,
        );
      },
    );
  }

  void showCupertinoDialog() {
    showCupertinoModalPopup<void>(
      context: AppContext.context!,
      builder:
          (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),

            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(fullWidth * 0.04),
            ),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate.add(const Duration(hours: 1)),
                backgroundColor: AppColors.white,
                minimumDate: DateTime(1900, 1, 1),
                maximumDate: DateTime(2030),
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                showDayOfWeek: true,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                  dateOfBirthController.text =
                      "${newDate.day} ${getMonthName(newDate.month)} ${newDate.year}";
                },
              ),
            ),
          ),
    );
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";

      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
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

  @override
  void dispose() {
    passwordController.dispose();
    retypePasswordController.dispose();
    otpController.dispose();
    genderController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    phoneFocus.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final signUpControllerProvider =
    StateNotifierProvider<SignUpController, SignUpState>((
  ref,
) {
  return SignUpController(ref);
});
