import 'package:collection/collection.dart';

import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../preference/domain/entities/shared_list_preference_data.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/bookmark_data.dart';
import '../../../domain/use_cases/bookmark_delete_data_use_case.dart';
import '../../../domain/use_cases/bookmark_get_list_use_case.dart';
import '../../../domain/use_cases/bookmark_observe_change_use_case.dart';

typedef BookmarkListState = SharedListState<BookmarkData>;

class BookmarkListCubit extends SharedListCubit<BookmarkData> {
  factory BookmarkListCubit(
    BookmarkGetListUseCase getListUseCase,
    BookmarkDeleteDataUseCase deleteDataUseCase,
    BookmarkObserveChangeUseCase observeChangeUseCase,
  ) {
    final BookmarkListCubit cubit = BookmarkListCubit._(
      getListUseCase,
      deleteDataUseCase,
    );

    // Refresh at first
    cubit.refresh();

    // Listen to bookmarks changes.
    cubit.onRepositoryChangedSubscription =
        observeChangeUseCase().listen((_) => cubit.refresh());

    // Listen to bookmark list preference changes.
    cubit.onPreferenceChangedSubscription = PreferenceService
        .bookmarkList.onChangedController.stream
        .listen((_) => cubit.refreshPreference());

    return cubit;
  }

  BookmarkListCubit._(
    this._getListUseCase,
    this._deleteDataUseCase,
  ) : super(const SharedListState<BookmarkData>());

  /// Use cases
  final BookmarkGetListUseCase _getListUseCase;
  final BookmarkDeleteDataUseCase _deleteDataUseCase;

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final SharedListPreferenceData preference =
        await PreferenceService.bookmarkList.load();

    // Load bookmark list.
    emit(BookmarkListState(
      code: LoadingStateCode.loaded,
      dataList: sortList(
        await _getListUseCase(),
        preference.sortOrder,
        preference.isAscending,
      ),
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }

  Future<void> deleteBookmark(BookmarkData data) {
    return _deleteDataUseCase(<BookmarkData>{data});
  }

  void deleteSelectedBookmarks() {
    _deleteDataUseCase(state.selectedSet);
  }

  @override
  int sortCompare(
    BookmarkData a,
    BookmarkData b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  }) {
    switch (sortOrder) {
      case SortOrderCode.name:
        return isAscending
            ? compareNatural(a.bookIdentifier, b.bookIdentifier)
            : compareNatural(b.bookIdentifier, a.bookIdentifier);

      default:
        return isAscending
            ? a.savedTime.compareTo(b.savedTime)
            : b.savedTime.compareTo(a.savedTime);
    }
  }

  @override
  void savePreference() {
    PreferenceService.bookmarkList.save(SharedListPreferenceData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }

  @override
  Future<void> refreshPreference() async {
    final SharedListPreferenceData preference =
        await PreferenceService.bookmarkList.load();
    emit(state.copyWith(
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }
}
