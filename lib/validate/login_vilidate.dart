class LoginValidation {
  String? validateEmail(String? value) {
    if ( value != null && !(value.contains('@hotmail.com') ||
        value.contains('@gmail.com') ||
        value.contains('@outlook.com') ||
        value.contains('@icloud.com') ||
        value.contains('@example.com') ||
        value.contains('@yahoo.com') ||
        value.contains('@aol.com'))) {
      return "Geçersiz e-posta";
    }
  }

  String? validatePassword(String? value) {
    if (value != null && value.length < 8) {
      return "Şifre en az 8 karekter olmalıdır";
    }
  }
}