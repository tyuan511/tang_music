import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 160)),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://p1.music.126.net/Ethtz4VJFKtuuhpcd9WLzg==/109951168252754401.jpg",
                width: 200,
                height: 200,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text(
                "合拍",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: const Text(
                "许嵩",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                children: const [
                  Text(
                    '00:00',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: LinearProgressIndicator(
                          value: 0.2,
                        )),
                  ),
                  Text(
                    '05:20',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36, bottom: 80),
              child: SizedBox(
                width: 240,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(34)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 4,
                              blurRadius: 8,
                            )
                          ]),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.pause,
                          size: 32,
                        ),
                        onTap: () {},
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
