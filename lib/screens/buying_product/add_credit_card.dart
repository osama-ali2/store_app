import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCreditCard extends StatefulWidget {
  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumberTextController;

  TextEditingController _nameTextController;

  TextEditingController _endDateTextController;

  TextEditingController _codeTextController;

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();
  FocusNode nodeFour = FocusNode();

  @override
  void initState() {
    super.initState();
    _cardNumberTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _endDateTextController = TextEditingController();
    _codeTextController = TextEditingController();
    nodeOne = FocusNode();
    nodeTwo = FocusNode();
    nodeThree = FocusNode();
    nodeFour = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _cardNumberTextController.dispose();
    _nameTextController.dispose();
    _endDateTextController.dispose();
    _codeTextController.dispose();
    nodeOne.dispose();
    nodeTwo.dispose();
    nodeThree.dispose();
    nodeFour.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        title: Text(
          getTranslated(context, "add_credit_card"),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: _bodyContent(),
    );
  }

  _bodyContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 40.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, "card_details"),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
            SizedBox(height: 26.h),
            _fieldTitleText(getTranslated(context, "card_number")),
            SizedBox(height: 18.h),
            _cardNumberField(),
            SizedBox(height: 26.h),
            _fieldTitleText(getTranslated(context, "cardholder_name")),
            SizedBox(height: 18.h),
            _nameField(),
            SizedBox(height: 26.h),
            _fieldTitleText(getTranslated(context, "end_date")),
            SizedBox(height: 18.h),
            _endDateField(),
            SizedBox(height: 26.h),
            _fieldTitleText(getTranslated(context, "cvv_code")),
            SizedBox(height: 18.h),
            _codeField(),
            SizedBox(height: 56.h),
            AppButton(
              title: 'continue',
              onPressed: () {
                if (_formKey.currentState.validate()) {
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }

  _fieldDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      hintText: hint,
      hintStyle: TextStyle(
          color: grey1, fontSize: 12.sp, fontWeight: FontWeight.normal),
    );
  }

  Widget _fieldTitleText(String title) {
    return Text(
      title,
      style: TextStyle(color: accent, fontWeight: FontWeight.normal),
    );
  }

  Widget _cardNumberField() {
    return TextFormField(
      controller: _cardNumberTextController,
      focusNode: nodeOne,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(19),
        CardNumberInputFormatter(),
      ],
      keyboardType: TextInputType.number,
      onSaved: (input) {},
      validator: (input) {
        if (input.isEmpty ||
            input.length < 16 ||
            !input.startsWith(RegExp(
                r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$'))) {
          return getTranslated(context, "card_number_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration("0000 0000 0000 0000"),
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.start,
      onFieldSubmitted: (input) {
        print(_cardNumberTextController.text);
        FocusScope.of(context).requestFocus(nodeTwo);
      },
    );
  }

  Widget _nameField() {
    return TextFormField(
      controller: _nameTextController,
      focusNode: nodeTwo,
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, "cardholder_name_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration(getTranslated(context, "name")),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(nodeThree);
      },
    );
  }

  Widget _endDateField() {
    return TextFormField(
      controller: _endDateTextController,
      focusNode: nodeThree,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        DateInputFormatter(),
      ],
      validator: (input) {
        if (input.isEmpty) {
          return getTranslated(context, "end_date_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration(getTranslated(context, "year_month")),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (input) {
        FocusScope.of(context).requestFocus(nodeFour);
      },
      keyboardType: TextInputType.datetime,
    );
  }

  Widget _codeField() {
    return TextFormField(
      controller: _codeTextController,
      maxLength: 3,
      focusNode: nodeFour,
      validator: (input) {
        if (input.isEmpty || input.length < 3) {
          return getTranslated(context, "cvv_code_error_message");
        }
        return null;
      },
      decoration: _fieldDecoration("000"),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (input) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: TextInputType.datetime,
    );
  }
}

// class MaskedTextInputFormatter extends TextInputFormatter {
//   final String mask;
//   final String separator;
//
//   MaskedTextInputFormatter({
//     @required this.mask,
//     @required this.separator,
//   }) {
//     assert(mask != null);
//     assert(separator != null);
//   }
//   var string = StringBuffer();
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     print(newValue.text + " " + oldValue.text );
//     if(newValue.text.length == 0){
//       return newValue ;
//     }
//     if(string.length >= oldValue.text.length){
//       if(mask[string.length] == separator){
//         string.write(separator);
//       }
//       string.write(newValue.text.characters.last);
//       return  TextEditingValue(
//         text: string.toString(),
//         selection: TextSelection.collapsed(offset: string.length ),
//       );
//     }
//     return newValue.copyWith(
//       text: newValue.text ,
//       selection: TextSelection.collapsed(
//         offset: n
//       )
//     );
//
//     // if (newValue.text.length > 0) {
//     //   if (newValue.text.length >= oldValue.text.length) {
//     //     if (newValue.text.length > mask.length) return oldValue;
//     //     if (mask[newValue.text.length - 1] == separator) {
//     //       return TextEditingValue(
//     //         text:
//     //             '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
//     //         selection: TextSelection.collapsed(
//     //           offset: newValue.selection.end +1 ,
//     //         ),
//     //       );
//     //     }
//     //     return TextEditingValue(
//     //       text:
//     //       oldValue.text + newValue.text.substring(newValue.text.length -1),
//     //       selection: TextSelection.collapsed(
//     //         offset: newValue.selection.end +1 ,
//     //       ),
//     //     );
//     //   }
//     // }
//     // return newValue;
//   }
// }

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/'); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
