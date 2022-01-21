part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InvoiceInitialEvent extends InvoiceEvent {}

class InvoiceAddEvent extends InvoiceEvent {
  final Invoice invoice;
  InvoiceAddEvent({required this.invoice});
}

class InvoiceEditEvent extends InvoiceEvent {
  final Invoice invoice;
  final int index;
  InvoiceEditEvent({required this.invoice, required this.index});
}

class InvoiceDeleteEvent extends InvoiceEvent {
  final int index;
  InvoiceDeleteEvent({required this.index});
}
