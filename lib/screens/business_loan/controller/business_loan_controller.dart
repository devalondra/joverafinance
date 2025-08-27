import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/model/document_model.dart';
import 'package:jovera_finance/screens/business_loan/provider/business_loan_provider.dart';

import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';

class BusinessLoanController extends GetxController {
  RxString applicantType = "SME".obs;
  RxString mobileCountryCode = "+971".obs;
  RxDouble loanAmount = 80000.0.obs;

  RxDouble interestRate = 4.5.obs;
  RxInt paymentPeriod = 15.obs;
  RxInt paymentMaxPeriod = 60.obs;

  RxString calculatorType = "UAE National".obs;
  AuthManager authManager = Get.find();
  AppLoadingController appLoadingController = AppLoadingController();
  Rx<TextEditingController> personalNameController =
      TextEditingController().obs;

  Rx<TextEditingController> personalPhoneNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> personalEmailController =
      TextEditingController().obs;

  Rx<DocumentModel> passportDocument = DocumentModel().obs;
  Rx<DocumentModel> emiratesIdDocument = DocumentModel().obs;
  Rx<DocumentModel> bankStatementDocument = DocumentModel().obs;
  Rx<DocumentModel> etihadBureauDocument = DocumentModel().obs;
  Rx<DocumentModel> tradeLicenseDocument = DocumentModel().obs;
  Rx<DocumentModel> memorandumDocument = DocumentModel().obs;

  RxString nationalityType = 'UAE National'.obs;
  RxString propertyType = 'Villa'.obs;
  RxString propertyLocation = 'Abu Dhabi'.obs;
  RxString propertyCondition = 'New'.obs;
  List emirates = [
    "Abu Dhabi",
    "Dubai",
    "Sharjah",
    "Ajman",
    "Umm Al Quwain",
    "Ras Al Khaimah",
    "Fujairah",
  ];
  List nationalities = ["UAE National", "Expat"];


  @override
  onReady() {
    calculateEMI();
    super.onReady();
  }

