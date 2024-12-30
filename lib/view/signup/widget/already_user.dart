

import 'package:flutter/material.dart';

import '../../../configs/routes/routes_name.dart';

class AlreadyUser extends StatelessWidget {
  const AlreadyUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.login);
          },
          child: const Text('Login'),
        )
      ],
    );
  }
}