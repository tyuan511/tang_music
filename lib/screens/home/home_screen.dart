import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/my_list.dart';
import 'components/recommand_list.dart';
import 'components/settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['我的', '推荐', '设置'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 120,
            ),
            child: TabBar(
              labelColor: Colors.black,
              labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
        body: const SafeArea(child: TabBarView(children: [MyList(), RecommandList(), Settings()])),
      ),
    );
  }
}
