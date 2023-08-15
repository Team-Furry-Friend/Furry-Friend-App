import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:provider/provider.dart';

import '../../domain/providers/search_provider.dart';

class TypeLabel extends StatelessWidget {
  const TypeLabel({
    super.key,
    required this.type,
    required this.isSelectedLabel,
    required this.onTap,
  });

  final String type;
  final bool isSelectedLabel;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            color: isSelectedLabel ? mainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF70A3F3), width: 1)),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 15,
            color: isSelectedLabel ? Colors.white : const Color(0xFF70A3F3),
          ),
        ),
      ),
    );
  }
}

class SearchListLayout extends StatelessWidget {
  const SearchListLayout({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final productList =
        context.select((SearchProvider provider) => provider.productList);
    final isLoadingPage =
        context.select((SearchProvider provider) => provider.isLoadingPage);

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: productList.length + 1,
      itemBuilder: (context, index) {
        if (index < productList.length) {
          final post = productList[index];

          return ListTile(
            title: Text(post.pname),
          );
        } else {
          return isLoadingPage
              ? const CircularProgressIndicator()
              : const SizedBox();
        }
      },
    );
  }
}
