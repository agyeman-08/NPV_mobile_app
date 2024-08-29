import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> serverDetect(
  String imagePath,
  double x,
  double y,
  double w,
  double h,
) async {
  final url = Uri.parse('https://vercel-server-inference.vercel.app/detect');
  final request = http.MultipartRequest('POST', url);

  request.files.add(await http.MultipartFile.fromPath('image', imagePath));
  // Add x, y, w, h as fields in the request body
  request.fields['x'] = x.toString();
  request.fields['y'] = y.toString();
  request.fields['w'] = w.toString();
  request.fields['h'] = h.toString();

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return jsonResponse;
    } else {
      print('Failed to get inference. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending request: $e');
  }
}
