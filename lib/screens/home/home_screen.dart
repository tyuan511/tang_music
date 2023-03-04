import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tang_music/api/api_controller.dart';
import 'package:tang_music/screens/home/components/login_qrcode.dart';

import 'components/my_list.dart';
import 'components/recommand_list.dart';
import 'components/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiController api = Get.put(ApiController());

  @override
  void initState() {
    api.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['我的', '推荐', '设置'];

    return Obx(
      () => api.logined
          ? DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                appBar: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: TabBar(
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      unselectedLabelColor: Colors.black54,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 3,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: tabs
                          .map((tab) => Tab(
                                text: tab,
                              ))
                          .toList(),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                body: SafeArea(child: TabBarView(children: [MyList(), RecommandList(), Settings()])),
              ),
            )
          : LoginQRcode(),
    );
  }
}
