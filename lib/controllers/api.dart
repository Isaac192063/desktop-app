import 'package:desktop_app/api/User.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<User>> getData() async {
    Uri url = Uri.http("localhost:4000", "/user");

    final response = await http.get(url);

    final user = usersFromJson(response.body);

    return user;
  }
}
