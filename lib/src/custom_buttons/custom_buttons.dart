import 'package:concept_designs/src/common.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  onTap: () {},
                  child: const Text('Hello'),
                ),
                const SizedBox(height: 32),
                const CustomButton(
                  duration: Duration(seconds: 3),
                  gradientColor: Colors.green,
                  degrees: 45,
                  child: Text('Hello'),
                ),
                const SizedBox(height: 32),
                const CustomButton(
                  duration: Duration(milliseconds: 3000),
                  gradientColor: Colors.red,
                  degrees: 270,
                  child: Text('Hello'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.child,
    this.onTap,
    this.borderWidth = 6,
    this.borderColor = Colors.white,
    this.gradientColor = Colors.purple,
    this.degrees = 135,
    this.duration = const Duration(milliseconds: 1500),
  });

  final Widget child;
  final Duration duration;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color gradientColor;
  final double borderWidth;
  final double degrees;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: _ButtonPainter(
          animation: _controller,
          borderWidth: widget.borderWidth,
          borderColor: widget.borderColor,
          gradientColor: widget.gradientColor,
          degrees: widget.degrees,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}

class _ButtonPainter extends CustomPainter {
  const _ButtonPainter({
    required this.animation,
    this.borderWidth = 6,
    this.borderColor = Colors.white,
    this.gradientColor = Colors.purple,
    this.degrees = 135,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color borderColor;
  final Color gradientColor;
  final double borderWidth;
  final double degrees;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.drawRect(
      rect.deflate(borderWidth / 2),
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          gradientColor,
          Colors.transparent,
        ],
        stops: const [0.7, 1],
        endAngle: vector.radians(degrees),
        transform: GradientRotation(
          vector.radians(360 * animation.value),
        ),
      ).createShader(rect);

    final path = Path.combine(
      PathOperation.xor,
      Path()..addRect(rect),
      Path()..addRect(rect.deflate(borderWidth)),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ButtonPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_ButtonPainter oldDelegate) => true;
}
