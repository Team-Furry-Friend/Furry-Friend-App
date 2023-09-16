import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/product_details_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/domain/model/basket/basket.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
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
            child: Icon(
              Icons.search,
              color: WidgetColor.mainColor,
              size: 28,
            ),
          )
        ],
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
    final myBasketProduct = context
        .select((BasketProvider basketProvider) => basketProvider.myBasket);

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: productList.length + 1,
      itemBuilder: (context, index) {
        if (index < productList.length) {
          final product = productList[index];
          final basket =
              myBasketProduct.where((element) => element.pid == product.pid);
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(pid: product.pid)));
              },
              child: SearchListItem(
                product: product,
                basket: basket.firstOrNull,
              ));
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
  const SearchListItem({super.key, required this.product, this.basket});

  final Post product;
  final Basket? basket;

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
                  image: product.imageDTOList.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(product.imageDTOList.first.path),
                          fit: BoxFit.cover)
                      : null,
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
                            style: TextStyle(
                              color: WidgetColor.mainBlack,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (basket != null) {
                            context
                                .read<BasketProvider>()
                                .deleteBasket(basket!.bid);
                          } else {
                            context
                                .read<BasketProvider>()
                                .postBasket(product.pid);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            basket != null
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: basket != null
                                ? WidgetColor.mainColor
                                : lightGray,
                          ),
                        ),
                      ),
                      Text(
                        '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(product.pprice)}원',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: WidgetColor.mainBlack,
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
