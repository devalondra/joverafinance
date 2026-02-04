import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/model/document_model.dart';
import 'package:jovera_finance/screens/mortgage/provider/mortgage_provider.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';

class MortgageState {
  const MortgageState({
    required this.appLoadingController,
    required this.priceInputController,
    required this.advanceInputController,
    required this.loanInputController,
    required this.yearsInputController,
    required this.interestInputController,
    required this.priceInputFocusNode,
    required this.advanceInputFocusNode,
    required this.loanInputFocusNode,
    required this.yearsInputFocusNode,
    required this.interestInputFocusNode,
    required this.personalNameController,
    required this.personalPhoneNumberController,
    required this.personalEmailController,
    required this.passportDocument,
    required this.emiratesIdDocument,
    required this.salaryCertificateDocument,
    required this.bankStatementDocument,
    required this.etihadBureauDocument,
    required this.tradeLicenseDocument,
    required this.fourVATPaymentsDocument,
    this.applicantType = "Salary",
    this.mobileCountryCode = "+971",
    this.propertyPrice = MortgageController.mortgageDefaultPrice,
    this.advancePayment = MortgageController.mortgageDefaultAdvance,
    this.loanAmount = MortgageController.mortgageDefaultLoan,
    this.interestRate = MortgageController.mortgageDefaultInterest,
    this.propertyPeriod = MortgageController.mortgageDefaultYears,
    this.calculatorType = MortgageController.calculatorNational,
    this.nationalityType = 'UAE National',
    this.propertyType = 'Villa',
    this.propertyLocation = 'Abu Dhabi',
    this.propertyCondition = 'New',
    this.emirates = const [
      "Abu Dhabi",
      "Dubai",
      "Sharjah",
      "Ajman",
      "Umm Al Quwain",
      "Ras Al Khaimah",
      "Fujairah",
    ],
    this.nationalities = const ["UAE National", "Expat"],
    this.conditions = const ["New", "Old", "Off Plan"],
    this.properties = const ["Villa", "Apartment", "Townhouse", "Land"],
  });

  final String applicantType;
  final String mobileCountryCode;
  final double propertyPrice;
  final double advancePayment;
  final double loanAmount;
  final double interestRate;
  final int propertyPeriod;
  final String calculatorType;
  final TextEditingController priceInputController;
  final TextEditingController advanceInputController;
  final TextEditingController loanInputController;
  final TextEditingController yearsInputController;
  final TextEditingController interestInputController;
  final FocusNode priceInputFocusNode;
  final FocusNode advanceInputFocusNode;
  final FocusNode loanInputFocusNode;
  final FocusNode yearsInputFocusNode;
  final FocusNode interestInputFocusNode;
  final AppLoadingController appLoadingController;
  final TextEditingController personalNameController;
  final TextEditingController personalPhoneNumberController;
  final TextEditingController personalEmailController;
  final DocumentModel passportDocument;
  final DocumentModel emiratesIdDocument;
  final DocumentModel salaryCertificateDocument;
  final DocumentModel bankStatementDocument;
  final DocumentModel etihadBureauDocument;
  final DocumentModel tradeLicenseDocument;
  final DocumentModel fourVATPaymentsDocument;
  final String nationalityType;
  final String propertyType;
  final String propertyLocation;
  final String propertyCondition;
  final List emirates;
  final List nationalities;
  final List conditions;
  final List properties;

