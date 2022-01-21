import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/bloc/invoice_bloc.dart';
import 'package:invoices/constants/app_resource_constants.dart';
import 'package:invoices/constants/enum.dart';
import 'package:invoices/screens/edit_invoice.dart';

import 'add_invoice.dart';

class InvoiceList extends StatelessWidget {
  final MyInvoiceState state;
  InvoiceList({required this.state});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String>? groupValue = ValueNotifier("");
    return state.invoices.length == 0
        ? AddInvoice()
        : Expanded(
            child: ListView.builder(
                itemCount: state.invoices.length,
                itemBuilder: (_, index) {
                  final invoice = state.invoices[index];

                  return Column(children: [
                    Container(
                      width: ResourceConstants.deviceWidth(context),
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          ValueListenableBuilder<String>(
                              valueListenable: groupValue,
                              builder: (context, _, child) {
                                return Radio(
                                    value: invoice.invoiceType ==
                                            InvoiceType.person
                                        ? invoice.fullName.toString()
                                        : invoice.companyName.toString(),
                                    groupValue: groupValue.value,
                                    onChanged: (value) {
                                      groupValue.value = value.toString();
                                    });
                              }),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return EditInvoiceScreen(
                                    invoice: invoice,
                                    index: index,
                                    newInvoice: false,
                                  );
                                }));
                              },
                              child: Text(
                                invoice.invoiceType == InvoiceType.person
                                    ? invoice.fullName.toString()
                                    : invoice.companyName.toString(),
                              )),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<InvoiceBloc>(context)
                                    .add(InvoiceDeleteEvent(index: index));
                              },
                              child: Text(
                                ResourceConstants.InvoiceScreenDeleteInvoice,
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        ],
                      ),
                    ),
                    index == state.invoices.length - 1
                        ? AddInvoice()
                        : SizedBox()
                  ]);
                }));
  }
}
