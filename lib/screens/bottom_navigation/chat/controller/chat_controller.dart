import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as mp;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/chat_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/my_lead.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/provider/chat_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/model/visa_application_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/provider/dashboard_provider.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/navigation/app_messenger.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class ChatState {
  const ChatState({
    required this.textController,
    required this.scrollController,
    required this.appLoadingController,
    this.socket,
    this.notificationService,
    this.messages = const <ChatModel>[],
    this.socketInitialized = false,
    this.fileBytes,
    this.leads = const <MyLead>[],
    this.selectedLead,
    this.selectedFilePath = '',
    this.uploadedFileUrl = '',
  });

  final Socket? socket;
  final NotificationService? notificationService;
  final List<ChatModel> messages;
  final TextEditingController textController;
  final bool socketInitialized;
  final Uint8List? fileBytes;
  final List<MyLead> leads;
  final MyLead? selectedLead;
  final ScrollController scrollController;
  final String selectedFilePath;
  final String uploadedFileUrl;
  final AppLoadingController appLoadingController;

  ChatState copyWith({
    Socket? socket,
    NotificationService? notificationService,
    List<ChatModel>? messages,
    bool? socketInitialized,
    Uint8List? fileBytes,
    List<MyLead>? leads,
    MyLead? selectedLead,
    String? selectedFilePath,
    String? uploadedFileUrl,
  }) {
    return ChatState(
      socket: socket ?? this.socket,
      notificationService: notificationService ?? this.notificationService,
      messages: messages ?? this.messages,
      textController: textController,
      socketInitialized: socketInitialized ?? this.socketInitialized,
      fileBytes: fileBytes ?? this.fileBytes,
      leads: leads ?? this.leads,
      selectedLead: selectedLead ?? this.selectedLead,
      scrollController: scrollController,
      selectedFilePath: selectedFilePath ?? this.selectedFilePath,
      uploadedFileUrl: uploadedFileUrl ?? this.uploadedFileUrl,
      appLoadingController: appLoadingController,
    );
  }
}

class ChatController extends StateNotifier<ChatState> {
  ChatController(this.ref)
    : super(
        ChatState(
          textController: TextEditingController(),
          scrollController: ScrollController(),
          appLoadingController: AppLoadingController(),
        ),
      ) {
    _init();
  }

  final Ref ref;
  Socket? get socket => state.socket;
  set socket(Socket? value) => state = state.copyWith(socket: value);
  NotificationService get notificationService =>
      state.notificationService ?? ref.read(notificationServiceProvider);
  List<ChatModel> get messages => state.messages;
  set messages(List<ChatModel> value) =>
      state = state.copyWith(messages: value);
  TextEditingController get textController => state.textController;
  bool get socketInitialized => state.socketInitialized;
  set socketInitialized(bool value) =>
      state = state.copyWith(socketInitialized: value);
  Uint8List? get fileBytes => state.fileBytes;
  set fileBytes(Uint8List? value) => state = state.copyWith(fileBytes: value);
  List<MyLead> get leads => state.leads;
  set leads(List<MyLead> value) => state = state.copyWith(leads: value);
  MyLead? get selectedLead => state.selectedLead;
  set selectedLead(MyLead? value) =>
      state = state.copyWith(selectedLead: value);
  ScrollController get scrollController => state.scrollController;
  String get selectedFilePath => state.selectedFilePath;
  set selectedFilePath(String value) =>
      state = state.copyWith(selectedFilePath: value);
  String get uploadedFileUrl => state.uploadedFileUrl;
  set uploadedFileUrl(String value) =>
      state = state.copyWith(uploadedFileUrl: value);
  AppLoadingController get appLoadingController =>
      state.appLoadingController;
  String? get userId => ref.read(authManagerProvider.notifier).currentUser.id;

  Future<void> _init() async {
    state = state.copyWith(
      notificationService: ref.read(notificationServiceProvider),
    );
    await getAllMessages();
    await getLeads();
    if (notificationService.isSocketInitialized) {
      socketInitialized = notificationService.isSocketInitialized;
      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }
  }

