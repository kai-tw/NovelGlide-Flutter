part of '../list_template.dart';

class CommonListDeleteButton extends StatelessWidget {
  const CommonListDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: const Icon(Icons.delete_rounded),
      title: Text(appLocalizations.generalDelete),
    );
  }

  static PopupMenuItem<dynamic> helper({
    required BuildContext context,
    void Function()? onDelete,
    bool enabled = true,
  }) {
    return PopupMenuItem(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CommonDeleteDialog(onDelete: onDelete);
          },
        );
      },
      enabled: enabled,
      child: const CommonListDeleteButton(),
    );
  }
}
