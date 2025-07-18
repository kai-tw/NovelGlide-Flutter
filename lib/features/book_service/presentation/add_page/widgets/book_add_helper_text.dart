part of '../../../book_service.dart';

class BookAddHelperText extends StatelessWidget {
  const BookAddHelperText({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String allowedExtensions = BookAddCubit.allowedExtensions.join(', ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        '${appLocalizations.fileTypeHelperText} $allowedExtensions',
        textAlign: TextAlign.center,
      ),
    );
  }
}
