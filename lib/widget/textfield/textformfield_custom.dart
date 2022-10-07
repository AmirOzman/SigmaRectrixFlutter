import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextForm extends StatelessWidget {
  final String label;
  final TextInputType? kb;
  final bool focus;
  final IconButton? logoBack;
  final Icon? logoDepan;
  final int? max;
  final int? maxLength;
  final bool kotak;
  final TextInputFormatter? mask;
  final bool edit;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmit;

  const TextForm({
    Key? key,
    required this.controller,
    required this.label,
    this.kb,
    this.focus = false,
    this.max = 1,
    this.maxLength,
    this.logoBack,
    this.logoDepan,
    this.kotak = true,
    this.mask,
    this.edit = false,
    this.initialValue,
    this.validator,
    this.textInputAction,
    this.onSubmit,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: kb,
      maxLines: max,
      maxLength: maxLength,
      readOnly: edit,
      initialValue: initialValue,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmit,
      validator: validator,
      decoration: kotak ? boxDecoration() : regularDecoration(),
    );
  }

  InputDecoration boxDecoration() => InputDecoration(
      labelText: label,
      suffixIcon: logoBack,
      prefixIcon: logoDepan,
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)));

  InputDecoration regularDecoration() => InputDecoration(
        labelText: label,
        suffixIcon: logoBack,
        prefixIcon: logoDepan,
      );
}
