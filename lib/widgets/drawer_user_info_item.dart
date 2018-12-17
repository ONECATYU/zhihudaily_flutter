import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DrawerUserInfoItem extends StatelessWidget {
  DrawerUserInfoItem({
    Key key,
    this.userName,
    this.headImgUrl,
  }) : super(key: key);

  final String userName;
  final String headImgUrl;

  @override
  Widget build(BuildContext context) {
    const double userHeadSize = 40;
    Widget userHeadPlaceholder = Center(
      child: Icon(
        Icons.camera_alt,
        color: Colors.grey[300],
      ),
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: userHeadSize / 2.0,
            backgroundColor: Colors.grey[400],
            child: CachedNetworkImage(
              imageUrl: headImgUrl ?? "",
              placeholder: userHeadPlaceholder,
              errorWidget: userHeadPlaceholder,
              width: userHeadSize,
              height: userHeadSize,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              userName ?? "",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
