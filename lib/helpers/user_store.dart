class UserStore {
  static final UserStore _instance = UserStore._internal();

  factory UserStore() => _instance;

  UserStore._internal();

  String? phoneNumber;
  String? password;

  bool isSignedUp() => phoneNumber != null && password != null;

  bool isValidUser(String phone, String pass) {
    return phone == phoneNumber && pass == password;
  }

  void register(String phone, String pass) {
    phoneNumber = phone;
    password = pass;
  }
}
