import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final VoidCallback tag;
  const CategoryTile({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: const [
            AspectRatio(aspectRatio: 485.0 / 384.0),
          ],
        ),
      ),
    );
  }
}
