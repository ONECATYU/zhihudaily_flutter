import 'package:flutter/material.dart';

class BottomToolBar extends StatelessWidget {
  BottomToolBar({
    Key key,
    this.thumbNum,
    this.commentNum,
    this.nextTap,
    this.thumbTap,
    this.shareTap,
    this.commentTap,
  }) : super(key: key);

  final String thumbNum;
  final String commentNum;

  final void Function() nextTap;
  final void Function() thumbTap;
  final void Function() shareTap;
  final void Function() commentTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            color: Color(0xfff0f0f0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _BottomToolBarItem(
            assetImageName: "images/back.png",
            onTap: () => Navigator.of(context).pop(),
          ),
          _BottomToolBarItem(
            assetImageName: "images/next.png",
            onTap: nextTap,
          ),
          _BottomToolBarItem(
            assetImageName: "images/thumb_up.png",
            edgeValue: thumbNum ?? "",
            onTap: thumbTap,
          ),
          _BottomToolBarItem(
            assetImageName: "images/share.png",
            onTap: shareTap,
          ),
          _BottomToolBarItem(
            assetImageName: "images/message.png",
            edgeValue: commentNum ?? "",
            onTap: commentTap,
          ),
        ],
      ),
    );
  }
}

class _BottomToolBarItem extends StatelessWidget {
  _BottomToolBarItem({
    Key key,
    this.assetImageName,
    this.edgeValue = "",
    this.onTap,
  }) : super(key: key);

  final String assetImageName;
  final String edgeValue;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Image.asset(
                assetImageName,
                width: 23,
                height: 23,
              ),
            ),
            Text(
              edgeValue,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