  ChatModel? get sender =>
      messages.where((e) => e.recipientModel == "Client").lastOrNull;

  Future<void> getMyApplications() async {
    if (!ref.read(authManagerProvider).isLogged) {
      return;
    }
    appLoadingController.loading();
    DashboardProvider().getMyVisaApplications(
      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null && response.data['leads'].length != 0) {
          final List<VisaApplicationModel> leadsApplications =
              json.decode(json.encode(response.data['leads']))
                  .map<VisaApplicationModel>(
                    (x) => VisaApplicationModel.fromJson(x),
                  )
                  .toList();
          leads =
              leadsApplications
                  .map(
                    (element) => MyLead(
                      leadId: element.id ?? "",
                      leadType: element.typeOfLoan ?? "",
                    ),
                  )
                  .toList();
          if (kDebugMode) print(leadsApplications);
          if (leads.isNotEmpty) {
            selectedLead = leads.first;
          }
          if (kDebugMode) print(leads);
        }
      },
      onError: (error) {
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

  bool get hasSenderImage => (sender?.senderImage ?? "").startsWith("https");

  String _resolveLeadId() {
    final String selectedLeadId = selectedLead?.leadId ?? "";
    if (selectedLeadId.isNotEmpty) {
      return selectedLeadId;
    }
    if (messages.isNotEmpty) {
      final String lastMessageLeadId = messages.last.leadId ?? "";
      if (lastMessageLeadId.isNotEmpty) {
        return lastMessageLeadId;
      }
    }
    if (leads.isNotEmpty) {
      return leads.first.leadId ?? "";
    }
    return "";
  }

  getLeads() async {
    await getMyApplications();
  }

  void setupListeners() {
    notificationService.socket.off('chat:message');
    notificationService.socket.on('chat:message', (data) {
      if (ref.read(bottomNavigationBarControllerProvider.notifier).selectedIndex ==
          3) {
        ChatModel messageModel = ChatModel(
          leadId: data["leadId"] ?? "",
          recipient: data["recipient"] ?? "",
          senderId: data["senderId"] ?? "",
          senderImage: data["senderImage"] ?? "",
          senderName: data["senderName"] ?? "",
          recipientModel: data["recipientModel"] ?? "",
          text: data["text"] ?? "",
          timestamp: data["timestamp"] ?? "",
          id: data["_id"] ?? "",
          status: data["status"] ?? "",
          files: data["files"] ?? "",
          fileUrl: data["fileUrl"] ?? "",
        );

        final List<ChatModel> updatedMessages = <ChatModel>[
          ...messages,
          messageModel,
        ];
        updatedMessages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        messages = updatedMessages;
        scrollToBottom();
      } else {
        AppMessenger.showSnackBar(
          SnackBar(
            content: Text(
              data["text"],
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: AppColors.black2,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: "View",
              textColor: Colors.white,
              onPressed: () {
                ref
                    .read(bottomNavigationBarControllerProvider.notifier)
                    .setIndex(3);
                ChatModel messageModel = ChatModel(
                  leadId: data["leadId"] ?? "",
                  recipient: data["recipient"] ?? "",
                  senderId: data["senderId"] ?? "",
                  senderImage: data["senderImage"] ?? "",
                  senderName: data["senderName"] ?? "",
                  recipientModel: data["recipientModel"] ?? "",
                  text: data["text"] ?? "",
                  timestamp: data["timestamp"] ?? "",
                  id: data["_id"] ?? "",
                  status: data["status"] ?? "",
                  files: data["files"] ?? "",
                  fileUrl: data["fileUrl"] ?? "",
                );

                final List<ChatModel> updatedMessages = <ChatModel>[
                  ...messages,
                  messageModel,
                ];
                updatedMessages.sort(
                  (a, b) => a.timestamp!.compareTo(b.timestamp!),
                );
                messages = updatedMessages;
                scrollToBottom();
              },
            ),
          ),
        );
      }
    });
  }

  Future<void> getAllMessages() async {
    if (!ref.read(authManagerProvider).isLogged) {
      return;
    }

    appLoadingController.loading();
    ChatProvider().getAllMessages(
      onSuccess: (response) async {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null && response.data['messages'].length != 0) {
          final List<ChatModel> fetchedMessages =
              json.decode(json.encode(response.data['messages']))
                  .map<ChatModel>((x) => ChatModel.fromJson(x))
                  .toList();
          fetchedMessages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
          messages = fetchedMessages;
          scrollToBottom();
        }
      },
      onError: (error) {
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              "Something went wrong while loading old messages",
        );
      },
    );
  }

  selectFile(context) {
    FilePickerResult? doc;
    DocumentPicker().documentPickerWidget(
      context,

      () async {
        AppNavigator.pop();
        doc = await FilePicker.platform.pickFiles(type: FileType.image);

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          selectedFilePath = file.path;
          fileBytes = await file.readAsBytes();
        } else {}
      },

      () async {
        AppNavigator.pop();
        doc = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          debugPrint("*****************************************");
          selectedFilePath = file.path;
          fileBytes = await file.readAsBytes();
        } else {}
      },
      () async {
        AppNavigator.pop();

        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        if (image != null) {
          File file = File(image.path);
          selectedFilePath = file.path;
          fileBytes = await file.readAsBytes();
        } else {}
      },
    );
  }

  Future<Map<String, dynamic>> getMessageFile() async {
    Map<String, dynamic> fileData = {};
    if (selectedFilePath.isNotEmpty) {
      String ext = selectedFilePath.split('.').last.toLowerCase();
      fileData["file"] = await mp.MultipartFile.fromFile(
        selectedFilePath,
        contentType: MediaType(
          ext == 'pdf' ? 'application' : 'image',
          ext == 'jpg' ? 'jpeg' : ext,
        ),
        filename: "file_${selectedFilePath.split('/').last}",
      );
    }

    return fileData;
  }

  Future<void> sendFile() async {
    Map<String, dynamic> resultMap = await getMessageFile();
    if (resultMap.isEmpty) return;

    appLoadingController.loading();
    ChatProvider().sendFile(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        appLoadingController.stop();
        selectedFilePath = "";
        fileBytes = null;
        if (kDebugMode) print(response);
        uploadedFileUrl = response.data['fileUrl'] ?? "";
        if (kDebugMode) print(uploadedFileUrl);
        sendMessageViaSocket();
      },
      onError: (error) {
        appLoadingController.stop();
        selectedFilePath = "";
        fileBytes = null;
        uploadedFileUrl = "";
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              "Something went wrong white loading old messages",
        );
      },
    );
  }

  void sendMessageViaSocket() async {
    final String leadId = _resolveLeadId();
    if (leadId.isEmpty) {
      appTools.showErrorSnackBar(
        "Unable to send message. Please select a lead.",
      );
      return;
    }
    if (socket == null) {
      appTools.showErrorSnackBar(
        "Unable to send message. Please try again.",
      );
      return;
    }
    if (uploadedFileUrl != "") {
      final messagePayload = {
        "clientId": userId,
        "leadId": leadId,
        "text": textController.text,

        "fileUrl": uploadedFileUrl,
      };
      socket?.emit("chat:message", messagePayload);
      if (kDebugMode) print(messagePayload);
      textController.clear();
      selectedFilePath = "";
      fileBytes = null;
      uploadedFileUrl = "";
    } else {
      final messagePayload = {
        "clientId": userId,
        //todo remove mandatory leadid
        
        "leadId": leadId,
        "text": textController.text,
      };
      if (kDebugMode) print(messagePayload);
      socket?.emit("chat:message", messagePayload);
      textController.clear();
      selectedFilePath = "";
      fileBytes = null;
      uploadedFileUrl = "";
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void printSocket() {
    if (notificationService.isSocketInitialized) {
      socketInitialized = notificationService.isSocketInitialized;
      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final chatControllerProvider =
    StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController(ref);
});
