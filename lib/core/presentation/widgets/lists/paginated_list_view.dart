import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

class PaginatedListView extends StatefulWidget {
  const PaginatedListView({
    this.onRefresh,
    required this.onNext,
    this.nextPageRatio = 1,
    this.hasNextPage = false,
    required this.child,
    this.loadingIndicator,
    super.key,
  }) : assert(
          nextPageRatio >= 0 && nextPageRatio <= 1,
          '[nextPageRatio] should be between 0...1',
        );

  final Future<void> Function()? onRefresh;
  final VoidCallback onNext;
  final double nextPageRatio;
  final bool hasNextPage;
  final SliverList child;
  final Widget? loadingIndicator;

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final ScrollController _controller = ScrollController();

  double _currentMaxScrollExtent = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.position.maxScrollExtent == 0 && widget.hasNextPage) {
        widget.onNext();
      }
    });
  }

  bool _onNotification(ScrollNotification notification) {
    if (!widget.hasNextPage) {
      return false;
    }

    final double maxScrollExtent =
        notification.metrics.maxScrollExtent * widget.nextPageRatio;

    if (notification.metrics.pixels >= maxScrollExtent &&
        _currentMaxScrollExtent < maxScrollExtent) {
      _currentMaxScrollExtent = maxScrollExtent;
      widget.onNext();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: CustomScrollView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          if (widget.onRefresh != null)
            CupertinoSliverRefreshControl(
              onRefresh: widget.onRefresh,
            ),
          widget.child,
          if (widget.hasNextPage)
            SliverToBoxAdapter(
              child: Center(
                child: widget.loadingIndicator ??
                    const Padding(
                      padding: EdgeInsets.all(Dimens.d12),
                      child: CircularProgressIndicator(),
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
