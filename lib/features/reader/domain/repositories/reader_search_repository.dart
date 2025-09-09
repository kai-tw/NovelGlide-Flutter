import '../entities/reader_search_result_data.dart';

abstract class ReaderSearchRepository {
  Stream<List<ReaderSearchResultData>> get resultListStream;
  Future<void> dispose();
}