  MortgageState copyWith({
    String? applicantType,
    String? mobileCountryCode,
    double? propertyPrice,
    double? advancePayment,
    double? loanAmount,
    double? interestRate,
    int? propertyPeriod,
    String? calculatorType,
    DocumentModel? passportDocument,
    DocumentModel? emiratesIdDocument,
    DocumentModel? salaryCertificateDocument,
    DocumentModel? bankStatementDocument,
    DocumentModel? etihadBureauDocument,
    DocumentModel? tradeLicenseDocument,
    DocumentModel? fourVATPaymentsDocument,
    String? nationalityType,
    String? propertyType,
    String? propertyLocation,
    String? propertyCondition,
    List? emirates,
    List? nationalities,
    List? conditions,
    List? properties,
  }) {
    return MortgageState(
      appLoadingController: appLoadingController,
      priceInputController: priceInputController,
      advanceInputController: advanceInputController,
      loanInputController: loanInputController,
      yearsInputController: yearsInputController,
      interestInputController: interestInputController,
      priceInputFocusNode: priceInputFocusNode,
      advanceInputFocusNode: advanceInputFocusNode,
      loanInputFocusNode: loanInputFocusNode,
      yearsInputFocusNode: yearsInputFocusNode,
      interestInputFocusNode: interestInputFocusNode,
      personalNameController: personalNameController,
      personalPhoneNumberController: personalPhoneNumberController,
      personalEmailController: personalEmailController,
      passportDocument: passportDocument ?? this.passportDocument,
      emiratesIdDocument: emiratesIdDocument ?? this.emiratesIdDocument,
      salaryCertificateDocument:
          salaryCertificateDocument ?? this.salaryCertificateDocument,
      bankStatementDocument:
          bankStatementDocument ?? this.bankStatementDocument,
      etihadBureauDocument:
          etihadBureauDocument ?? this.etihadBureauDocument,
      tradeLicenseDocument:
          tradeLicenseDocument ?? this.tradeLicenseDocument,
      fourVATPaymentsDocument:
          fourVATPaymentsDocument ?? this.fourVATPaymentsDocument,
      applicantType: applicantType ?? this.applicantType,
      mobileCountryCode: mobileCountryCode ?? this.mobileCountryCode,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      advancePayment: advancePayment ?? this.advancePayment,
      loanAmount: loanAmount ?? this.loanAmount,
      interestRate: interestRate ?? this.interestRate,
      propertyPeriod: propertyPeriod ?? this.propertyPeriod,
      calculatorType: calculatorType ?? this.calculatorType,
      nationalityType: nationalityType ?? this.nationalityType,
      propertyType: propertyType ?? this.propertyType,
      propertyLocation: propertyLocation ?? this.propertyLocation,
      propertyCondition: propertyCondition ?? this.propertyCondition,
      emirates: emirates ?? this.emirates,
      nationalities: nationalities ?? this.nationalities,
      conditions: conditions ?? this.conditions,
      properties: properties ?? this.properties,
    );
  }
}

class MortgageController extends StateNotifier<MortgageState> {
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

  MortgageController(this.ref)
    : super(
        MortgageState(
          appLoadingController: AppLoadingController(),
          priceInputController: TextEditingController(),
          advanceInputController: TextEditingController(),
          loanInputController: TextEditingController(),
          yearsInputController: TextEditingController(),
          interestInputController: TextEditingController(),
          priceInputFocusNode: FocusNode(),
          advanceInputFocusNode: FocusNode(),
          loanInputFocusNode: FocusNode(),
          yearsInputFocusNode: FocusNode(),
          interestInputFocusNode: FocusNode(),
          personalNameController: TextEditingController(),
          personalPhoneNumberController: TextEditingController(),
          personalEmailController: TextEditingController(),
          passportDocument: DocumentModel(),
          emiratesIdDocument: DocumentModel(),
          salaryCertificateDocument: DocumentModel(),
          bankStatementDocument: DocumentModel(),
          etihadBureauDocument: DocumentModel(),
          tradeLicenseDocument: DocumentModel(),
          fourVATPaymentsDocument: DocumentModel(),
        ),
      ) {
    resetMortgageDefaults();
    calculateEMI();
  }

