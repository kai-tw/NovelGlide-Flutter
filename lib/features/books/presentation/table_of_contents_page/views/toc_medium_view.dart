import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ads_service/ad_service.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_cover.dart';
import '../cubit/toc_cubit.dart';
import '../widgets/toc_book_name.dart';
import '../widgets/toc_cover_banner.dart';
import '../widgets/toc_sliver_list.dart';

class TocMediumView extends StatelessWidget {
  const TocMediumView({
    super.key,
    required this.bookData,
    required this.coverData,
  });

  final Book bookData;
  final BookCover coverData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: <Widget>[
              Container(
                width: constraints.maxWidth * 0.382,
                height: constraints.maxHeight,
                padding: const EdgeInsets.all(16.0),
                child: _buildLeftColumn(),
              ),
              Expanded(
                child: _buildRightColumn(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              TocCoverBanner(
                bookData: bookData,
                coverData: coverData,
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
        const Advertisement(
          unitId: AdUnitId.tableOfContents,
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<TocCubit>(context).refresh(),
      child: PageStorage(
        bucket: cubit.bucket,
        child: Scrollbar(
          controller: cubit.scrollController,
          child: CustomScrollView(
            key: const PageStorageKey<String>('toc-scroll-view'),
            controller: cubit.scrollController,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 80.0),
                sliver: TocSliverList(bookData: bookData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
