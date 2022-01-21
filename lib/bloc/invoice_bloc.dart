import 'package:bloc/bloc.dart';
import 'package:invoices/invoice_database/invoice_database.dart';
import 'package:invoices/models/Invoice_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceDatabase _invoiceDatabase;
  List<Invoice> _invoices = [];
  InvoiceBloc(this._invoiceDatabase) : super(InvoiceInitial());

  @override
  Stream<InvoiceState> mapEventToState(InvoiceEvent event) async* {
    if (event is InvoiceInitialEvent) {
      yield* _mapInitialEventToState();
    } else if (event is InvoiceAddEvent) {
      yield* _mapInvoiceAddEventToState(invoice: event.invoice);
    } else if (event is InvoiceEditEvent) {
      yield* _mapInvoiceEditEventToState(
          invoice: event.invoice, index: event.index);
    } else if (event is InvoiceDeleteEvent) {
      yield* _mapInvoiceDeleteEventToState(index: event.index);
    }
  }

  Stream<InvoiceState> _mapInitialEventToState() async* {
    yield InvoiceLoading();

    await _getInvoices();

    yield MyInvoiceState(invoices: _invoices);
  }

  Stream<InvoiceState> _mapInvoiceAddEventToState({Invoice? invoice}) async* {
    yield InvoiceLoading();
    await _addToInvoices(invoice: invoice!);
    yield MyInvoiceState(invoices: _invoices);
  }

  Stream<InvoiceState> _mapInvoiceEditEventToState(
      {Invoice? invoice, int? index}) async* {
    yield InvoiceLoading();
    await _updateInvoice(invoice: invoice, index: index);
    yield MyInvoiceState(invoices: _invoices);
  }

  Stream<InvoiceState> _mapInvoiceDeleteEventToState({int? index}) async* {
    yield InvoiceLoading();
    await _removeFromInvoices(index: index);

    yield MyInvoiceState(invoices: _invoices);
  }

  Future<void> _getInvoices() async {
    await _invoiceDatabase.getFullInvoice().then((value) {
      _invoices = value;
    });
  }

  Future<void> _addToInvoices({Invoice? invoice}) async {
    await _invoiceDatabase.addToBox(invoice!);
    await _getInvoices();
  }

  Future<void> _updateInvoice({int? index, Invoice? invoice}) async {
    await _invoiceDatabase.updateInvoice(index!, invoice!);
    await _getInvoices();
  }

  Future<void> _removeFromInvoices({int? index}) async {
    await _invoiceDatabase.deleteFromBox(index!);
    await _getInvoices();
  }
}
