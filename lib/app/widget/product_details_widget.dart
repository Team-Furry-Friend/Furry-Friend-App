import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductInfoFrame extends StatelessWidget {
  const ProductInfoFrame(
      {super.key, required this.children, this.dividerVisible = true});

  final List<Widget> children;
  final bool dividerVisible;

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
          child: const Divider(
            thickness: 14,
            color: backgroundColor,
          ),
        )
      ],
    );
  }
}

class ProductReviewLayout extends StatelessWidget {
  const ProductReviewLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final reviews = context.select((PostProvider postProvider) => postProvider.reviewList);

    return ProductInfoFrame(dividerVisible: false, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Text(
              '상품 문의',
              style: TextStyle(
                color: mainBlack,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            child: const Text(
              '문의 작성하기',
              style: TextStyle(
                color: Color(0xFF868686),
                fontSize: 14,
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
            itemBuilder: (context, index){
              final review = reviews[index];
              return Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16)
                ),
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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