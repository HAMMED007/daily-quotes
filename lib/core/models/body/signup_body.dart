class SignUpBody {
  String? email;
  String? password;

  SignUpBody({
    this.email,
    this.password,
  });

  toJson() async {
    return {
      'email': email,
      'password': password,

      // 'fcm_token': this.fcmToken,
    };
  }
}
