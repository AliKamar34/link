import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_grid_view.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    required this.isGrid,
    required this.companies,
    this.hasMore,
    this.isLoadingMore,
    this.onLoadMore,
    this.onToggleFavorite,
  });

  final bool isGrid;
  final List<Company> companies;
  final bool? hasMore;
  final bool? isLoadingMore;
  final VoidCallback? onLoadMore;
  final Function(int)? onToggleFavorite;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    final isScrollingDown =
        _scrollController.position.userScrollDirection ==
        ScrollDirection.reverse;
    if (isScrollingDown &&
        _isBottom &&
        (widget.hasMore ?? false) &&
        !(widget.isLoadingMore ?? false)) {
      widget.onLoadMore?.call();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        children: [
          widget.isGrid
              ? Expanded(
                  child: CustomGridView(
                    isLoadingMore: widget.isLoadingMore ?? false,

                    companies: widget.companies,
                    scrollController: _scrollController,
                    onToggleFavorite: widget.onToggleFavorite,
                  ),
                )
              : Expanded(
                  child: CustomListView(
                    isLoadingMore: widget.isLoadingMore ?? false,
                    companies: widget.companies,
                    scrollController: _scrollController,
                    onToggleFavorite: widget.onToggleFavorite,
                  ),
                ),
        ],
      ),
    );
  }
}
