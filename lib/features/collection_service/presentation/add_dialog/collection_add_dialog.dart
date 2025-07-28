part of '../../collection_service.dart';

class CollectionAddDialog extends StatelessWidget {
  const CollectionAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: WindowSize.compact.maxWidth),
        child: BlocProvider<CollectionAddCubit>(
          create: (_) => CollectionAddCubit(),
          child: const CollectionAddForm(),
        ),
      ),
    );
  }
}
