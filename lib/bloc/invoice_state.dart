part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class EditInvoiceState extends InvoiceState {
  final Invoice invoice;
  EditInvoiceState({required this.invoice});
}

class MyInvoiceState extends InvoiceState {
  final List<Invoice> invoices;
  MyInvoiceState({required this.invoices});
}

class NetInvoiceState extends InvoiceState {}
