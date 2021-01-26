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

  static getDefaultGuidString() {
    return '00000000-0000-0000-0000-000000000000';
  }
}
