import 'package:flutter/material.dart';
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
                  automaticallyImplyLeading: false,
                  titleSpacing: 64,
                  title: TabBar(
                    labelColor: Theme.of(context).textTheme.titleMedium!.color,
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    unselectedLabelColor: Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3,
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: tabs
                        .map((tab) => Tab(
                              text: tab,
                            ))
                        .toList(),
                  ),
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                body: const SafeArea(child: TabBarView(children: [MyList(), RecommandList(), Settings()])),
              ),
            )
          : Scaffold(body: LoginQRcode()),
    );
  }
}
