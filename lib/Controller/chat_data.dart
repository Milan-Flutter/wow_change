import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<http.Response> getChatData() {
    var url = Uri.parse("https://mechodalgroup.xyz/whoclone/api/get_chat.php");
    var uid = 'your_uid';

    return http.post(url, body: {'id': uid});
  }
}
class HostLive {
  final String name;
  final String id;
  final String f_id;
  final String photo;
  final String email;

  HostLive({
    required this.name,
    required this.id,
    required this.f_id,
    required this.photo,
    required this.email,
  });

  factory HostLive.fromJson(Map<String, dynamic> json) {
    return HostLive(
      name: json['name'].toString(),
      id: json['id'].toString(),
      f_id: json['f_id'].toString(),
      photo: json['photo_url'].toString(),
      email: json['email'].toString(),
    );
  }
}
class HostController extends GetxController {
  RxList<HostLive> hosts = <HostLive>[].obs;

  void addHost(HostLive host) {
    hosts.add(host);
  }
}