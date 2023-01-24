import 'package:concept_designs/src/batman_sign_up/batman_constants.dart';
import 'package:concept_designs/src/common.dart';

class BatmanCity extends StatelessWidget {
  const BatmanCity({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CityClipper(progress: progress),
      child: Image.asset(
        path('city.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}

class _CityClipper extends CustomClipper<Path> {
  const _CityClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final bottom = w * progress;
    final height = h * progress;

    final path = Path()
      ..moveTo(w / 2, h)
      ..lineTo(w / 2 + bottom / 2, h)
      ..lineTo(w / 2, h - height)
      ..lineTo(w / 2 - bottom / 2, h)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
