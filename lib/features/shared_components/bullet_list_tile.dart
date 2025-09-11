import 'package:flutter/material.dart';

class BulletListTile extends StatelessWidget {
  const BulletListTile({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text(
            '\u2022',
            style: TextStyle(
              fontSize: 16,
              height: 1.55,
            ),
          ),
        ),
        Expanded(
          child: Text(
            content,
            textAlign: TextAlign.left,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
