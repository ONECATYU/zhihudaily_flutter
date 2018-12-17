import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsListItem extends StatelessWidget {
  NewsListItem({
    Key key,
    this.title,
    this.imgUrl,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final double _height = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: _height,
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  title ?? "",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Container(
                height: _height - 24,
                width: _height,
                margin: EdgeInsets.only(left: 10),
                color: Color(0xfff0f0f0),
                child: CachedNetworkImage(
                  imageUrl: imgUrl ?? "",
                  placeholder: Center(
                    child: Text(
                      "图片加载中...",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1),
      ],
    );
  }
}
