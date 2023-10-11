import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/product_details_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/domain/model/basket/basket.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BasketListLayout extends StatelessWidget {
  const BasketListLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final basketList =
        context.select((BasketProvider provider) => provider.myBasket);

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: basketList.length,
      itemBuilder: (context, index) {
        final basket = basketList[index];
        return GestureDetector(
            onTap: () {
              context.goNamed('productDetails',
                  pathParameters: {"pid": "${basket.pid}"});
            },
            child: BasketListItem(
              basket: basket,
            ));
      },
    );
  }
}

class BasketListItem extends StatelessWidget {
  const BasketListItem({super.key, required this.basket});

  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                margin: const EdgeInsets.only(right: 18),
                decoration: BoxDecoration(
                  image: basket.image != null && basket.image!.path.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(basket.image!.path),
                          fit: BoxFit.cover)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: lightGray),
                ),
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 84),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        basket.pname,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SquareTypeLabel(
                                category: basket.pcategory,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<BasketProvider>()
                                        .deleteBasket(basket!.bid);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: WidgetColor.mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(basket.pprice)}원',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: WidgetColor.mainBlack,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
