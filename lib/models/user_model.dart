class UserModel {
  String name;
  String image;
  String email;
  String uid;

  UserModel(
      {required this.name,
      required this.image,
      required this.email,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        image: json['image'],
        email: json['email'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "image": image,
    };
  }
}
