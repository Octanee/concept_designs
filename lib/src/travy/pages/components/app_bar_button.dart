import 'dart:ui';

import 'package:concept_designs/src/common.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, required this.icon, this.onTap});

  final VoidCallback? onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: GestureDetector(
        onTap: onTap,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.white.withOpacity(0.6),
            padding: const EdgeInsets.all(16),
            child: icon,
          ),
        ),
      ),
    );
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     shape: const CircleBorder(),
    //     padding: const EdgeInsets.all(12),
    //   ),
    //   onPressed: onTap,
    //   child: icon,
    // );
  }
}
