import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/bloc/invoice_bloc.dart';
import 'package:invoices/constants/app_resource_constants.dart';

import 'package:invoices/widgets/invoice_list.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  Future<bool> onBackKey() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackKey,
      child: Scaffold(
          backgroundColor: ResourceConstants.appBG,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(ResourceConstants.deviceHeight(context) * .08),
            child: appbar(),
          ),
          body: _invoiceList()),
    );
  }

  Widget appbar() {
    return Container(
      child: AppBar(
        backgroundColor: ResourceConstants.appBG,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          ResourceConstants.InvoiceScreenTitle,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _invoiceList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<InvoiceBloc, InvoiceState>(builder: (_, state) {
          if (state is InvoiceInitial) {
            return CircularProgressIndicator();
          }
          if (state is MyInvoiceState) {
            return InvoiceList(
              state: state,
            );
          }
          if (state is InvoiceLoading) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        }),
      ],
    );
  }
}
