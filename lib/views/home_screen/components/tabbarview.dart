import 'package:flutter/material.dart';
import 'package:letschat_flutter/consts/images.dart';
import 'package:letschat_flutter/views/home_screen/components/call_component.dart';

import '../../views.dart';

Widget tabbarView() {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(bottom: 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))),
      child: TabBarView(children: [
        Container(
          //decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgimg2),
              fit: BoxFit.cover,
            ),
            // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            // color: Color.fromARGB(255, 47, 77, 109),
          ),
          child: chatsComponent(),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgimg2),
              fit: BoxFit.cover,
            ),
            // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            // color: Color.fromARGB(255, 47, 77, 109),
          ),
          child: statusComponent(),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgimg2),
              fit: BoxFit.cover,
            ),
            // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            // color: Color.fromARGB(255, 47, 77, 109),
          ),
          child: callComponent(),
        ),
      ]),
    ),
  );
}
