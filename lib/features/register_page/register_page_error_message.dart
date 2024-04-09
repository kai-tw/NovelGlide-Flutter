import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_page_bloc.dart';

class RegisterPageErrorMessage extends StatelessWidget {
  const RegisterPageErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterPageCubit, RegisterPageState>(builder: (context, state) {
      if (state.code == RegisterPageStateCode.otherError) {
        return Container(
          margin: const EdgeInsets.only(bottom: 24.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            state.errorMessage ?? 'An unexpected error occurred.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        );
      }

      return const SizedBox();
    });
  }
}
