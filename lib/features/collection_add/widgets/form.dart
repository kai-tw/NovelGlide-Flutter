part of '../collection_add_dialog.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return const Form(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleText(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: _NameField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CancelButton(),
                _SubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
