class TextHelper {
  static toSafeString(String value) {
    if (value == null) {
      return '[NULL]';
    }
    if (value.isEmpty) {
      return '[EMPTY]';
    }
    return value;
  }
}
