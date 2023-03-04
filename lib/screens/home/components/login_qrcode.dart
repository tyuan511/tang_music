import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tang_music/api/api_controller.dart';

class LoginQRcode extends StatelessWidget {
  LoginQRcode({
    super.key,
  });

  final ApiController api = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return api.qrcodeUrl.value != ''
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: api.qrcodeUrl.value,
                  size: 300,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  api.qrcodeUrl.value,
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "请扫码登录",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          )
        : Container();
  }
}
