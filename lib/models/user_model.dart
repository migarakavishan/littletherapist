class UserModel {
  String name;
  String image;
  String email;
  String uid;
  int puzzleScore;
  int outliningScore;
  int languageScore;
  int mathScore;

  UserModel(
      {required this.name,
      required this.image,
      required this.email,
      required this.uid,
      this.puzzleScore = 0,
      this.outliningScore = 0,
      this.languageScore = 0,
      this.mathScore = 0});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      image: json['image'],
      email: json['email'],
      uid: json['uid'],
      puzzleScore: json['score']['puzzleScore'] ?? 0,
      outliningScore: json['score']['outliningScore'] ?? 0,
      languageScore: json['score']['languageScore'] ?? 0,
      mathScore: json['score']['mathScore'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "image": image,
      "score": {
        "puzzleScore": puzzleScore,
        "outliningScore": outliningScore,
        "languageScore": languageScore,
        "mathScore": mathScore,
      },
    };
  }
}
