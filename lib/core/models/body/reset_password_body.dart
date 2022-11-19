class ResetPasswordBody {
  String? password;
  String? password_confirmation;

  ResetPasswordBody({this.password, this.password_confirmation});

  toJson() => {
        'password': password,
        'password_confirmation': password_confirmation,
      };
}
