import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/utilities/field_decoration.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class AppTextField extends StatefulWidget {
  final int type;

  final String hintKey;

  final String errorKey;

  final TextEditingController controller;


  final bool isObscured;

  final FocusNode node;

  final FocusNode nextNode;

  const AppTextField(
      {Key key,
      this.type,
      this.hintKey,
      this.errorKey,
      this.controller,
      this.isObscured,
      this.node,
      this.nextNode,})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscured ;

  @override
  void initState() {
    super.initState();
    isObscured = widget.isObscured ;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        TextFormField(
          controller:  widget.controller,
          obscureText: widget.isObscured ?? false,
          decoration: FieldDecoration(hint: getTranslated(context, widget.hintKey)),
          focusNode:  widget.node,
          onFieldSubmitted: (input) {
            if ( widget.nextNode == null) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).requestFocus( widget.nextNode);
            }
          },
          textInputAction: ( widget.nextNode == null)
              ? TextInputAction.done
              : TextInputAction.next,
          keyboardType: ( widget.type == EMAIL)
              ? TextInputType.emailAddress
              : TextInputType.text,
          validator: (input) {
            if (input.isEmpty) {
              return getTranslated(context,  widget.errorKey);
            }
            if ( widget.type == EMAIL && !EmailValidator.validate(input)) {
              return getTranslated(context, "invalid_email_error_message");
            }
            return null;
          },
        ),
        _buildObscureIcon()
      ],
    );
  }

  _buildObscureIcon() {
    if (widget.isObscured != null) {
      return IconButton(
        splashRadius: 20.r,
        onPressed: () {
          setState(() {
            isObscured = !isObscured ;
          });
        },
        icon: Icon((widget.isObscured) ? Icons.visibility : Icons.visibility_off),
      );
    } else {
      return Container();
    }
  }
}
