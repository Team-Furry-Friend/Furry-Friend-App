import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/product_details_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/domain/model/basket/basket.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'widget_color.dart';

class PopularPostLayout extends StatelessWidget {
  const PopularPostLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final postList =
        context.select((PostProvider provider) => provider.postList);
    final myBasketProduct = context
        .select((BasketProvider basketProvider) => basketProvider.myBasket);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '최근 인기 상품 🚀',
                style: TextStyle(
                  color: WidgetColor.mainBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const RoundBlueButton(text: '모두보기'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              final post = postList[index];
              final basket =
                  myBasketProduct.where((element) => element.pid == post.pid);

              return GestureDetector(
                child: HomeListItem(
                  post: post,
                  basket: basket.firstOrNull,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(pid: post.pid)));
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class RoundBlueButton extends StatelessWidget {
  const RoundBlueButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: ShapeDecoration(
          color: WidgetColor.lightMainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: WidgetColor.mainColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class HomeListItem extends StatelessWidget {
  const HomeListItem({super.key, required this.post, this.basket});

  final Post post;
  final Basket? basket;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      constraints: const BoxConstraints(minHeight: 200),
      decoration: BoxDecoration(
        border: Border.all(
          color: deepGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            image: NetworkImage(post.imageDTOList.first.path),
            fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.black12, Colors.transparent])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.pname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SquareTypeLabel(category: post.pcategory),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    if (basket != null) {
                      context.read<BasketProvider>().deleteBasket(basket!.bid);
                    } else {
                      context.read<BasketProvider>().postBasket(post.pid);
                    }
                  },
                  child: Icon(
                    basket != null
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,
                    color: lightGray,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Text(
                    '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(post.pprice)}원',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TypeRowItem extends StatelessWidget {
  const TypeRowItem({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
          border: Border.all(color: lightGray, width: 1),
          borderRadius: BorderRadius.circular(12),
          color: WidgetColor.cleanWhite),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: typeIcon(type),
          ),
          Text(
            type,
            style: TextStyle(
              color: WidgetColor.mainBlack,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Icon typeIcon(String type) {
    switch (type) {
      case '사료':
        return const Icon(Icons.restaurant_rounded);
      case '간식':
        return const Icon(Icons.emoji_emotions_outlined);
      case '용품':
        return const Icon(Icons.card_travel_rounded);
      case '의류':
        return const Icon(Icons.checkroom_rounded);
    }
    return const Icon(Icons.wb_cloudy_sharp);
  }
}
