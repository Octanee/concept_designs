// ignore_for_file: lines_longer_than_80_chars

import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/custom_snackbar/custom_snackbar.dart';

class CustomSnackbarPage extends StatelessWidget {
  const CustomSnackbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            ElevatedButton(
              onPressed: () => CustomSnackbar.showSnackbar(
                context,
                title: 'Well done!',
                message: 'You have successfully completed the form. Good job!',
              ),
              child: const Text('Success'),
            ),
            ElevatedButton(
              onPressed: () => CustomSnackbar.showSnackbar(
                context,
                title: 'Hi there!',
                message: 'Do you have a problem? Just use this contact form.',
                type: CustomSnackbarType.help,
              ),
              child: const Text('Help'),
            ),
            ElevatedButton(
              onPressed: () => CustomSnackbar.showSnackbar(
                context,
                title: 'Warning!',
                message: 'Sorry! There was a problem with your request.',
                type: CustomSnackbarType.warning,
              ),
              child: const Text('Warning'),
            ),
            ElevatedButton(
              onPressed: () => CustomSnackbar.showSnackbar(
                context,
                title: 'Oh Snap!',
                message:
                    'You have failed to read this failure message. Please try again!',
                type: CustomSnackbarType.failure,
              ),
              child: const Text('Failure'),
            ),
          ],
        ),
      ),
    );
  }
}
