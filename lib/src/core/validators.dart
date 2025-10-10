class Validators {
  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password required';
    if (v.length < 8) return 'Minimum 8 characters';
    return null;
  }


  static String? email(String? v) {
    if (v == null || v.isEmpty) return 'Email required';
    final pattern = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$");
    if (!pattern.hasMatch(v)) return 'Invalid email';
    return null;
  }
}