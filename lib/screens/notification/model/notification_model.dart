class NotificationModel {
  String? title;
  String? id;
  String? recipient;
  Map<String, dynamic>? data;
  String? body;
  bool? isRead;
  String? createdAt;

  NotificationModel({
    this.title,
    this.data,
    this.body,
    this.createdAt,
    this.id,
    this.isRead,
    this.recipient,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    body = json['body'] ?? '';
    recipient = json['recipient'] ?? '';
    id = json['_id'] ?? '';
    isRead = json['isRead'] ?? true;
    createdAt = json['createdAt'] ?? '';
    data = json["data"] ?? {};
  }
}
