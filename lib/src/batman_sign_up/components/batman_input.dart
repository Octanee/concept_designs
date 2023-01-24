import 'package:concept_designs/src/batman_sign_up/batman_constants.dart';
import 'package:concept_designs/src/common.dart';

class BatmanInput extends StatefulWidget {
  const BatmanInput({
    super.key,
    required this.label,
    this.obscure = false,
  });

  final String label;
  final bool obscure;

  @override
  State<BatmanInput> createState() => _BatmanInputState();
}

class _BatmanInputState extends State<BatmanInput> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white60,
      ),
    );
    return TextField(
      style: const TextStyle(color: yellow),
      obscureText: isObscure,
      cursorColor: yellow,
      decoration: InputDecoration(
        suffixIcon: widget.obscure
            ? InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    path('batman_logo.png'),
                    height: 8,
                    color: isObscure ? null : yellow,
                  ),
                ),
              )
            : null,
        labelText: widget.label,
        filled: true,
        fillColor: backgroundColor,
        labelStyle: const TextStyle(color: Colors.white60),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
