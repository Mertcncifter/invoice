part of 'Invoice_model.dart';

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 1;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();

    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
        invoiceType:
            fields[0].toString().split('.').last.toString().stringToInvoiceType,
        fullName: fields[1] as String?,
        tc: fields[2] as String?,
        country: fields[3] as String?,
        companyName: fields[4] as String?,
        taxOffice: fields[5] as String?,
        taxNumber: fields[6] as String?,
        city: fields[7] as String,
        district: fields[8] as String,
        Address: fields[9] as String);
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._invoiceType)
      ..writeByte(1)
      ..write(obj.fullName ?? "")
      ..writeByte(2)
      ..write(obj.tc ?? "")
      ..writeByte(3)
      ..write(obj.country ?? "")
      ..writeByte(4)
      ..write(obj.companyName ?? "")
      ..writeByte(5)
      ..write(obj.taxOffice ?? "")
      ..writeByte(6)
      ..write(obj.taxNumber ?? "")
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.district)
      ..writeByte(9)
      ..write(obj.Address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