  Future<void> applyBusinessLoan() async {
    Map<String, dynamic> resultMap = await getPersonalLoanData();
    appLoadingController.loading();
    BusinessLoanProvider().applyBusinessLoan(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) {
        print(response);
        appLoadingController.stop();
        appTools.showSuccessSnackBar(
          "Your application is successfully submitted. We will get back to you after a short review.",
        );
        Get.offAll(
          () => BottomnavigationBarView(),
          binding: BottomNavigationBarBinding(),
        );
      },
      onError: (error) {
        appLoadingController.stop();
        print(error.response);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 0,
        );
      },
    );
  }

  Future<Map<String, dynamic>> getPersonalLoanData() async {
    Map<String, dynamic> personalLoanData = {};

    personalLoanData["client"] = authManager.appUser.value.id;

    personalLoanData["product"] = "Business Loan";

    personalLoanData["description"] =
        "Loan Amount: ${loanAmount.value}, Payment Period: ${paymentPeriod.value} Months, Name: ${personalNameController.value.text}, Nationality: ${nationalityType.value}, Phone: ${mobileCountryCode.value.startsWith("+") ? "" : "+"}${mobileCountryCode.value}${personalPhoneNumberController.value.text}, Email: ${personalEmailController.value.text}}";

    List<DocumentModel> documents = [
      passportDocument.value,
      emiratesIdDocument.value,
     
      bankStatementDocument.value,
      etihadBureauDocument.value,
      tradeLicenseDocument.value,
      memorandumDocument.value,
    ];

    List<mp.MultipartFile> fileList = [];

    for (var doc in documents) {
      if (doc.filePath != null && doc.filePath!.isNotEmpty) {
        String ext = doc.filePath!.split('.').last.toLowerCase();

        fileList.add(
          await mp.MultipartFile.fromFile(
            doc.filePath!,
            contentType: MediaType(
              ext == 'pdf' ? 'application' : 'image',
              ext == 'jpg' ? 'jpeg' : ext,
            ),
            filename: doc.fileName ?? doc.filePath!.split('/').last,
          ),
        );
      }
    }
    personalLoanData["files"] = fileList;
    print(personalLoanData);
    return personalLoanData;
  }

  double calculateEMI() {
    double monthlyRate = interestRate / 100;
    int totalMonths = paymentPeriod.value;

    if (monthlyRate == 0) {
      return loanAmount.value / totalMonths;
    }

    double emi =
        loanAmount.value *
        monthlyRate *
        (pow(1 + monthlyRate, totalMonths)) /
        (pow(1 + monthlyRate, totalMonths) - 1);

    return emi;
  }

  selectPassportDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        passportDocument.value.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        photoCopy = await pickPdf();
        passportDocument.value.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        passportDocument.value.filePath = getImage(image);
        initPassportDocument();
      },
    );
  }

  selectEmiratesIdDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        emiratesIdDocument.value.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        photoCopy = await pickPdf();
        emiratesIdDocument.value.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        emiratesIdDocument.value.filePath = getImage(image);
        initEmiratesIdDocument();
      },
    );
  }



  selectBankStatementDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        bankStatementDocument.value.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        photoCopy = await pickPdf();
        bankStatementDocument.value.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        bankStatementDocument.value.filePath = getImage(image);
        initBankStatementDocument();
      },
    );
  }

  selectTradeLicenseDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        tradeLicenseDocument.value.filePath = getDocument(photoCopy);
        print(tradeLicenseDocument.value.filePath);
        initTradeLicenseDocument();
      },
      () async {
        photoCopy = await pickPdf();
        tradeLicenseDocument.value.filePath = getDocument(photoCopy);
        initTradeLicenseDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        tradeLicenseDocument.value.filePath = getImage(image);
        initTradeLicenseDocument();
      },
    );
  }

  selectMemorandumDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        memorandumDocument.value.filePath = getDocument(photoCopy);
        print(tradeLicenseDocument.value.filePath);
        initMemorandumDocument();
      },
      () async {
        photoCopy = await pickPdf();
        memorandumDocument.value.filePath = getDocument(photoCopy);
        initMemorandumDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        memorandumDocument.value.filePath = getImage(image);
        initMemorandumDocument();
      },
    );
  }

  selectEtihadDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        etihadBureauDocument.value.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        photoCopy = await pickPdf();
        etihadBureauDocument.value.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        etihadBureauDocument.value.filePath = getImage(image);
        initEtihadDocument();
      },
    );
  }

  getDocument(photoCopy) {
    if (photoCopy != null) {
      File file = File(photoCopy!.files.single.path!);
      return file.path;
    } else {
      return "";
    }
  }

  getImage(image) {
    if (image != null) {
      File file = File(image.path);
      return file.path;
    } else {
      return "";
    }
  }

  pickPdf() async {
    Get.back();
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  pickfromGallery() async {
    Get.back();
    return await FilePicker.platform.pickFiles(type: FileType.image);
  }

  pickfromCamera() async {
    Get.back();
    return ImagePicker().pickImage(source: ImageSource.camera);
  }

  initPassportDocument() {
    if (passportDocument.value.fileName != "") {
      passportDocument.value.fileName =
          "passport.${passportDocument.value.filePath?.split('.').last}";
    }
    passportDocument.update(passportDocument.call);
  }

  initTradeLicenseDocument() {
    if (tradeLicenseDocument.value.fileName != "") {
      tradeLicenseDocument.value.fileName =
          "trade_license.${tradeLicenseDocument.value.filePath?.split('.').last}";
    }
    tradeLicenseDocument.update(tradeLicenseDocument.call);
  }

  initMemorandumDocument() {
    if (memorandumDocument.value.fileName != "") {
      memorandumDocument.value.fileName =
          "memorandum.${memorandumDocument.value.filePath?.split('.').last}";
    }
    memorandumDocument.update(memorandumDocument.call);
  }

  initEmiratesIdDocument() {
    if (emiratesIdDocument.value.fileName != "") {
      emiratesIdDocument.value.fileName =
          "emiratesId.${emiratesIdDocument.value.filePath?.split('.').last}";
    }
    emiratesIdDocument.update(emiratesIdDocument.call);
  }

 

  initBankStatementDocument() {
    if (bankStatementDocument.value.fileName != "") {
      bankStatementDocument.value.fileName =
          "bank_statement.${bankStatementDocument.value.filePath?.split('.').last}";
    }
    bankStatementDocument.update(bankStatementDocument.call);
  }

  initEtihadDocument() {
    if (etihadBureauDocument.value.fileName != "") {
      etihadBureauDocument.value.fileName =
          "etihad_bureau.${etihadBureauDocument.value.filePath?.split('.').last}";
    }
    etihadBureauDocument.update(etihadBureauDocument.call);
  }
}
