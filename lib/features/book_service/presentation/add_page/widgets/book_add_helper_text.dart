import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubit/book_add_cubit.dart';

class BookAddHelperText extends StatelessWidget {
  const BookAddHelperText({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);
    final String allowedExtensions = cubit.allowedExtensions.join(', ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        '${appLocalizations.fileTypeHelperText} $allowedExtensions',
        textAlign: TextAlign.center,
      ),
    );
  }
}
