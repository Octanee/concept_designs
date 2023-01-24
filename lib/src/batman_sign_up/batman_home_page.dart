import 'package:concept_designs/src/batman_sign_up/batman_constants.dart';
import 'package:concept_designs/src/batman_sign_up/batman_sign_up_page.dart';
import 'package:concept_designs/src/batman_sign_up/components/batman_button.dart';
import 'package:concept_designs/src/common.dart';

class BatmanHomePage extends StatefulWidget {
  const BatmanHomePage({super.key});

  @override
  State<BatmanHomePage> createState() => _BatmanHomePageState();
}

class _BatmanHomePageState extends State<BatmanHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoInAnimation;
  late Animation<double> _welcomeInAnimation;
  late Animation<double> _slideInAnimation;

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
    _logoInAnimation = Tween<double>(begin: 30, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.1,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );
    _welcomeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.4,
          0.8,
          curve: Curves.easeOut,
        ),
      ),
    );
    _slideInAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.85,
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

  void _onSignUp({required BuildContext context}) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const BatmanSignUpPage(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
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
                top: (-size.height) * _slideInAnimation.value,
                left: 0,
                right: 0,
                child: Hero(
                  tag: 'batman_alone',
                  child: Column(
                    children: [
                      Transform(
                        transform: Matrix4.identity()
                          ..scale(
                            _slideInAnimation.value + 1,
                          ),
                        child: Image.asset(
                          path('batman_alone.png'),
                          fit: BoxFit.contain,
                        ),
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
                    opacity: _welcomeInAnimation.value / 5,
                    child: Image.asset(
                      path('batman_stars.png'),
                    ),
                  ),
                ),
              ),
              //* ------------------------------
              //* Texts
              //* ------------------------------
              Positioned(
                top: size.height * 0.55,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _welcomeInAnimation.value,
                  child: Column(
                    children: const [
                      Text(
                        'WELCOME TO',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'GOTHAM CITY',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'YOU NEED ACCESS TO ENTER THE CITY',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //* ------------------------------
              //* Buttons
              //* ------------------------------
              Positioned(
                bottom: (-size.height * 0.3 * _slideInAnimation.value) +
                    size.height * 0.1,
                left: size.width * 0.1,
                right: size.width * 0.1,
                child: Opacity(
                  opacity: 1 - _slideInAnimation.value,
                  child: Column(
                    children: [
                      BatmanButton(
                        text: 'LOGIN',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      BatmanButton(
                        text: 'SIGNUP',
                        isLeft: false,
                        onTap: () => _onSignUp(context: context),
                      ),
                    ],
                  ),
                ),
              ),
              //* ------------------------------
              //* Logo
              //* ------------------------------
              Positioned(
                top: (size.height * 0.5 * (1 - _welcomeInAnimation.value))
                    .clamp(size.height * 0.4, size.height * 0.5),
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: _logoInAnimation.value,
                  child: Image.asset(
                    path('batman_logo.png'),
                    height: size.height * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
