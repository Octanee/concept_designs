import 'package:concept_designs/src/batman_sign_up/batman_constants.dart';
import 'package:concept_designs/src/common.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BatmanButton extends StatelessWidget {
  const BatmanButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLeft = true,
  });

  final VoidCallback onTap;
  final String text;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      color: yellow,
      child: InkWell(
        onTap: onTap,
        child: ClipRect(
          child: SizedBox(
            height: 64,
            child: Stack(
              children: [
                Visibility(
                  visible: isLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(-32.0)
                        ..rotateZ(vector.radians(40)),
                      child: Image.asset(
                        path('batman_logo.png'),
                        fit: BoxFit.contain,
                        height: 64,
                        color: yellowSecondary,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLeft,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(32.0)
                        ..rotateZ(vector.radians(-40)),
                      child: Image.asset(
                        path('batman_logo.png'),
                        fit: BoxFit.contain,
                        height: 64,
                        color: yellowSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
