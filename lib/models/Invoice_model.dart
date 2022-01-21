import 'package:hive/hive.dart';
import 'package:invoices/constants/enum.dart';
part 'Invoice_model_g.dart';

@HiveType(typeId: 1)
class Invoice {
  @HiveType(typeId: 0)
  late String invoicetype;
  @HiveType(typeId: 1)
  String? fullName;
  @HiveType(typeId: 2)
  String? tc;
  @HiveType(typeId: 3)
  String? country;
  @HiveType(typeId: 4)
  String? companyName;
  @HiveType(typeId: 5)
  String? taxOffice;
  @HiveType(typeId: 6)
  String? taxNumber;
  @HiveType(typeId: 7)
  late String city;
  @HiveType(typeId: 8)
  late String district;
  @HiveType(typeId: 9)
  late String Address;

  Invoice(
      {InvoiceType? invoiceType,
      this.fullName,
      this.tc,
      this.country,
      this.companyName,
      this.taxOffice,
      this.taxNumber,
      required this.city,
      required this.district,
      required this.Address})
      : _invoiceType = invoiceType.toString();

  String _invoiceType;

  InvoiceType get invoiceType =>
      _invoiceType.split('.').last.toString() == 'person'
          ? InvoiceType.person
          : InvoiceType.company;
}

extension InvoiceTypeX on InvoiceType {
  String get valueAsString => toString().split('.').last;
  String asString() => toString().split('.').last;
}

extension InvoiceTypeParsing on String {
  InvoiceType get stringToInvoiceType {
    switch (this) {
      case 'person':
        return InvoiceType.person;
      case 'company':
        return InvoiceType.company;
      default:
        return InvoiceType.person;
    }
  }
}
