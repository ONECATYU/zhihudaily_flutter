import 'package:flutter/material.dart';

import 'package:zhihudaily_flutter/widgets/drawer_user_info_item.dart';
import 'package:zhihudaily_flutter/pages/setting_page.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerPageState();
  }
}

class _DrawerPageState extends State<DrawerPage> {
  Widget _buildItem(IconData iconData, String title, [Function() onTap]) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.white,
            size: 24.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      color: Color.fromRGBO(60, 63, 65, 1),
      child:ListView(
        children: <Widget>[
          DrawerUserInfoItem(
            userName: "未登录",
            headImgUrl: "",
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildItem(Icons.star_border, "收藏", () {}),
                _buildItem(Icons.message, "消息", () {}),
                _buildItem(Icons.settings, "设置", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SettingPage(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
