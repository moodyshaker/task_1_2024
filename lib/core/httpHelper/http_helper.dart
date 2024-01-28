import 'package:http/http.dart';
import 'header_config.dart';



class HttpHelper {
  final String base_url = 'https://jsonplaceholder.typicode.com/';

  static final HttpHelper instance = HttpHelper._instance();

  HttpHelper._instance();

  Future<Response> httpGet(String path) async {
    final Response r = await get(Uri.parse('$base_url$path'),
        headers:  await HeaderConfig.getHeader());
    return r;
  }

}
