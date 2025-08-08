part of '../../../collection_service.dart';

class CollectionAddState extends Equatable {
  const CollectionAddState({
    this.name = '',
  });

  final String name;

  bool get isValid => name.isNotEmpty;

  @override
  List<Object?> get props => <Object?>[name];
}
