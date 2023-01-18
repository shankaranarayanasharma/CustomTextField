import 'package:listen_2_re/utilities/defines.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint, caption;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? countryCode;

  final Function()? onTap;
  final double customContentPading,
      captionFontsize,
      contentTopPadding,
      contentBottomPading;

  final double? contentRightPadding, contentLeftPadding;

  final Color? backgroundColor,
      enableBorderColor,
      focusBorderColor,
      captionColor,
      textColor;
  final bool? isPasswordField,
      hasCaption,
      enableContainerBorder,
      enableContainerShadow,
      enableContentPadding,
      isMobileNumber,
      clearSpace,
      enableCounterText,
      autoFocus;
  final int? maxLength;
  final Widget? prefix;
  final bool readOnly;
  final Widget? suffix;
  final int? maxLines, minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? customCaptionFont;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.focusNode,
      required this.hint,
      this.maxLines,
      this.minLines,
      this.keyboardType,
      this.contentBottomPading = 0,
      this.contentLeftPadding = 0,
      this.contentRightPadding = 0,
      this.onChanged,
      this.onTap,
      this.textInputAction,
      this.isPasswordField,
      this.maxLength,
      this.backgroundColor,
      this.enableBorderColor,
      this.focusBorderColor,
      this.contentTopPadding = 0,
      this.prefix,
      this.hasCaption,
      this.captionFontsize = 14,
      this.countryCode,
      this.caption,
      this.enableContainerBorder,
      this.enableContainerShadow,
      this.readOnly = false,
      this.enableContentPadding = true,
      this.isMobileNumber = false,
      this.clearSpace = true,
      this.enableCounterText = false,
      this.autoFocus = false,
      this.suffix,
      this.inputFormatters,
      this.captionColor,
      this.customContentPading = 0.0,
      this.textColor,
      this.customCaptionFont,
      this.onSubmitted})
      : super(key: key);
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isShowPassword = false;

  void changeIsShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.enableContainerShadow ?? false
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: widget.captionColor ?? Colors.black26,
                    blurRadius: 3.0)
              ],
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.hasCaption ?? false)
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 20, bottom: 10),
              child: Column(
                children: [
                  Text(
                    widget.caption ?? '',
                    style: widget.customCaptionFont != null
                        ? widget.customCaptionFont!
                        : Font.lexend(
                            weight: FontWeight.normal,
                            size: widget.captionFontsize,
                            color: Colors.black,
                          ),
                  ),
                ],
              ),
            ),
          Container(
            height: widget.maxLines != null ? null : 42,
            decoration: (widget.isMobileNumber ?? false)
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greyColor_9E,
                      width: 1.0,
                    ),
                  )
                : null,
            child: Row(
              children: [
                if (widget.isMobileNumber ?? false)
                  SizedBox(
                    // width: (SizeConfig.screenWidth / 100) * 30,
                    child: CountryCodePicker(
                      padding: EdgeInsets.zero,
                      onChanged: (v) {
                        widget.countryCode!(v.dialCode ?? "");
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'IN',
                      showDropDownButton: true,
                      showFlagDialog: true,
                      flagWidth: 16,
                      comparator: (a, b) => b.name!.compareTo(a.name!),

                      //Get the country information relevant to the initial selection
                      onInit: (code) => print(
                          "on init ${code!.name} ${code.dialCode} ${code.name}"),
                    ),
                  ),
                if (widget.isMobileNumber ?? false)
                  Container(
                    width: 1,
                    color: greyColor_9E,
                    height: 48,
                  ),
                Expanded(
                  child: TextField(
                    autofocus: widget.autoFocus ?? false,
                    obscureText: (widget.isPasswordField ?? false)
                        ? (!isShowPassword)
                            ? true
                            : false
                        : false,
                    textInputAction: widget.textInputAction,
                    focusNode: widget.focusNode,
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    maxLength: widget.maxLength,
                    onSubmitted: widget.onSubmitted,
                    onTap: widget.onTap,
                    cursorColor: Colors.white,
                    readOnly: widget.readOnly,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    inputFormatters: widget.inputFormatters,
                    style: TextStyle(
                      color: widget.textColor ?? Colors.white,
                    ),
                    decoration: InputDecoration(
                      counterText:
                          widget.enableCounterText ?? false ? null : "",
                      hintText: widget.hint,
                      prefixIcon: (widget.prefix != null)
                          ? Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              child: widget.prefix,
                            )
                          : null,
                      suffixIcon: (widget.isPasswordField ?? false)
                          ? InkWell(
                              onTap: changeIsShowPassword,
                              child: Icon(
                                isShowPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 22.0,
                                color: Colors.grey.shade600,
                              ),
                            )
                          : (widget.suffix != null)
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 50,
                                  child: widget.suffix,
                                )
                              : null,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: widget.backgroundColor ?? Colors.grey.shade100,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: widget.enableBorderColor ??
                                  Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: widget.focusBorderColor ??
                                  Colors.transparent)),
                      contentPadding: EdgeInsets.only(
                        left: widget.enableContentPadding ?? true
                            ? widget.contentLeftPadding ?? 16
                            : widget.customContentPading,
                        right: widget.enableContentPadding ?? true
                            ? (widget.contentRightPadding ?? 16)
                            : widget.customContentPading,
                        top: widget.contentTopPadding,
                        bottom: widget.contentBottomPading,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.clearSpace ?? true)
            const SizedBox(
              height: 15,
            )
        ],
      ),
    );
  }
}
