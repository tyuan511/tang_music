import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "服务器地址",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 320,
                height: 48,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8)),
                child: const TextField(
                  decoration: InputDecoration(hintText: "请输入服务器地址", border: InputBorder.none),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 100,
                height: 48,
                child: FloatingActionButton(
                  mini: true,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () {},
                  child: const Text('确定'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
