import 'package:albify/common/constants.dart';
import 'package:flutter/material.dart';

import '../common/utils.dart';

class CircularTextFormField extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final Function(String? value)? validateFun;
  final TextEditingController textEditingController;
  // final Function(String? value) onChangedFun;
  final TextInputType? inputType;
  final bool? obsecureText;
  final bool? isConfirm;
  final String? matchWith;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  CircularTextFormField(
    this.hintText,
    this.icon,
    this.validateFun,
    this.textEditingController,
    // this.onChangedFun,
    {
      this.inputType,
      this.obsecureText,
      this.isConfirm,
      this.matchWith,
      this.textInputAction = TextInputAction.next,
      this.focusNode,
      this.nextFocusNode
    }
  );

  set matchWith(String? value) => matchWith = value;

  @override
  _CircularTextFormFieldState createState() => _CircularTextFormFieldState();
}

class _CircularTextFormFieldState extends State<CircularTextFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType ?? TextInputType.text,
      obscureText: (widget.obsecureText ?? false) ? !_passwordVisible : false,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RADIUS)
        ),
        suffixIcon: (widget.obsecureText ?? false) ?
          IconButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: Icon(
              _passwordVisible ?
              Icons.visibility :
              Icons.visibility_off
            )
          ) :
          null
      ),
      validator: (value) =>
        (widget.isConfirm ?? false) ? Utils.validateConfirmPassword(value, widget.matchWith) : widget.validateFun!(value),
      controller: widget.textEditingController,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onFieldSubmitted: (value) {
        if (widget.focusNode != null && widget.nextFocusNode != null) {
          widget.focusNode!.unfocus();
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      // onChanged: (value) => widget.onChangedFun(value),
    );
  }
}