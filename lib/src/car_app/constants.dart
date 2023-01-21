import 'package:concept_designs/src/common.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color primaryColor = Color(0xFF53F9FF);
const Color redColor = Color(0xFFFF5368);

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
    'assets/car_app/$name',
    key: key,
    width: width,
    height: height,
    color: color,
  );
}
