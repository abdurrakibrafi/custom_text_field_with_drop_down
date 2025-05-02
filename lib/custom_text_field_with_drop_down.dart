import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWithDropDown extends StatefulWidget {
  final String hintText;
  final bool showObscure;
  final bool? readOnly;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? borderColor;
  final int? maxLines;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final Gradient? fillGradient;
  final Color? fillColor;
  final Color? iconColor;
  final bool dropdownShow;
  final List<String> dropdownItems;
  final Icon? suffixIcon;

  const CustomTextFieldWithDropDown({
    Key? key,
    required this.hintText,
    required this.showObscure,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.borderColor,
    this.maxLines,
    this.readOnly,
    this.hintStyle,
    this.fillGradient,
    this.fillColor,
    this.dropdownShow = false,
    this.dropdownItems = const [],
    this.borderRadius,
    this.suffixIcon,
    this.iconColor,
  }) : super(key: key);

  @override
  _CustomTextFieldWithDropDownState createState() =>
      _CustomTextFieldWithDropDownState();
}

class _CustomTextFieldWithDropDownState
    extends State<CustomTextFieldWithDropDown> {
  bool _obscureText = true;
  late TextEditingController _controller;
  late TextEditingController _dropdownController;
  bool _isDropdownVisible = false;
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _dropdownController = TextEditingController();
    _filteredItems = widget.dropdownItems;

    _dropdownController.addListener(() {
      setState(() {
        _filteredItems =
            widget.dropdownItems
                .where(
                  (item) => item.toLowerCase().contains(
                    _dropdownController.text.toLowerCase(),
                  ),
                )
                .toList();
        _isDropdownVisible =
            widget.dropdownShow &&
            _dropdownController.text.isNotEmpty &&
            (_filteredItems.isNotEmpty || _dropdownController.text.isNotEmpty);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        gradient: widget.fillGradient,
        color: widget.fillColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: widget.keyboardType,
            controller: _dropdownController,
            readOnly: widget.readOnly ?? false,
            obscureText: widget.showObscure ? _obscureText : false,
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.green,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.green,
                  width: 1,
                ),
              ),
              prefixIcon:
                  widget.prefixIcon != null
                      ? Icon(widget.prefixIcon, color: widget.iconColor)
                      : null,
              suffixIcon:
                  widget.showObscure
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: widget.iconColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : widget.suffixIcon,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? GoogleFonts.outfit(fontSize: 14),
            ),
          ),
          if (_isDropdownVisible)
            Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.borderColor ?? Colors.green,
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _filteredItems.isEmpty ? 1 : _filteredItems.length,
                  itemBuilder: (context, index) {
                    if (_filteredItems.isEmpty) {
                      return ListTile(
                        title: Text(
                          "No matches found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListTile(
                      title: Text(_filteredItems[index]),
                      onTap: () {
                        setState(() {
                          _dropdownController.text = _filteredItems[index];
                          _isDropdownVisible = false;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
