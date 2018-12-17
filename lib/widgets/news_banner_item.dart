import 'package:flutter/material.dart';

class NewsBannerItem extends StatelessWidget {
  NewsBannerItem({
    Key key,
    this.imageUrl,
    this.title,
  }) : super(key: key);

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Image.network(
          imageUrl ?? "",
          fit: BoxFit.cover,
          width: screenSize.width,
        ),
        Positioned(
          child: Container(
            width: screenSize.width,
            padding: EdgeInsets.all(10),
            child: Text(
              title ?? "",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          bottom: 20,
        ),
      ],
    );
  }
}
