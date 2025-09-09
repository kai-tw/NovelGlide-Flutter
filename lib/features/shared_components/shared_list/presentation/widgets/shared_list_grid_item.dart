part of '../../shared_list.dart';

class SharedListGridItem extends StatelessWidget {
  const SharedListGridItem({
    super.key,
    required this.isSelecting,
    required this.isSelected,
    this.onChanged,
    required this.cover,
    required this.title,
    required this.semanticLabel,
  });

  final bool isSelecting;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final Widget cover;
  final Widget title;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: cover,
              ),
              Expanded(
                child: title,
              ),
            ],
          ),
        ),

        // Checkbox
        Positioned(
          top: 0.0,
          left: 0.0,
          child: SimpleFadeSwitcher(
            child: _buildCheckbox(context),
          ),
        ),
      ],
    );
  }

  /// Checkbox widgets builder
  Widget? _buildCheckbox(BuildContext context) {
    if (isSelecting) {
      return Checkbox(
        value: isSelected,
        onChanged: onChanged,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        semanticLabel: semanticLabel,
      );
    }

    return null;
  }
}
