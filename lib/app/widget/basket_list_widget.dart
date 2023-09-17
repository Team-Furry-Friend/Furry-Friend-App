import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/product_details_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/domain/model/basket/basket.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(pid: basket.pid)));
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BasketListItem(
                  basket: basket,
                )));
      },
    );
  }
}

class BasketListItem extends StatelessWidget {
  const BasketListItem({super.key, required this.basket});

  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 82,
            height: 82,
            margin: const EdgeInsets.only(right: 18),
            decoration: ShapeDecoration(
              image: basket.image != null && basket.image!.path.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(basket.image!.path),
                      fit: BoxFit.cover)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          basket.pname,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      SquareTypeLabel(
                        category: basket.pcategory,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
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
                    Text(
                      '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(basket.pprice)}원',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: WidgetColor.mainBlack,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
