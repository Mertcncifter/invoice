import 'package:hive/hive.dart';
import 'package:invoices/model/model.dart';

class InvoiceDatabase {
  String _boxName = "Invoice";
  Future<Box<Invoice>> invoiceBox() async {
    var box = await Hive.openBox<Invoice>(_boxName);
    return box;
  }

  Future<List<Invoice>> getFullInvoice() async {
    final box = await invoiceBox();
    List<Invoice> invoices = box.values.toList();
    return invoices;
  }

  Future<void> addToBox(Invoice note) async {
    final box = await invoiceBox();
    await box.add(note);
  }

  Future<void> deleteFromBox(int index) async {
    final box = await invoiceBox();
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await invoiceBox();
    await box.clear();
  }

  Future<void> updateInvoice(int index, Invoice invoice) async {
    final box = await invoiceBox();
    await box.putAt(index, invoice);
  }
}
