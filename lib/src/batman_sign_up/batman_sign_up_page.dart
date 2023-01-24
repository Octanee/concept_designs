import 'package:concept_designs/src/batman_sign_up/batman_constants.dart';
import 'package:concept_designs/src/batman_sign_up/components/batman_button.dart';
import 'package:concept_designs/src/batman_sign_up/components/batman_city.dart';
import 'package:concept_designs/src/batman_sign_up/components/batman_input.dart';
import 'package:concept_designs/src/common.dart';
import 'package:google_fonts/google_fonts.dart';

class BatmanSignUpPage extends StatefulWidget {
  const BatmanSignUpPage({super.key});

  @override
  State<BatmanSignUpPage> createState() => _BatmanSignUpPageState();
}

class _BatmanSignUpPageState extends State<BatmanSignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _batmanSlideAnimation;
  late Animation<double> _cityAnimation;
  late Animation<double> _formAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _batmanSlideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.2,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );
    _cityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.ease,
        ),
      ),
    );
    _formAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.8,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Theme(
      data: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.vidalokaTextTheme(),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                //* ------------------------------
                //* Background
                //* ------------------------------
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: size.height * 0.5,
                  child: Hero(
                    tag: 'batman_background',
                    child: Image.asset(
                      path('batman_background.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                //* ------------------------------
                //* Batman
                //* ------------------------------
                Positioned(
                  top: size.height * 0.1 * _batmanSlideAnimation.value,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'batman_alone',
                    child: Column(
                      children: [
                        Image.asset(
                          path('batman_alone.png'),
                          fit: BoxFit.contain,
                        ),
                        Container(
                          height: size.height * 2,
                          color: backgroundColor,
                        )
                      ],
                    ),
                  ),
                ),
                //* ------------------------------
                //* Stars
                //* ------------------------------
                Positioned(
                  top: size.height * 0.3,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'batman_stars',
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        path('batman_stars.png'),
                      ),
                    ),
                  ),
                ),
                //* ------------------------------
                //* City
                //* ------------------------------
                Positioned(
                  top: size.height * 0.25,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: BatmanCity(progress: _cityAnimation.value),
                ),
                //* ------------------------------
                //* Form
                //* ------------------------------
                Positioned(
                  bottom: (-size.height * 0.05 * _formAnimation.value) +
                      size.height * 0.05,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: Opacity(
                    opacity: 1 - _formAnimation.value,
                    child: Column(
                      children: [
                        const Text(
                          'GET ACCESS',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'CREATE ACCOUNT FOR GET PASSES',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white54,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const BatmanInput(label: 'FULL NAME'),
                        const SizedBox(height: 16),
                        const BatmanInput(label: 'EMAIL'),
                        const SizedBox(height: 16),
                        const BatmanInput(
                          label: 'PASSWORD',
                          obscure: true,
                        ),
                        const SizedBox(height: 16),
                        BatmanButton(
                          text: 'SIGNUP',
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
