// lib/utils/validators.dart

bool isValidEmailFahmi(String email) {
  // Validasi format email sederhana
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isValidPasswordFahmi(String password) {
  // Minimal 6 karakter
  return password.length >= 6;
}
