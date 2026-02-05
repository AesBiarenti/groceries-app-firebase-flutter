/// Input validators (email, Turkish phone +90).
abstract class Validators {
  Validators._();

  static const String phoneCountryCode = '+90';
  static const int turkishMobileLength = 10;

  /// Turkish mobile: 5XX XXX XX XX (10 digits, starts with 5). Accepts with or without +90.
  static String? turkishPhone(String? value) {
    if (value == null || value.isEmpty) return 'Telefon numarası gerekli';
    var digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('90') && digits.length == 12) digits = digits.substring(2);
    if (digits.length != turkishMobileLength) {
      return 'Geçerli bir 10 haneli numara girin (5XX XXX XX XX)';
    }
    if (!digits.startsWith('5')) {
      return 'Cep numarası 5 ile başlamalı';
    }
    return null;
  }

  /// Email format.
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'E-posta gerekli';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) return 'Geçerli bir e-posta girin';
    return null;
  }

  /// Required field.
  static String? required(String? value, [String fieldName = 'Bu alan']) {
    if (value == null || value.trim().isEmpty) return '$fieldName gerekli';
    return null;
  }

  /// Min length (e.g. password).
  static String? minLength(String? value, int min, [String fieldName = 'Bu alan']) {
    if (value == null) return '$fieldName gerekli';
    if (value.length < min) return '$fieldName en az $min karakter olmalı';
    return null;
  }
}
