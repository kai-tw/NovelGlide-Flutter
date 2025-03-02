part of '../book_add_dialog.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocProvider(
          create: (context) => BookAddCubit(),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _InfoTile(),
              _HelperText(),
              OverflowBar(
                alignment: MainAxisAlignment.spaceBetween,
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: 10.0,
                children: [
                  _PickFileButton(),
                  _SubmitButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
