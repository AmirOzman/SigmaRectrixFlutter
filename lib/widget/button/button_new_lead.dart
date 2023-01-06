import 'package:flutter/material.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class NewLeadButton extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  const NewLeadButton({
    Key? key,
    required this.client,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FloatingActionButtonLocation.centerDocked;
    return FloatingActionButton.extended(
      backgroundColor: Colors.black,
      label: Center(
          child: Row(
        children: const [
          Icon(Icons.add),
          Text(' New Lead'),
        ],
      )),
      shape: RoundedRectangleBorder(
          // side: ,
          borderRadius: BorderRadius.circular(20)),
      // child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadForm(
              client,
              session,
              id: null,
            ),
          ),
        );
      },
    );
  }
}
