import 'package:equatable/equatable.dart';

class CollectionAddState extends Equatable {
  const CollectionAddState({
    this.name = '',
  });

  final String name;

  bool get isValid => name.isNotEmpty;

  @override
  List<Object?> get props => <Object?>[name];
}
