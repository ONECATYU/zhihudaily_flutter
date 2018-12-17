import 'package:flutter/material.dart';

import 'package:zhihudaily_flutter/models/news_comment_model.dart';

class NewsCommentListItem extends StatelessWidget {
  NewsCommentListItem({
    Key key,
    this.comment,
  }) : super(key: key);

  final NewsCommentModel comment;

  Widget _buildUserNameSection() {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${comment.author}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/thumb_up.png",
                  height: 18,
                ),
                Padding(padding: EdgeInsets.only(left: 5)),
                Text(
                  "${comment.likes}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contentChildren = [
      _buildUserNameSection(),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          "${comment.content}",
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
    ];

    if (comment.replyTo != null) {
      contentChildren.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: "//${comment.replyTo.author}: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: "${comment.replyTo.content}"),
              ],
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black54,
              ))),
        ),
      );
    }

    contentChildren.add(
      Text(comment.getTimeString()),
    );

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color(0xFFF1F1F1),
            radius: 20,
            backgroundImage: NetworkImage("${comment.avatar}"),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contentChildren,
            ),
          ),
        ],
      ),
    );
  }
}
