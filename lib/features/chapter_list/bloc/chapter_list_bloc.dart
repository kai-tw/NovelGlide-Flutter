import 'package:novelglide/ui/components/view_list/bloc.dart';

class ChapterListCubit extends ViewListCubit {
  ChapterListCubit() : super();

  String? bookName;

  @override
  void refresh() {
    if (bookName == null) {
      return;
    }
  }
}
