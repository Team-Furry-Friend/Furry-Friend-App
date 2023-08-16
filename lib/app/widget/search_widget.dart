import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/providers/search_provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.searchOnTap,
  });

  final TextEditingController controller;
  final Function() searchOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: lightGray),
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFF2F2F2)),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: '건식 사료',
                hintStyle: TextStyle(color: Color(0xB26E6E6E)),
                border: InputBorder.none),
          )),
          GestureDetector(
            onTap: () => searchOnTap(),
            child: const Icon(
              Icons.search,
              color: mainColor,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}

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
      padding: EdgeInsets.zero,
      itemCount: productList.length + 1,
      itemBuilder: (context, index) {
        if (index < productList.length) {
          final product = productList[index];

          return SearchListItem(product: product);
        } else {
          return isLoadingPage
              ? const CircularProgressIndicator()
              : const SizedBox();
        }
      },
    );
  }
}

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    super.key,
    required this.product,
  });

  final Post product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Container(
                width: 108,
                height: 108,
                margin: const EdgeInsets.only(right: 18),
                decoration: ShapeDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product.imageDTOList.first.path),
                      fit: BoxFit.cover),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 108,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            product.pname,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: mainBlack,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: lightGray,
                          ),
                        ),
                      ),
                      Text(
                        '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(product.pprice)}원',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: mainBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: Colors.black45,
          height: 1,
        )
      ],
    );
  }
}
