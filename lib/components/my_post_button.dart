import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final void Function()? onTap;
  const PostButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[500],
              borderRadius: BorderRadius.circular(12)
        ),
        padding: EdgeInsets.all(14),
        child: Center(child: Icon(Icons.done)),
      ),
    );
  }
}
