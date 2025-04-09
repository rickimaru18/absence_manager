import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

typedef OnRefresh = Future<void> Function();
typedef OnNext = Future<void> Function();

class PaginatedListView extends StatefulWidget {
  const PaginatedListView({
    this.onRefresh,
    required this.onNext,
    this.hasNextPage = false,
    required this.child,
    this.loadingIndicator,
    super.key,
  });

  final OnRefresh? onRefresh;
  final OnNext onNext;
  final bool hasNextPage;
  final SliverList child;
  final Widget? loadingIndicator;

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final ScrollController _controller = ScrollController();

  bool _isNextOngoing = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_isNextOngoing) {
      return;
    }

    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _isNextOngoing = true;
      await widget.onNext();
      _isNextOngoing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
    );
  }
}
