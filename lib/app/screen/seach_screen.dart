import 'package:flutter/material.dart';

import '../../domain/providers/post_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PostProvider postProvider = PostProvider();

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(nextPageLoad);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(nextPageLoad);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void nextPageLoad() {
    if (postProvider.hasNextPage &&
        !postProvider.isFirstLoading &&
        !postProvider.isLoadingPage &&
        _controller.position.extentAfter < 100) {
      postProvider.isLoadingPage = true;
      postProvider.getPostKeyWord(20, '사료', '사료');
    }
  }
}
