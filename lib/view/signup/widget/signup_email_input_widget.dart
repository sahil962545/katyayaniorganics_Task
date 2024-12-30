import 'package:bloc_clean_coding/bloc/signup_bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget representing the email input field.
class SignupEmailInput extends StatelessWidget {
  const SignupEmailInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2
              )
            ),
            icon: Icon(Icons.email), // Icon for email input field
            labelText: "Email", // Label text for email input field
            helperText: "A complete, valid email e.g. joe@gmail.com", // Helper text for email input field
          ),
          keyboardType: TextInputType.emailAddress, // Setting keyboard type to email address
          onChanged: (value) {
            // Dispatching EmailChanged event when email input changes
            context.read<SignupBloc>().add(EmailChanged(email: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter email';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
