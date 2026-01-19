import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/model/document_model.dart';
import 'package:jovera_finance/screens/mortgage/provider/mortgage_provider.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';

class MortgageController extends GetxController {
  static const String calculatorNational = "UAE National";
  static const String calculatorResident = "UAE Resident";
  static const String calculatorNonResident = "Non-Resident";

  static const double mortgagePriceMin = 3000000;
  static const double mortgagePriceMax = 100000000;
  static const int mortgageYearsMin = 1;
  static const int mortgageYearsMax = 25;
  static const double mortgageInterestMin = 1;
  static const double mortgageInterestMax = 10;

  static const double mortgageDefaultPrice = 3000000;
  static const double mortgageDefaultAdvance = 750000;
  static const double mortgageDefaultLoan = 2250000;
  static const int mortgageDefaultYears = 20;
  static const double mortgageDefaultInterest = 4;

  static const double advanceMinPercent = 0.25;
  static const double advanceMinPercentNonResident = 0.4;
  static const double advanceMaxPercent = 0.8;
  static const double loanMinPercent = 0.2;
  static const double loanMaxPercent = 0.75;
  static const double loanMaxPercentNonResident = 0.6;

  RxString applicantType = "Salary".obs;
  RxString mobileCountryCode = "+971".obs;
  RxDouble propertyPrice = mortgageDefaultPrice.obs;
  RxDouble advancePayment = mortgageDefaultAdvance.obs;
  RxDouble loanAmount = mortgageDefaultLoan.obs;
  RxDouble interestRate = mortgageDefaultInterest.obs;
  RxInt propertyPeriod = mortgageDefaultYears.obs;
  RxString calculatorType = calculatorNational.obs;
  final TextEditingController priceInputController = TextEditingController();
  final TextEditingController advanceInputController = TextEditingController();
  final TextEditingController loanInputController = TextEditingController();
  final TextEditingController yearsInputController = TextEditingController();
  final TextEditingController interestInputController = TextEditingController();
  final FocusNode priceInputFocusNode = FocusNode();
  final FocusNode advanceInputFocusNode = FocusNode();
  final FocusNode loanInputFocusNode = FocusNode();
  final FocusNode yearsInputFocusNode = FocusNode();
  final FocusNode interestInputFocusNode = FocusNode();
  // Legacy calculator state (kept for reference).
  // RxDouble propertyPrice = 8000000.0.obs;
  // RxDouble advancePayment = 26.0.obs;
  // RxDouble interestRate = 4.5.obs;
  // RxInt propertyPeriod = 15.obs;
  // RxDouble advancePercentage = 0.2.obs;
  // RxString advance = "20%".obs;
  // RxString calculatorType = "UAE National".obs;
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
  Rx<DocumentModel> salaryCertificateDocument = DocumentModel().obs;
  Rx<DocumentModel> bankStatementDocument = DocumentModel().obs;
  Rx<DocumentModel> etihadBureauDocument = DocumentModel().obs;
  Rx<DocumentModel> tradeLicenseDocument = DocumentModel().obs;
  Rx<DocumentModel> fourVATPaymentsDocument = DocumentModel().obs;

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
  List conditions = ["New", "Old", "Off Plan"];
  List properties = ["Villa", "Apartment", "Townhouse", "Land"];

  bool get isNonResident => calculatorType.value == calculatorNonResident;

  double get advanceMin =>
      propertyPrice.value *
      (isNonResident ? advanceMinPercentNonResident : advanceMinPercent);

  double get advanceMax => propertyPrice.value * advanceMaxPercent;

  double get loanMin => propertyPrice.value * loanMinPercent;

  double get loanMax =>
      propertyPrice.value *
      (isNonResident ? loanMaxPercentNonResident : loanMaxPercent);

  void resetMortgageDefaults() {
    propertyPrice.value = mortgageDefaultPrice;
    propertyPeriod.value = mortgageDefaultYears;
    interestRate.value = mortgageDefaultInterest;
    advancePayment.value = mortgageDefaultAdvance;
    loanAmount.value = mortgageDefaultLoan;
    _syncMortgageAmounts();
  }

  void setCalculatorType(String type) {
    calculatorType.value = type;
    _syncMortgageAmounts();
    // Legacy logic (percentage based).
    // if (type == "UAE National") {
    //   advancePercentage.value = 0.2;
    //   advance.value = "20%";
    // } else {
    //   advancePercentage.value = 0.25;
    //   advance.value = "25%";
    // }
    // advancePayment.value =
    //     advancePercentage.value * propertyPrice.value;
  }

  void updatePropertyPrice(double value) {
    propertyPrice.value = value;
    _syncMortgageAmounts();
    // Legacy logic (percentage based).
    // advancePayment.value =
    //     advancePercentage.value * propertyPrice.value;
  }

  void updateAdvancePayment(double value) {
    final double newAdvance = _clampDouble(value, advanceMin, advanceMax);
    advancePayment.value = newAdvance;
    loanAmount.value = propertyPrice.value - newAdvance;
  }

  void updateLoanAmount(double value) {
    final double newLoan = _clampDouble(value, loanMin, loanMax);
    loanAmount.value = newLoan;
    advancePayment.value = propertyPrice.value - newLoan;
  }

  void _syncMortgageAmounts() {
    final double minAdvance = advanceMin;
    final double maxAdvance = advanceMax;
    final double minLoan = loanMin;
    final double maxLoan = loanMax;

    double newAdvance = _clampDouble(
      advancePayment.value,
      minAdvance,
      maxAdvance,
    );
    double newLoan = propertyPrice.value - newAdvance;
    newLoan = _clampDouble(newLoan, minLoan, maxLoan);
    newAdvance = propertyPrice.value - newLoan;

    advancePayment.value = newAdvance;
    loanAmount.value = newLoan;
  }

