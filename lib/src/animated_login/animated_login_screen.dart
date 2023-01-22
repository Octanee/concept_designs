import 'dart:math';

import 'package:concept_designs/src/animated_login/constants.dart';
import 'package:concept_designs/src/common.dart';

// Size of signUp bar
// This bar take 12% of screen
const _barSize = 0.12;

class AnimatedLoginScreen extends StatefulWidget {
  const AnimatedLoginScreen({super.key});

  @override
  State<AnimatedLoginScreen> createState() => _AnimatedLoginScreenState();
}

class _AnimatedLoginScreenState extends State<AnimatedLoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: defaultDuration,
    );
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void login() {
    logger.i('Login');
  }

  void signUp() {
    logger.i('Sign Up');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, snapshot) {
          return Stack(
            children: [
              // Login
              AnimatedPositioned(
                duration: defaultDuration,
                height: size.height,
                width: size.width * (1 - _barSize),
                left: _isShowSignUp ? -size.width * (1 - _barSize * 2) : 0,
                child: const ColoredBox(
                  color: loginBackground,
                  child: _LoginForm(),
                ),
              ),

              // Sign Up
              AnimatedPositioned(
                duration: defaultDuration,
                height: size.height,
                width: size.width * (1 - _barSize),
                left: _isShowSignUp
                    ? size.width * _barSize
                    : size.width * (1 - _barSize),
                child: const ColoredBox(
                  color: signUpBackground,
                  child: _SignUpForm(),
                ),
              ),

              // Logo
              AnimatedPositioned(
                duration: defaultDuration,
                top: size.height * 0.1,
                left: 0,
                right: _isShowSignUp
                    ? -size.width * _barSize / 2
                    : size.width * _barSize / 2,
                height: 72,
                child: getSvg('logo.svg', color: Colors.white60),
              ),

              // Social media Buttons
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: size.height * 0.1,
                left: 0,
                right: _isShowSignUp
                    ? -size.width * _barSize / 2
                    : size.width * _barSize / 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getSvg(
                      'facebook.svg',
                      height: 72,
                      color: Colors.white60,
                    ),
                    const SizedBox(width: defaultPadding),
                    getSvg(
                      'twitter.svg',
                      height: 72,
                      color: Colors.white60,
                    ),
                    const SizedBox(width: defaultPadding),
                    getSvg(
                      'linkedin.svg',
                      height: 72,
                      color: Colors.white60,
                    ),
                  ],
                ),
              ),

              // Login Text
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _isShowSignUp
                    ? size.height / 2 - size.width / 4
                    : size.height * 0.25,
                left: _isShowSignUp
                    ? 0
                    : size.width * ((1 - _barSize) / 2) - size.width / 4,
                // We need to know the width of this Text
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  style: TextStyle(
                    fontSize: _isShowSignUp ? 20 : 48,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: -_animationTextRotate.value * (pi / 180),
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: _isShowSignUp ? _updateView : login,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.width * _barSize / 4,
                        ),
                        width: size.width / 2,
                        child: Text(
                          'Log In'.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Sign Up Text
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _isShowSignUp
                    ? size.height * 0.25
                    : size.height / 2 - size.width / 4,
                right: _isShowSignUp
                    ? size.width * ((1 - _barSize) / 2) - size.width / 4
                    : 0,
                // We need to know the width of this Text
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  style: TextStyle(
                    fontSize: _isShowSignUp ? 48 : 20,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignUp ? Colors.white70 : Colors.white,
                  ),
                  child: Transform.rotate(
                    angle: (90 - _animationTextRotate.value) * (pi / 180),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: _isShowSignUp ? signUp : _updateView,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.width * _barSize / 4,
                        ),
                        width: size.width / 2,
                        child: Text(
                          'Sign up'.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * _barSize,
      ),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: defaultPadding),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * _barSize,
      ),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Confirm password'),
            ),
          ],
        ),
      ),
    );
  }
}
