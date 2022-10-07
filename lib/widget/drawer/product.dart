import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class Product extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const Product(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