  final Ref ref;
  String get applicantType => state.applicantType;
  set applicantType(String value) => state = state.copyWith(applicantType: value);
  String get mobileCountryCode => state.mobileCountryCode;
  set mobileCountryCode(String value) =>
      state = state.copyWith(mobileCountryCode: value);
  double get propertyPrice => state.propertyPrice;
  set propertyPrice(double value) =>
      state = state.copyWith(propertyPrice: value);
  double get advancePayment => state.advancePayment;
  set advancePayment(double value) =>
      state = state.copyWith(advancePayment: value);
  double get loanAmount => state.loanAmount;
  set loanAmount(double value) => state = state.copyWith(loanAmount: value);
  double get interestRate => state.interestRate;
  set interestRate(double value) => state = state.copyWith(interestRate: value);
  int get propertyPeriod => state.propertyPeriod;
  set propertyPeriod(int value) =>
      state = state.copyWith(propertyPeriod: value);
  String get calculatorType => state.calculatorType;
  set calculatorType(String value) =>
      state = state.copyWith(calculatorType: value);
  TextEditingController get priceInputController => state.priceInputController;
  TextEditingController get advanceInputController =>
      state.advanceInputController;
  TextEditingController get loanInputController => state.loanInputController;
  TextEditingController get yearsInputController => state.yearsInputController;
  TextEditingController get interestInputController =>
      state.interestInputController;
  FocusNode get priceInputFocusNode => state.priceInputFocusNode;
  FocusNode get advanceInputFocusNode => state.advanceInputFocusNode;
  FocusNode get loanInputFocusNode => state.loanInputFocusNode;
  FocusNode get yearsInputFocusNode => state.yearsInputFocusNode;
  FocusNode get interestInputFocusNode => state.interestInputFocusNode;
  // Legacy calculator state (kept for reference).
  // RxDouble propertyPrice = 8000000.0.obs;
  // RxDouble advancePayment = 26.0.obs;
  // RxDouble interestRate = 4.5.obs;
  // RxInt propertyPeriod = 15.obs;
  // RxDouble advancePercentage = 0.2.obs;
  // RxString advance = "20%".obs;
  // RxString calculatorType = "UAE National".obs;
  AppLoadingController get appLoadingController => state.appLoadingController;
  TextEditingController get personalNameController =>
      state.personalNameController;
  TextEditingController get personalPhoneNumberController =>
      state.personalPhoneNumberController;
  TextEditingController get personalEmailController =>
      state.personalEmailController;

  DocumentModel get passportDocument => state.passportDocument;
  set passportDocument(DocumentModel value) =>
      state = state.copyWith(passportDocument: value);
  DocumentModel get emiratesIdDocument => state.emiratesIdDocument;
  set emiratesIdDocument(DocumentModel value) =>
      state = state.copyWith(emiratesIdDocument: value);
  DocumentModel get salaryCertificateDocument =>
      state.salaryCertificateDocument;
  set salaryCertificateDocument(DocumentModel value) =>
      state = state.copyWith(salaryCertificateDocument: value);
  DocumentModel get bankStatementDocument => state.bankStatementDocument;
  set bankStatementDocument(DocumentModel value) =>
      state = state.copyWith(bankStatementDocument: value);
  DocumentModel get etihadBureauDocument => state.etihadBureauDocument;
  set etihadBureauDocument(DocumentModel value) =>
      state = state.copyWith(etihadBureauDocument: value);
  DocumentModel get tradeLicenseDocument => state.tradeLicenseDocument;
  set tradeLicenseDocument(DocumentModel value) =>
      state = state.copyWith(tradeLicenseDocument: value);
  DocumentModel get fourVATPaymentsDocument => state.fourVATPaymentsDocument;
  set fourVATPaymentsDocument(DocumentModel value) =>
      state = state.copyWith(fourVATPaymentsDocument: value);

