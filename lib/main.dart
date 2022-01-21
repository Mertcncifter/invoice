import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoices/bloc/invoice_bloc.dart';
import 'package:invoices/invoice_database/invoice_database.dart';
import 'package:invoices/models/model.dart';

import 'package:invoices/screens/invoice_screens.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Invoice>(InvoiceAdapter());
  await Hive.openBox<Invoice>("Invoice");
  runApp(BlocProvider(
      create: (context) => InvoiceBloc(InvoiceDatabase()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InvoiceBloc>(context).add(InvoiceInitialEvent());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: InvoiceScreen(),
    );
  }
}
