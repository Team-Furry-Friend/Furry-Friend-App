import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/product_details_widget.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.post});

  final Post post;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    context.read<PostProvider>().getReviews(widget.post.pid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context,
          title: const Text(
            '상품 상세',
            style: TextStyle(
              fontSize: 18,
              color: mainBlack,
              fontWeight: FontWeight.w600,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductInfoFrame(children: [
              Container(
                constraints: const BoxConstraints(minHeight: 180),
                margin: const EdgeInsets.only(bottom: 33),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.post.imageDTOList.length,
                    itemBuilder: (_, index) {
                      final image = widget.post.imageDTOList[index];
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(image.path, fit: BoxFit.cover,
                              loadingBuilder: (
                            _,
                            child,
                            loadingProgress,
                          ) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }));
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            widget.post.pname,
                            style: const TextStyle(
                              color: mainBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(widget.post.pprice)}원',
                          style: const TextStyle(
                            color: mainBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  const Column(
                    children: [
                      Icon(
                        Icons.chat_rounded,
                        color: lightGray,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          '채팅 문의',
                          style: TextStyle(
                            color: lightGray,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ]),
            ProductInfoFrame(
              children: [
                const Text(
                  '상품정보',
                  style: TextStyle(
                    color: mainBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(widget.post.pexplain,
                      style: const TextStyle(
                        color: mainBlack,
                        height: 1.40,
                      )),
                ),
                Text(
                  DateFormat('yyyy.MM.dd')
                      .format(DateTime.parse(widget.post.regDate)),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
            ProductInfoFrame(dividerVisible: false, children: [
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
              )
            ])
          ],
        ),
      ),
    );
  }
}