  String get nationalityType => state.nationalityType;
  set nationalityType(String value) =>
      state = state.copyWith(nationalityType: value);
  String get propertyType => state.propertyType;
  set propertyType(String value) =>
      state = state.copyWith(propertyType: value);
  String get propertyLocation => state.propertyLocation;
  set propertyLocation(String value) =>
      state = state.copyWith(propertyLocation: value);
  String get propertyCondition => state.propertyCondition;
  set propertyCondition(String value) =>
      state = state.copyWith(propertyCondition: value);
  List get emirates => state.emirates;
  List get nationalities => state.nationalities;
  List get conditions => state.conditions;
  List get properties => state.properties;

  bool get isNonResident => calculatorType == calculatorNonResident;

  double get advanceMin =>
      propertyPrice *
      (isNonResident ? advanceMinPercentNonResident : advanceMinPercent);

  double get advanceMax => propertyPrice * advanceMaxPercent;

  double get loanMin => propertyPrice * loanMinPercent;

  double get loanMax =>
      propertyPrice *
      (isNonResident ? loanMaxPercentNonResident : loanMaxPercent);

  void resetMortgageDefaults() {
    propertyPrice = mortgageDefaultPrice;
    propertyPeriod = mortgageDefaultYears;
    interestRate = mortgageDefaultInterest;
    advancePayment = mortgageDefaultAdvance;
    loanAmount = mortgageDefaultLoan;
    _syncMortgageAmounts();
  }

  void setCalculatorType(String type) {
    calculatorType = type;
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
    propertyPrice = value;
    _syncMortgageAmounts();
    // Legacy logic (percentage based).
    // advancePayment.value =
    //     advancePercentage.value * propertyPrice.value;
  }

  void updateAdvancePayment(double value) {
    final double newAdvance = _clampDouble(value, advanceMin, advanceMax);
    advancePayment = newAdvance;
    loanAmount = propertyPrice - newAdvance;
  }

  void updateLoanAmount(double value) {
    final double newLoan = _clampDouble(value, loanMin, loanMax);
    loanAmount = newLoan;
    advancePayment = propertyPrice - newLoan;
  }

  void _syncMortgageAmounts() {
    final double minAdvance = advanceMin;
    final double maxAdvance = advanceMax;
    final double minLoan = loanMin;
    final double maxLoan = loanMax;

    double newAdvance = _clampDouble(
      advancePayment,
      minAdvance,
      maxAdvance,
    );
    double newLoan = propertyPrice - newAdvance;
    newLoan = _clampDouble(newLoan, minLoan, maxLoan);
    newAdvance = propertyPrice - newLoan;

    state = state.copyWith(advancePayment: newAdvance, loanAmount: newLoan);
  }

