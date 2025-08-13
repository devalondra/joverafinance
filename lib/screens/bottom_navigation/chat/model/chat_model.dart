class ChatModel {
  String? id;
  String? senderId;
  String? senderName;
  String? picture;
  String? content;
  bool? isRead;
  String? createdAt;
  String? fileUrl;
  ChatModel({
    this.content,
    this.createdAt,
    this.id,
    this.isRead,
    this.picture,
    this.senderId,
    this.senderName,
    this.fileUrl,
  });
  ChatModel.fromJson(json) {
    content = json["content"] ?? "";
    createdAt = json["createdAt"] ?? "";
    id = json["_id"] ?? "";
    fileUrl = json["file"] == null ? "" : json["file"]["path"];
    isRead = json["isRead"] ?? "";
    picture = json["sender"]["picture"] ?? "";
    senderId = json["sender"]["_id"] ?? "";
    senderName = json["sender"]["name"] ?? "";
  }
}
