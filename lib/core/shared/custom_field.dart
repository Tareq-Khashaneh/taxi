import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomField extends StatefulWidget {
  CustomField(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      this.label,
      this.maxLines = 1,
      this.hint,
      this.onChanged,
      this.textInputType = TextInputType.text,
      this.isPassword,
      this.controller,
      this.isFilled = true,
      this.borderRadius = 20,
      this.fillColor = AppColors.fieldColor,
      this.borderSide = BorderSide.none,
      this.onSubmit,
        this.readOnly = false,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
        this.onTap,
      this.validator, });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final String? label;
  final String? hint;
  final bool isFilled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final double borderRadius;
  late bool? isPassword;
  final BorderSide borderSide;
  final Color fillColor;
  final int maxLines;
  Function(String)? onSubmit;
  Function()? onTap;
  final AutovalidateMode autoValidateMode;

  final bool readOnly;
  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: widget.onSubmit,
      controller: widget.controller,
      maxLines: widget.maxLines,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      obscureText: widget.isPassword != null ? widget.isPassword! : false,
      decoration: InputDecoration(
        labelText: widget.label,
        filled: widget.isFilled,
        fillColor: widget.fillColor,

        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.grey,
            ),
        // Hint text color
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(widget.borderRadius), // Border radius
          borderSide: widget.borderSide, // No border side
        ),
        suffixIcon: widget.isPassword != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword!;
                  });
                },
                icon: widget.isPassword!
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility))
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon, // Prefix icon
      ),
    );
  }
}
