import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/bloc/invoice_bloc.dart';
import 'package:invoices/constants/app_resource_constants.dart';
import 'package:invoices/constants/enum.dart';
import 'package:invoices/models/invoice_model.dart';

class EditInvoiceScreen extends StatefulWidget {
  final bool? newInvoice;
  final Invoice? invoice;
  final int? index;
  EditInvoiceScreen({Key? key, this.newInvoice, this.invoice, this.index});

  @override
  _EditInvoiceScreen createState() => _EditInvoiceScreen();
}

class _EditInvoiceScreen extends State<EditInvoiceScreen> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier<InvoiceType>? selectInvoiceType;
  late TextEditingController fullNameConroller;
  late TextEditingController tcConroller;
  late TextEditingController countryController;
  late TextEditingController companyNameController;
  late TextEditingController taxNumberController;
  late TextEditingController taxOfficeController;
  late TextEditingController cityController;
  late TextEditingController districtController;
  late TextEditingController addressController;

  checkIsValid(String text) {
    return text.length < 1 ? '' : null;
  }

  TextEditingController controller(String? text) =>
      TextEditingController(text: text);

  Future<bool> onBackKey() async {
    Navigator.pop(context);
    return false;
  }

  @override
  void initState() {
    super.initState();
    selectInvoiceType = ValueNotifier(
        widget.newInvoice! ? InvoiceType.person : widget.invoice!.invoiceType);
    fullNameConroller =
        controller(widget.invoice == null ? "" : widget.invoice!.fullName);
    tcConroller = controller(widget.invoice == null ? "" : widget.invoice!.tc);
    countryController =
        controller(widget.invoice == null ? "" : widget.invoice!.country);
    companyNameController =
        controller(widget.invoice == null ? "" : widget.invoice!.companyName);
    taxNumberController =
        controller(widget.invoice == null ? "" : widget.invoice!.taxNumber);
    taxOfficeController =
        controller(widget.invoice == null ? "" : widget.invoice!.taxOffice);
    cityController = controller(widget.newInvoice! ? "" : widget.invoice!.city);
    districtController =
        controller(widget.newInvoice! ? "" : widget.invoice!.district);
    addressController =
        controller(widget.newInvoice! ? "" : widget.invoice!.Address);
  }

  @override
  void dispose() {
    super.dispose();
    fullNameConroller.dispose();
    tcConroller.dispose();
    countryController.dispose();
    companyNameController.dispose();
    taxNumberController.dispose();
    taxOfficeController.dispose();
    cityController.dispose();
    districtController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackKey,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ResourceConstants.appBG,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(ResourceConstants.deviceHeight(context) * .08),
            child: appbar(),
          ),
          body: _invoiceForm(),
        ));
  }

  Widget appbar() {
    return Container(
      child: AppBar(
        backgroundColor: ResourceConstants.appBG,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          ResourceConstants.EditInvoiceScreenTitle,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _invoiceForm() {
    return SingleChildScrollView(
        child: Stack(children: [
      Form(
          key: formKey,
          child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _selectInvoiceType(),
                      _subTitle(),
                      _filterInputWidget(),
                      _space(),
                      Row(
                        children: [
                          Flexible(
                              child: _customField(cityController,
                                  ResourceConstants.EditInvoiceScreenFormCity)),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                              child: _customField(
                                  districtController,
                                  ResourceConstants
                                      .EditInvoiceScreenFormDistrict)),
                        ],
                      ),
                      _space(),
                      _customField(addressController,
                          ResourceConstants.EditInvoiceScreenFormAddress),
                      _space(),
                      button()
                    ],
                  ))))
    ]));
  }

  Widget _space() {
    return SizedBox(height: 15);
  }

  Widget _selectInvoiceType() {
    return ValueListenableBuilder<InvoiceType>(
        valueListenable: selectInvoiceType!,
        builder: (context, _, child) {
          return Column(children: [
            GestureDetector(
                onTap: () {
                  selectInvoiceType!.value = InvoiceType.person;
                },
                child: Container(
                    width: ResourceConstants.deviceWidth(context),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ResourceConstants
                              .EditInvoiceScreenSelectInvoiceTypePerson,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Radio<InvoiceType>(
                          value: InvoiceType.person,
                          onChanged: (type) {},
                          groupValue: selectInvoiceType!.value,
                        )
                      ],
                    ))),
            GestureDetector(
                onTap: () {
                  selectInvoiceType!.value = InvoiceType.company;
                },
                child: Container(
                    width: ResourceConstants.deviceWidth(context),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black),
                            left: BorderSide(width: 1, color: Colors.black),
                            right: BorderSide(width: 1, color: Colors.black))),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ResourceConstants
                              .EditInvoiceScreenSelectInvoiceTypeCompany,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Radio<InvoiceType>(
                          value: InvoiceType.company,
                          onChanged: (type) {
                            selectInvoiceType!.value = type!;
                          },
                          groupValue: selectInvoiceType!.value,
                        )
                      ],
                    )))
          ]);
        });
  }

  Widget _subTitle() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              ResourceConstants.EditInvoiceScreenSubMenuTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )));
  }

  Widget _filterInputWidget() {
    return ValueListenableBuilder<InvoiceType>(
        valueListenable: selectInvoiceType!,
        builder: (context, _, child) {
          switch (_) {
            case InvoiceType.company:
              return companyInputs();
            case InvoiceType.person:
              return personInputs();
            default:
              return SizedBox();
          }
        });
  }

  Widget personInputs() {
    return Column(
      children: [
        _customField(
            fullNameConroller, ResourceConstants.EditInvoiceScreenFormFullName),
        SizedBox(
          height: 15,
        ),
        _customField(tcConroller, ResourceConstants.EditInvoiceScreenFormTC),
        SizedBox(
          height: 15,
        ),
        _customField(
            countryController, ResourceConstants.EditInvoiceScreenFormCountry),
      ],
    );
  }

  Widget companyInputs() {
    return Column(children: [
      _customField(companyNameController,
          ResourceConstants.EditInvoiceScreenFormCompanyName),
      SizedBox(
        height: 15,
      ),
      _customField(taxOfficeController,
          ResourceConstants.EditInvoiceScreenFormTaxOffice),
      SizedBox(
        height: 15,
      ),
      _customField(taxNumberController,
          ResourceConstants.EditInvoiceScreenFormTaxNumber),
    ]);
  }

  Widget _customField(TextEditingController controller, String hintText) {
    return TextFormField(
        controller: controller,
        validator: (value) => checkIsValid(value!),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: customInputDecoration(hintText, controller));
  }

  customInputDecoration(String hinText, TextEditingController controller) {
    return InputDecoration(
        fillColor: ResourceConstants.textFormFieldColor,
        filled: true,
        errorStyle: TextStyle(fontSize: 0, height: 0),
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1, color: ResourceConstants.textformFieldFocusBorderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1,
              color: ResourceConstants.textformFieldDisableBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1,
              color: ResourceConstants.textformFieldEnabledBorderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1,
                color: ResourceConstants.textformFieldErrorBorderColor)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1, color: ResourceConstants.textformFieldErrorBorderColor),
        ),
        hintText: hinText,
        hintStyle: ResourceConstants.inputHintTextStyle);
  }

  Widget button() {
    return MaterialButton(
      padding: EdgeInsets.all(15),
      minWidth: ResourceConstants.deviceWidth(context),
      onPressed: saveClicked,
      color: ResourceConstants.EditInvoiceScreensaveButtonBG,
      child: Text(
        ResourceConstants.EditInvoiceScreenFormSave,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  saveClicked() {
    if (formKey.currentState?.validate() == true) {
      Invoice invoice = Invoice(
          invoiceType: selectInvoiceType!.value,
          fullName: fullNameConroller.text,
          tc: tcConroller.text,
          country: countryController.text,
          companyName: companyNameController.text,
          taxOffice: taxOfficeController.text,
          taxNumber: taxNumberController.text,
          city: cityController.text,
          district: districtController.text,
          Address: addressController.text);
      widget.newInvoice!
          ? BlocProvider.of<InvoiceBloc>(context)
              .add(InvoiceAddEvent(invoice: invoice))
          : BlocProvider.of<InvoiceBloc>(context)
              .add(InvoiceEditEvent(invoice: invoice, index: widget.index!));
      Navigator.pop(context);
    }
  }
}
