import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ViewListStateCode { normal, selecting, unload, loading, empty }

abstract class ViewListCubit extends Cubit<ViewListState> {
  ViewListCubit() : super(const ViewListState());

  /// Get the list of latest books.
  void refresh();

  /// Add the book into the selected list.
  void addSelect(ViewListState state, String name) {
    if (state.selectedSet.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    selectedSet.add(name);
    emit(state.copyWith(code: ViewListStateCode.selecting, selectedSet: selectedSet));
  }

  /// Select all books except those the slide menu is open.
  void allSelect(ViewListState state) {
    emit(state.copyWith(
      code: ViewListStateCode.selecting,
      selectedSet: state.list.toSet(),
      slidedSet: const {},
    ));
  }

  /// Remove the book from the selected list.
  void removeSelect(ViewListState state, String name) {
    if (!state.selectedSet.contains(name)) {
      return;
    }
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    selectedSet.remove(name);
    ViewListStateCode stateCode =
    selectedSet.isNotEmpty ? ViewListStateCode.selecting : ViewListStateCode.normal;
    emit(state.copyWith(code: stateCode, selectedSet: selectedSet));
  }

  /// Clear the selected list.
  void clearSelect(ViewListState state) {
    emit(state.copyWith(code: ViewListStateCode.normal, selectedSet: {}));
  }

  /// Add the item to the sliding set.
  void addSlide(ViewListState state, String data) {
    if (state.slidedSet.contains(data)) {
      return;
    }

    // If the book is selected, remove it from the selection set.
    ViewListStateCode code = state.code;
    Set<String> selectedSet = Set<String>.from(state.selectedSet);
    if (state.selectedSet.contains(data)) {
      selectedSet.remove(data);
      code = selectedSet.isEmpty ? ViewListStateCode.normal : ViewListStateCode.selecting;
    }

    Set<String> slidedSet = Set<String>.from(state.slidedSet);
    slidedSet.add(data);

    emit(state.copyWith(code: code, selectedSet: selectedSet, slidedSet: slidedSet));
  }

  /// Remove the item from the sliding set.
  void removeSlide(ViewListState state, String data) {
    if (!state.slidedSet.contains(data)) {
      return;
    }

    Set<String> slidedSet = Set<String>.from(state.slidedSet);
    slidedSet.remove(data);

    emit(state.copyWith(slidedSet: slidedSet));
  }
}

/// Store the state of the list.
class ViewListState extends Equatable {
  final ViewListStateCode code;
  final List<String> list;
  final Set<String> selectedSet;
  final Set<String> slidedSet;

  const ViewListState({
    this.code = ViewListStateCode.unload,
    this.list = const [],
    this.selectedSet = const {},
    this.slidedSet = const {},
  });

  ViewListState copyWith({
    ViewListStateCode? code,
    List<String>? list,
    Set<String>? selectedSet,
    Set<String>? slidedSet,
  }) {
    return ViewListState(
      code: code ?? this.code,
      list: list ?? this.list,
      selectedSet: selectedSet ?? this.selectedSet,
      slidedSet: slidedSet ?? this.slidedSet,
    );
  }

  @override
  List<Object?> get props => [code, list, selectedSet, slidedSet];
}
