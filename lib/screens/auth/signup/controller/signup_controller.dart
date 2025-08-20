import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as mp;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/signup/provider/signup_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';

class SignUpController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> retypePasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  Rx<TextEditingController> genderController = TextEditingController().obs;
  RxBool passwordIsVisible = false.obs;
  RxString countryCode = '971'.obs;
  RxString whatsappCode = '971'.obs;
  RxString profilePicturePath = ''.obs;
  AppLoadingController appLoadingController = AppLoadingController();
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> whatsappController = TextEditingController().obs;
  final phoneFocus = FocusNode();
  var selectedDate = DateTime.now().obs;
  RxBool retypePasswordIsVisible = false.obs;
  RxInt otp = 0000.obs;
  final AuthManager authManager = Get.find();

  Future<Map<String, dynamic>> getProfileFormData() async {
    Map<String, dynamic> profileFormData = {};

    profileFormData["name"] = nameController.value.text;

    profileFormData["phone"] =
        "+${countryCode.value}${phoneController.value.text}";

    profileFormData["password"] = passwordController.value.text;

    profileFormData["email"] = emailController.value.text;
    profileFormData["fcmToken"] = await appTools.getFCMTokenForDevice();

    profileFormData["w_phone"] =
        "+${whatsappCode.value}${whatsappController.value.text}";

    if (profilePicturePath.isNotEmpty) {
      String ext = profilePicturePath.value.split('.').last.toLowerCase();
      profileFormData["picture"] = await mp.MultipartFile.fromFile(
        profilePicturePath.value,
        contentType: MediaType(
          ext == 'pdf' ? 'application' : 'image',
          ext == 'jpg' ? 'jpeg' : ext,
        ),
        filename: "profile_picture_${profilePicturePath.value.split('/').last}",
      );
    }
    print(profileFormData);
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
        print(error.response);
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
      email: emailController.value.text,
      password: passwordController.value.text,

      onSuccess: (response) {
        appLoadingController.stop();
        print(response);
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          authManager.appUser.value = AppUser.fromJson(responseData['user']);
        } else if (response.data is Map<String, dynamic>) {
          authManager.appUser.value = AppUser.fromJson(response.data['user']);
        }
        authManager.login();
        emailController.value.clear();
        passwordController.value.clear();

        appTools.showSuccessSnackBar(
          "Congratulations. Your account is ready to use.",
        );
        Get.offAll(
          () => BottomnavigationBarView(),
          binding: BottomNavigationBarBinding(),
        );
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
      context: Get.context!,
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
                initialDateTime: selectedDate.value.add(
                  const Duration(hours: 1),
                ),
                backgroundColor: AppColors.white,
                minimumDate: DateTime(1900, 1, 1),
                maximumDate: DateTime(2030),
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                showDayOfWeek: true,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate.value = newDate;
                  dateOfBirthController.value.text =
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
}
