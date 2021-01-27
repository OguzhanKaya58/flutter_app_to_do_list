class ValidationMixin {
  String validateTextInput(String value) {
    if (value.length < 3) {
      return "Lütfen en az üç karakter giriniz.";
    }
    return null;
  }
}