  double _clampDouble(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
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
        goToLoginScreen(ref.read);
        await updateData(ref.read);
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

    mortgageLoanData["client"] = ref.read(authManagerProvider).appUser?.id;

    mortgageLoanData["product"] = "Mortgage Loan";

    mortgageLoanData["description"] =
        "Loan Amount: $propertyPrice, Payment Period: $propertyPeriod Years, Name: ${personalNameController.text}, Nationality: $nationalityType, Phone: ${mobileCountryCode.startsWith("+") ? "" : "+"}$mobileCountryCode${personalPhoneNumberController.text}, Email: ${personalEmailController.text}, Property Type: $propertyType, Property Location: $propertyLocation, Property Condition: $propertyCondition";

    List<DocumentModel> documents = [
      passportDocument,
      emiratesIdDocument,
      salaryCertificateDocument,
      bankStatementDocument,
      etihadBureauDocument,
      tradeLicenseDocument,
      fourVATPaymentsDocument,
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
    double principal = loanAmount;
    double monthlyRate = interestRate / 12 / 100;
    int totalMonths = propertyPeriod * 12;
    if (kDebugMode) {
      print(advancePayment);
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
        passportDocument.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        photoCopy = await pickPdf();
        passportDocument.filePath = getDocument(photoCopy);
        initPassportDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        passportDocument.filePath = getImage(image);
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
        tradeLicenseDocument.filePath = getDocument(photoCopy);
        if (kDebugMode) print(tradeLicenseDocument.filePath);
        initTradeLicenseDocument();
      },
      () async {
        photoCopy = await pickPdf();
        tradeLicenseDocument.filePath = getDocument(photoCopy);
        initTradeLicenseDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        tradeLicenseDocument.filePath = getImage(image);
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
        emiratesIdDocument.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        photoCopy = await pickPdf();
        emiratesIdDocument.filePath = getDocument(photoCopy);
        initEmiratesIdDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        emiratesIdDocument.filePath = getImage(image);
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
        salaryCertificateDocument.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        photoCopy = await pickPdf();
        salaryCertificateDocument.filePath = getDocument(photoCopy);
        initSalaryDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        salaryCertificateDocument.filePath = getImage(image);
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
        bankStatementDocument.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        photoCopy = await pickPdf();
        bankStatementDocument.filePath = getDocument(photoCopy);
        initBankStatementDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        bankStatementDocument.filePath = getImage(image);
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
        etihadBureauDocument.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        photoCopy = await pickPdf();
        etihadBureauDocument.filePath = getDocument(photoCopy);
        initEtihadDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        etihadBureauDocument.filePath = getImage(image);
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
        fourVATPaymentsDocument.filePath = getDocument(photoCopy);
        initVATDocument();
      },
      () async {
        photoCopy = await pickPdf();
        fourVATPaymentsDocument.filePath = getDocument(photoCopy);
        initVATDocument();
      },
      () async {
        final XFile? image = await pickfromCamera();
        fourVATPaymentsDocument.filePath = getImage(image);
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
    AppNavigator.pop();
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  pickfromGallery() async {
    AppNavigator.pop();
    return await FilePicker.platform.pickFiles(type: FileType.image);
  }

  pickfromCamera() async {
    AppNavigator.pop();
    return ImagePicker().pickImage(source: ImageSource.camera);
  }

  initPassportDocument() {
    if (passportDocument.fileName != "") {
      passportDocument.fileName =
          "passport.${passportDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(passportDocument: passportDocument);
  }

  initEmiratesIdDocument() {
    if (emiratesIdDocument.fileName != "") {
      emiratesIdDocument.fileName =
          "emiratesId.${emiratesIdDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(emiratesIdDocument: emiratesIdDocument);
  }

  initTradeLicenseDocument() {
    if (tradeLicenseDocument.fileName != "") {
      tradeLicenseDocument.fileName =
          "trade_license.${tradeLicenseDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(tradeLicenseDocument: tradeLicenseDocument);
  }

  initSalaryDocument() {
    if (salaryCertificateDocument.fileName != "") {
      salaryCertificateDocument.fileName =
          "salary_certificate.${salaryCertificateDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(salaryCertificateDocument: salaryCertificateDocument);
  }

  initBankStatementDocument() {
    if (bankStatementDocument.fileName != "") {
      bankStatementDocument.fileName =
          "bank_statement.${bankStatementDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(bankStatementDocument: bankStatementDocument);
  }

  initEtihadDocument() {
    if (etihadBureauDocument.fileName != "") {
      etihadBureauDocument.fileName =
          "etihad_bureau.${etihadBureauDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(etihadBureauDocument: etihadBureauDocument);
  }

  initVATDocument() {
    if (fourVATPaymentsDocument.fileName != "") {
      fourVATPaymentsDocument.fileName =
          "VAT_payments.${fourVATPaymentsDocument.filePath?.split('.').last}";
    }
    state = state.copyWith(fourVATPaymentsDocument: fourVATPaymentsDocument);
  }

  @override
  void dispose() {
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
    appLoadingController.dispose();
    personalNameController.dispose();
    personalPhoneNumberController.dispose();
    personalEmailController.dispose();
    super.dispose();
  }
}

final mortgageControllerProvider =
    StateNotifierProvider<MortgageController, MortgageState>((ref) {
      return MortgageController(ref);
    });
