/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wow/Controller/profile_data.dart';

class folower extends GetxController
{
  RxList<HostLive> hosts = <HostLive>[].obs;
  RxList<HostLive> filteredHosts = <HostLive>[].obs;
  profile_data controller=Get.put(profile_data());
  RxBool isloding=false.obs;
  Future<void> plan1() async
  {

    var response = await post(
        Uri.parse(
            "https://mechodalgroup.xyz/whoclone/api/get_following_id.php"),
        body: {'id': controller.uid.toString()});
    if (response.statusCode == 200) {

      var planres = json.decode(response.body);
      print(planres.toString());
      print("dhjbadgmsdg" + planres['records'].length.toString());
      if (planres['records'].length == 1) {
        isloding.value = true;
      }
      for (int i = 0; i < planres['records'].length; i++) {
        HostLive host = HostLive(
          name: planres['records'][i]['name'].toString(),
          id: planres['records'][i]['id'].toString(),
          photo: planres['records'][i]['photo_url'].toString(),
        );
        hosts.add(host);
        print("yagugo8t");
        print(hosts.toString());
      }
      filteredHosts.value=hosts;


    }
  }
  void filterHosts(String searchTerm)
  {

    filteredHosts.value = hosts
        .where((host) =>
        host.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

  }

}

class HostLive {
  final String name;
  final String id;
  final String photo;

  HostLive({required this.name, required this.id, required this.photo});
}*/
