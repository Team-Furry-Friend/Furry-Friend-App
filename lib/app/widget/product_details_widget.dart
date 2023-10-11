import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/product_write_screen.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/model/post/product_image.dart';
import 'package:furry_friend/domain/providers/basket_provider.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductInfoFrame extends StatelessWidget {
  final List<Widget> children;

  final bool dividerVisible;
  const ProductInfoFrame(
      {super.key, required this.children, this.dividerVisible = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            )),
        Visibility(
          visible: dividerVisible,
          child: Divider(
            thickness: 14,
            color: WidgetColor.backgroundColor,
          ),
        )
      ],
    );
  }
}

class ProductReviewLayout extends StatelessWidget {
  const ProductReviewLayout({super.key, required this.reviewWriteOnTap});

  final Function() reviewWriteOnTap;

  @override
  Widget build(BuildContext context) {
    final reviews =
        context.select((PostProvider postProvider) => postProvider.reviewList);

    return ProductInfoFrame(dividerVisible: false, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '상품 문의',
              style: TextStyle(
                color: WidgetColor.mainBlack,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => reviewWriteOnTap(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '문의 작성하기',
                style: TextStyle(
                  color: Color(0xFF868686),
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
      Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Container(
                decoration: BoxDecoration(
                    color: WidgetColor.backgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(top: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        review.text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF868686),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          review.nickname,
                          style: const TextStyle(
                            color: Color(0xFFB8B8B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '   ${DateFormat('yyyy.MM.dd').format(DateTime.parse(review.regDate))}',
                          style: const TextStyle(
                            color: Color(0xFFB8B8B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      )
    ]);
  }
}

class ProductEditItem extends StatelessWidget {
  const ProductEditItem({
    super.key,
    required this.text,
    required this.iconData,
    required this.onTap,
  });

  final String text;
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                iconData,
                color: WidgetColor.mainBlack,
              ),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDeleteAlertDialog extends StatelessWidget {
  const ProductDeleteAlertDialog({super.key, required this.deleteTap});

  final Function() deleteTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("정말 삭제하시겠습니까?"),
      actions: <Widget>[
        TextButton(
          child: const Text("취소"),
          onPressed: () {
            context.pop();
          },
        ),
        TextButton(
          child: const Text(
            "삭제",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => deleteTap(),
        ),
      ],
    );
  }
}

class ProductEditModalBody extends StatelessWidget {
  const ProductEditModalBody({
    super.key,
    required this.product,
  });

  final Post product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          ProductEditItem(
            text: '수정하기',
            iconData: Icons.edit,
            onTap: () {
              context.goNamed('productWrite', extra: product);
            },
          ),
          ProductEditItem(
            text: '삭제하기',
            iconData: Icons.delete_forever,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return ProductDeleteAlertDialog(
                      deleteTap: () {
                        dialogContext.pop();
                        context
                            .read<PostProvider>()
                            .deletePost(product.pid, context);
                      },
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class ProductDetailsAction extends StatelessWidget {
  const ProductDetailsAction({
    super.key,
    required this.product,
  });

  final Post product;

  @override
  Widget build(BuildContext context) {
    final myBasketProduct = context
        .select((BasketProvider basketProvider) => basketProvider.myBasket);
    final basket = myBasketProduct
        .where((element) => element.pid == product.pid)
        .firstOrNull;
    final isMyProduct =
        product.mid == PrefsUtils.getInt(PrefsUtils.utils.userId);

    return InkWell(
      onTap: () {
        if (isMyProduct) {
          showModalBottomSheet(
              useSafeArea: true,
              context: context,
              builder: (_) {
                return ProductEditModalBody(product: product);
              });
        } else {
          if (basket != null) {
            context.read<BasketProvider>().deleteBasket(basket!.bid);
          } else {
            context.read<BasketProvider>().postBasket(product.pid);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Icon(
          isMyProduct
              ? Icons.more_vert
              : (basket != null
                  ? Icons.favorite
                  : Icons.favorite_border_rounded),
          color: isMyProduct
              ? WidgetColor.mainBlack
              : (basket != null
                  ? WidgetColor.mainColor
                  : WidgetColor.mainBlack),
        ),
      ),
    );
  }
}
