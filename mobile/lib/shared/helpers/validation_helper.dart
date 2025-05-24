class ValidationHelper {
  static String? EnsureStringNotEmpty(String? value, {String? errorMessage}) {
    final message = errorMessage ?? "Value cannot be empty";
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? EnsurePositiveNumber(String? value, {String? errorMessage}) {
    final message = errorMessage ?? "Value must be a positive number";

    if (value == null) {
      return message;
    }

    var parsed = double.tryParse(value);

    if (parsed == null || parsed <= 0) {
      return message;
    }
    return null;
  }
}
