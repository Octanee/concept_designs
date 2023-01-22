import 'package:concept_designs/src/common.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color loginBackground = Color(0xFF00C470);
const Color signUpBackground = Color(0xFF000A54);

const double defaultPadding = 16;
const Duration defaultDuration = Duration(milliseconds: 300);

Widget getSvg(
  String name, {
  Key? key,
  double? height,
  double? width,
  Color? color,
}) {
  return SvgPicture.asset(
    'assets/animated_login/$name',
    key: key,
    width: width,
    height: height,
    color: color,
  );
}
