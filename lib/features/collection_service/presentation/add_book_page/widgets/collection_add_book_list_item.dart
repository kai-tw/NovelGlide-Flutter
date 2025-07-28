part of '../../../collection_service.dart';

class CollectionAddBookListItem extends StatelessWidget {
  const CollectionAddBookListItem({
    super.key,
    required this.data,
    this.isSelected,
  });

  final CollectionData data;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final CollectionAddBookCubit cubit =
        BlocProvider.of<CollectionAddBookCubit>(context);

    return CheckboxListTile(
      contentPadding: const EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
      title: Text(data.name),
      secondary: const Icon(Icons.folder),
      tristate: true,
      value: isSelected,
      onChanged: (bool? value) {
        if (value == true) {
          cubit.select(data);
        } else {
          cubit.deselect(data);
        }
      },
    );
  }
}
