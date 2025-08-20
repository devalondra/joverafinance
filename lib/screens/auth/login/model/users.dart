class AppUser {
  String? id;
  String? name;
  String? email;
  String? picture;
  String? phone;
  String? whatsapp;

  String? role;
  String? token;
  String? dateOfBirth;
  String? gender;

  AppUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.picture,
    this.token,
    this.dateOfBirth,
    this.gender,
    this.whatsapp,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    whatsapp = json['w_phone'];

    picture = json['picture'] ?? "";
    token = json['token'];
  }
}
