import 'package:flutter/material.dart';
import 'package:invoices/constants/app_resource_constants.dart';
import 'package:invoices/screens/edit_invoice.dart';

class AddInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return EditInvoiceScreen(
              newInvoice: true,
            );
          }));
        },
        child: Container(
          width: ResourceConstants.deviceWidth(context),
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Text(ResourceConstants.InvoiceScreenAddInvoice,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              )),
        ));
  }
}