  double _clampDouble(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  @override
  onInit() {
    resetMortgageDefaults();
    // Legacy init.
    // advancePayment.value = advancePercentage * propertyPrice.value;
    super.onInit();
  }

  @override
  onReady() {
    calculateEMI();
    // Legacy ready.
    // advancePayment.value = advancePercentage * propertyPrice.value;
    super.onReady();
  }

  @override
  void onClose() {
    priceInputController.dispose();
    advanceInputController.dispose();
    loanInputController.dispose();
    yearsInputController.dispose();
    interestInputController.dispose();
    priceInputFocusNode.dispose();
    advanceInputFocusNode.dispose();
    loanInputFocusNode.dispose();
    yearsInputFocusNode.dispose();
    interestInputFocusNode.dispose();
    super.onClose();
  }

  Future<void> applyMortgageLoan() async {
    Map<String, dynamic> resultMap = await getMortgageLoanData();
    appLoadingController.loading();
    MortgageProvider().applyMortgageLoan(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        if (kDebugMode) print(response);
        appLoadingController.stop();
        appTools.showSuccessSnackBar(
          "Your application is successfully submitted. We will get back to you after a short review.",
        );
        goToLoginScreen();
        await updateData();
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.response);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred, Please try again later',
          timer: 0,
        );
      },
    );
  }

  Future<Map<String, dynamic>> getMortgageLoanData() async {
    Map<String, dynamic> mortgageLoanData = {};

    mortgageLoanData["client"] = authManager.appUser.value.id;

    mortgageLoanData["product"] = "Mortgage Loan";

    mortgageLoanData["description"] =
        "Loan Amount: ${propertyPrice.value}, Payment Period: ${propertyPeriod.value} Years, Name: ${personalNameController.value.text}, Nationality: ${nationalityType.value}, Phone: ${mobileCountryCode.value.startsWith("+") ? "" : "+"}${mobileCountryCode.value}${personalPhoneNumberController.value.text}, Email: ${personalEmailController.value.text}, Property Type: ${propertyType.value}, Property Location: ${propertyLocation.value}, Property Condition: ${propertyCondition.value}";

    List<DocumentModel> documents = [
      passportDocument.value,
      emiratesIdDocument.value,
      salaryCertificateDocument.value,
      bankStatementDocument.value,
      etihadBureauDocument.value,
      tradeLicenseDocument.value,
      fourVATPaymentsDocument.value,
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
    mortgageLoanData["files"] = fileList;
    if (kDebugMode) print(mortgageLoanData);
    return mortgageLoanData;
  }

  double calculateEMI() {
    // Legacy principal calculation.
    // double loanAmount = propertyPrice.value - advancePayment.value;
    double principal = loanAmount.value;
    double monthlyRate = interestRate.value / 12 / 100;
    int totalMonths = propertyPeriod.value * 12;
    if (kDebugMode) {
      print(advancePayment.value);
    }
    if (monthlyRate == 0) {
      return principal / totalMonths;
    }

    double emi =
        principal *
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

  selectTradeLicenseDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        tradeLicenseDocument.value.filePath = getDocument(photoCopy);
        if (kDebugMode) print(tradeLicenseDocument.value.filePath);
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

  selectSalaryCertificateDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        salaryCertificateDocument.value.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        photoCopy = await pickPdf();
        salaryCertificateDocument.value.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        salaryCertificateDocument.value.filePath = getImage(image);
        initSalaryDocument();
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

  selectVATDocument(context) {
    FilePickerResult? photoCopy;
    DocumentPicker().documentPickerWidget(
      context,
      () async {
        photoCopy = await pickfromGallery();
        fourVATPaymentsDocument.value.filePath = getDocument(photoCopy);
        initVATDocument();
      },
      () async {
        photoCopy = await pickPdf();
        fourVATPaymentsDocument.value.filePath = getDocument(photoCopy);
        initVATDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        fourVATPaymentsDocument.value.filePath = getImage(image);
        initVATDocument();
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

  initEmiratesIdDocument() {
    if (emiratesIdDocument.value.fileName != "") {
      emiratesIdDocument.value.fileName =
          "emiratesId.${emiratesIdDocument.value.filePath?.split('.').last}";
    }
    emiratesIdDocument.update(emiratesIdDocument.call);
  }

  initTradeLicenseDocument() {
    if (tradeLicenseDocument.value.fileName != "") {
      tradeLicenseDocument.value.fileName =
          "trade_license.${tradeLicenseDocument.value.filePath?.split('.').last}";
    }
    tradeLicenseDocument.update(tradeLicenseDocument.call);
  }

  initSalaryDocument() {
    if (salaryCertificateDocument.value.fileName != "") {
      salaryCertificateDocument.value.fileName =
          "salary_certificate.${salaryCertificateDocument.value.filePath?.split('.').last}";
    }
    salaryCertificateDocument.update(salaryCertificateDocument.call);
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

  initVATDocument() {
    if (fourVATPaymentsDocument.value.fileName != "") {
      fourVATPaymentsDocument.value.fileName =
          "VAT_payments.${fourVATPaymentsDocument.value.filePath?.split('.').last}";
    }
    fourVATPaymentsDocument.update(fourVATPaymentsDocument.call);
  }
}
