import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/book_wizard_bloc.dart';

class BookWizard extends StatelessWidget {
  const BookWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookWizardCubit(),
      child: Text("ouo"),
    );
  }
}