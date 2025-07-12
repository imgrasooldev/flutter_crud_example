class UserModel {
  final String name;
  final String token;
  UserModel({required this.name, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(name: json['name'], token: json['token']);
}
