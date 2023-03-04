import 'dart:async';

import 'package:get/get.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/model/album_item.dart';
import 'package:tang_music/storage.dart';

import 'http_client.dart';

class ApiController extends GetxController {
  String currAuthKey = '';
  var qrcodeUrl = ''.obs;
  var userId = 0.obs;

  bool get logined => userId.value != 0;

  Future<List<AlbumItemModel>> getRecommandList({bool isLogin = false}) async {
    var res = await httpClient.get("/recommend/resource");

    List result = res.data["recommend"];
    return result.map((e) => AlbumItemModel(id: e['id'], name: e['name'], picUrl: e['picUrl'])).toList();
  }

  Future<List<AlbumItemModel>> getUserAlbumList() async {
    if (userId.value == 0) {
      return [];
    }
    var res = await httpClient.get("/user/playlist?uid=${userId.value}");
    List result = res.data["playlist"];
    return result.map((e) => AlbumItemModel(id: e['id'], name: e['name'], picUrl: e['coverImgUrl'])).toList();
  }

  getUserInfo() async {
    var res = await httpClient.get('/user/account?timerstamp=${DateTime.now()}');
    if (res.data['account']['status'] != 0) {
      getQrcode();
      return;
    }
    userId.value = res.data['account']['id'];
  }

  getQrcode() async {
    var res = await httpClient.get("/login/qr/key?timerstamp=${DateTime.now()}");
    currAuthKey = res.data["data"]["unikey"];

    var res2 = await httpClient.get("/login/qr/create?key=$currAuthKey&timerstamp=${DateTime.now()}");
    qrcodeUrl.value = res2.data['data']['qrurl'];
    print(qrcodeUrl.value);
    _checkScan();
  }

  _checkScan() async {
    Timer(const Duration(seconds: 5), () async {
      var res3 = await httpClient.get("/login/qr/check?key=$currAuthKey&timerstamp=${DateTime.now()}");
      print(res3.data);
      switch (res3.data['code']) {
        case 800:
          getQrcode();
          return;
        case 801:
          return _checkScan();
        case 802:
          return _checkScan();
        case 803:
          Storage.local.setString(ConfigKeys.cookieKey, res3.data['cookie']);
          getUserInfo();
          return;
      }
    });
  }
}
