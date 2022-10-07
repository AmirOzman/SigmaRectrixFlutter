import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/screen/screen.dart';

class ButtonNewActivity extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  final int customerID;
  final String customerName;
  const ButtonNewActivity({
    Key? key,
    required this.client,
    required this.session,
    required this.customerID,
    required this.customerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Center(
        child: Row(
          children: const [
            Icon(Icons.add),
            Text('New Activity'),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityNew(
              client,
              session,
              clientId: customerID,
              clientName: customerName,
            ),
          ),
        );
      },
    );
  }
}
