import 'package:flutter/material.dart';

class ResourceConstants {
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Color appBG = Color.fromARGB(255, 247, 246, 242);

  // Invoice Screen

  static String InvoiceScreenTitle = "Fatura bilgilerim";
  static String InvoiceScreenAddInvoice = "Yeni fatura bilgisi ekle";
  static String InvoiceScreenDeleteInvoice = "Sil";

  static TextStyle InvoiceScreenAppbarTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  // EditInvoiceScreen

  static String EditInvoiceScreenTitle = "Fatura Bilgisi Ekle";
  static String EditInvoiceScreenSelectInvoiceTypePerson = "Şahıs";
  static String EditInvoiceScreenSelectInvoiceTypeCompany = "Şirket";
  static String EditInvoiceScreenSubMenuTitle = "Fatura Bilgisi";
  static String EditInvoiceScreenFormFullName = "Ad ve Soyad";
  static String EditInvoiceScreenFormTC = "Kimlik Numarası";
  static String EditInvoiceScreenFormCountry = "Ülke";
  static String EditInvoiceScreenFormCompanyName = "Şirket Ünvanı";
  static String EditInvoiceScreenFormTaxOffice = "Vergi Dairesi";
  static String EditInvoiceScreenFormTaxNumber = "Vergi Numarası";
  static String EditInvoiceScreenFormCity = "Şehir";
  static String EditInvoiceScreenFormDistrict = "İlçe";
  static String EditInvoiceScreenFormAddress = "Adres";
  static String EditInvoiceScreenFormSave = "KAYDET";

  static Color EditInvoiceScreensaveButtonBG = Color.fromARGB(255, 9, 58, 62);
  static Color textFormFieldColor = Colors.white;
  static Color textformFieldIconColor = Colors.grey;
  static Color textformFieldFocusBorderColor = Colors.black;
  static Color textformFieldDisableBorderColor = Colors.black;
  static Color textformFieldEnabledBorderColor = Colors.black;
  static Color textformFieldFocusedErrorBorderColor = Colors.black;
  static Color textformFieldErrorBorderColor = Colors.red;
  static TextStyle inputHintTextStyle = TextStyle(
      fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w500);
}
