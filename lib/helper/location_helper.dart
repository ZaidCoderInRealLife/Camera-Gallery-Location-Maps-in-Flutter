import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = "AIzaSyCM7c6dKqWr2F8Twc8GU8DgdXvE_cxtTGQ";

class LocaationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&${latitude as double},${longitude as double}&=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${latitude as double},${longitude as double}&key=$GOOGLE_API_KEY";
  }

  static Future getPlaceAddress(double lat, double lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)["results"][0]['formatted_address'];
  }
}
