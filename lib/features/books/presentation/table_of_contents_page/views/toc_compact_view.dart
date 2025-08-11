import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ads_service/domain/entities/ad_unit_id.dart';
import '../../../../ads_service/presentation/advertisement.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_cover.dart';
import '../cubit/toc_cubit.dart';
import '../widgets/toc_book_name.dart';
import '../widgets/toc_cover_banner.dart';
import '../widgets/toc_sliver_list.dart';

class TocCompactView extends StatelessWidget {
  const TocCompactView({
    super.key,
    required this.bookData,
    required this.coverData,
  });

  final Book bookData;
  final BookCover coverData;

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return SafeArea(
      child: Column(
        children: <Widget>[
          const Advertisement(
            unitId: AdUnitId.tableOfContents,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => cubit.refresh(),
              child: PageStorage(
                bucket: cubit.bucket,
                child: Scrollbar(
                  controller: cubit.scrollController,
                  child: CustomScrollView(
                    key: const PageStorageKey<String>('toc-scroll-view'),
                    controller: cubit.scrollController,
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Stack(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1,
                                child: TocCoverBanner(
                                  bookData: bookData,
                                  coverData: coverData,
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TocBookName(bookData: bookData),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 80.0),
                        sliver: TocSliverList(bookData: bookData),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
