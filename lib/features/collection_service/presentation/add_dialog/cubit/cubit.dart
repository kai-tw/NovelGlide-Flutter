part of '../collection_add_dialog.dart';

class _Cubit extends Cubit<_State> {
  _Cubit() : super(const _State());

  void setName(String? name) => emit(_State(name: name));

  void submit() {
    if (state.name?.isNotEmpty ?? false) {
      CollectionService.repository.create(state.name!);
    }
  }
}

class _State extends Equatable {
  const _State({this.name});

  final String? name;

  @override
  List<Object?> get props => <Object?>[name];
}
