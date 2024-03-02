class UserLoginModel {
  UserLoginModel({
    required this.username,
    required this.password,
    required this.expiresInMins,
  });

  String username;
  String password;
  String expiresInMins;

  Map<String, String> toJson() => <String, String>{
        'username': username,
        'password': password,
        'expiresInMins': expiresInMins,
      };
}
