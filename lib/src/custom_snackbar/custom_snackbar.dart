import 'package:concept_designs/src/common.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CustomSnackbarType {
  success(
    path: 'assets/custom_snackbar/success.svg',
    color: Colors.green,
  ),
  help(
    path: 'assets/custom_snackbar/help.svg',
    color: Colors.indigo,
  ),
  warning(
    path: 'assets/custom_snackbar/warning.svg',
    color: Colors.amber,
  ),
  failure(
    path: 'assets/custom_snackbar/failure.svg',
    color: Colors.deepOrange,
  );

  const CustomSnackbarType({required this.path, required this.color});

  final String path;
  final Color color;
}

class CustomSnackbar {
  static void showSnackbar(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onTap,
    CustomSnackbarType type = CustomSnackbarType.success,
    Color? backgroundColor,
    Color? bublesColor,
    double radius = 16,
    double darkness = 0.15,
    Duration duration = const Duration(seconds: 5),
  }) {
    final size = MediaQuery.of(context).size;

    final hsl = HSLColor.fromColor(backgroundColor ?? type.color);
    final colorDark = bublesColor ??
        hsl.withLightness((hsl.lightness - darkness).clamp(0, 1)).toColor();
    final color = hsl.toColor();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SvgPicture.asset(
                        'assets/custom_snackbar/bubles.svg',
                        color: colorDark,
                        height: size.height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                          bottom: size.height * 0.01,
                          right: size.width * 0.05,
                          left: size.width * 0.15,
                        ),
                        child: Wrap(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              message,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: size.height * 0.016,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -size.height * 0.02,
                left: size.width * 0.025,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/custom_snackbar/back.svg',
                      color: colorDark,
                      height: size.height * 0.05,
                    ),
                    Positioned(
                      top: size.height * 0.01,
                      child: SvgPicture.asset(
                        type.path,
                        color: Colors.white,
                        height: size.height * 0.025,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
