// import 'package:flutter/material.dart';

// class SearchHeader extends SliverPersistentHeaderDelegate {
//   final double minTopBarH = 100;
//   final double maxTopBarH = 200;
//   final String title;
//   final IconData? icon;
//   final Widget? search;

//   SearchHeader({
//     required this.title,
//     this.icon,
//     this.search,
//   });

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));

//     var topBar = Positioned(
//         top: 0,
//         left: 0,
//         right: 0,
//         child: Container(
//             alignment: Alignment.center,
//             height: max(maxTopBarH * (1 - shrinkFactor * 1.45), minTopBarH)));
//   }
// }
