class AppUser {
  String? id;
  String? name;
  String? email;
  String? picture;
  String? phone;
  String? countryCode;
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
    this.countryCode,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phoneNumber'];
    countryCode = json['countryCode'];
    role = json['role'];
    picture = json['picture'] ?? "";
    token = json['token'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['gender'];
  }
}
