bool isValidEmailFahmi(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isValidPasswordFahmi(String password) {
  return password.length >= 6;
}
