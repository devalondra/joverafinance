import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/chat_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/provider/chat_provider.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/widgets/document_picker_widget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:dio/dio.dart' as mp;
import 'package:http_parser/http_parser.dart';

class ChatController extends GetxController {
  late Socket socket;
  RxList<ChatModel> messages = <ChatModel>[].obs;
  NotificationService notificationService = Get.find();
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxBool socketInitialized = false.obs;
  ScrollController scrollController = ScrollController();
  RxString selectedFilePath = ''.obs;
  final userId = Get.find<AuthManager>().appUser.value.id;
  AppLoadingController appLoadingController = AppLoadingController();
  @override
  void onInit() async {
    await getAllMessages();
    if (notificationService.IsSocketInitialized) {
      socketInitialized.value = notificationService.IsSocketInitialized;

      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }
    super.onInit();
  }

  Future<void> getAllMessages() async {
    appLoadingController.loading();
    ChatProvider().getAllMessages(
      onSuccess: (response) async {
        appLoadingController.stop();
        if (response.data != null) {
          messages.value = RxList<ChatModel>.from(
            json
                .decode(json.encode(response.data['messages']))
                .map((x) => ChatModel.fromJson(x)),
          );
          messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          messages.refresh();
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
        Get.back();
        doc = await FilePicker.platform.pickFiles(type: FileType.image);

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          selectedFilePath.value = file.path;
        } else {}
      },

      () async {
        Get.back();
        doc = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (doc != null) {
          File file = File(doc!.files.single.path!);
          debugPrint("*****************************************");
          selectedFilePath.value = file.path;
        } else {}
      },
      () async {
        Get.back();

        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        if (image != null) {
          File file = File(image.path);
          selectedFilePath.value = file.path;
        } else {}
      },
    );
  }

  Future<Map<String, dynamic>> getProfileFormData() async {
    Map<String, dynamic> profileFormData = {};

    if (textController.value.text.isNotEmpty)
      profileFormData["content"] = textController.value.text;

    if (selectedFilePath.isNotEmpty) {
      String ext = selectedFilePath.value.split('.').last.toLowerCase();
      profileFormData["file"] = await mp.MultipartFile.fromFile(
        selectedFilePath.value,
        contentType: MediaType(
          ext == 'pdf' ? 'application' : 'image',
          ext == 'jpg' ? 'jpeg' : ext,
      
        ),
        filename: "file_${selectedFilePath.value.split('/').last}",
      );
    }

    return profileFormData;
  }

  void setupListeners() {
    notificationService.socket.off('receive_message');
    notificationService.socket.on('receive_message', (data) {
      if (Get.find<BottomNavigationBarController>().selectedIndex.value == 3) {
        ChatModel messageModel = ChatModel(
          content: data["content"] ?? "",
          senderId: data["senderId"] ?? "",
          senderName: data["senderName"] ?? "",
          picture: data["senderImage"] ?? "",
          createdAt: data["createdAt"] ?? "",

          fileUrl: data["fileUrl"] ?? "",
        );

        messages.add(messageModel);
        messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        messages.refresh();
        scrollToBottom();
      } else {
        Get.snackbar(
          "Message",
          data["content"],

          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          backgroundColor: AppColors.black2,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () {
              Get.find<BottomNavigationBarController>().selectedIndex.value = 3;

              ChatModel messageModel = ChatModel(
                content: data["content"] ?? "",
                senderId: data["senderId"] ?? "",
                senderName: data["senderName"] ?? "",
                picture: data["senderImage"] ?? "",
                createdAt: data["createdAt"] ?? "",

                fileUrl: data["fileUrl"] ?? "",
              );

              messages.add(messageModel);
              messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
              messages.refresh();
              scrollToBottom();
            },
            child: Text("View", style: TextStyle(color: Colors.white)),
          ),
        );
      }
    });
  }

  Future<void> sendMessage() async {
    Map<String, dynamic> resultMap = await getProfileFormData();
    if (resultMap.isEmpty) return;
    textController.value.clear();
    selectedFilePath.value = "";
    ChatProvider().sendMessage(
      data: mp.FormData.fromMap(resultMap),

      onSuccess: (response) async {
        appLoadingController.stop();
        ChatModel chat = ChatModel.fromJson(response.data['messages']);
        messages.add(chat);
        messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        messages.refresh();
        scrollToBottom();
       
      },
      onError: (error) {
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              "Something went wrong white loading old messages",
        );
      },
    );
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


  @override
  void onReady() {
    if (notificationService.IsSocketInitialized) {
      socketInitialized.value = notificationService.IsSocketInitialized;
      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }
    super.onReady();
  }

  void printSocket() {
    if (notificationService.IsSocketInitialized) {
      socketInitialized.value = notificationService.IsSocketInitialized;
      debugPrint("££££££££ socket connected");
      socket = notificationService.socketInstance;
      setupListeners();
      debugPrint('✅ ChatController using existing socket');
    } else {
      debugPrint('❌ Socket not initialized yet');
    }
  }
}
