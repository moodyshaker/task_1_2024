
class HeaderConfig {
  static Future<Map<String, String>> getHeader() async {
    var header = {
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return header;
  }
}
