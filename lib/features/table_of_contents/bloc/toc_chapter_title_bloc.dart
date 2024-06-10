import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';

class TOCChapterTitleCubit extends Cubit<TOCChapterTitleState> {
  final ChapterData chapterData;

  TOCChapterTitleCubit(this.chapterData) : super(const TOCChapterTitleState());

  void refresh() async {
    final String title = await chapterData.getTitleFromCache();
    emit(state.copyWith(title: title));
  }
}

class TOCChapterTitleState extends Equatable {
  final String title;

  @override
  List<Object?> get props => [title];

  const TOCChapterTitleState({this.title = ""});

  TOCChapterTitleState copyWith({String? title}) {
    return TOCChapterTitleState(title: title ?? this.title);
  }
}