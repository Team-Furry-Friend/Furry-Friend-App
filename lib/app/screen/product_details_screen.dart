import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/product_write_screen.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/product_details_widget.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.pid});

  final int pid;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _reviewTextController = TextEditingController();

  @override
  void initState() {
    context.read<PostProvider>().getPostDetail(widget.pid);
    context.read<PostProvider>().getReviews(widget.pid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product =
        context.select((PostProvider provider) => provider.postDetail);

    return Scaffold(
      appBar: DefaultAppBar(context,
          title: const Text(
            '상품 상세',
            style: TextStyle(
              fontSize: 18,
              color: mainBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    context: context,
                    builder: (_) {
                      return Container(
                        height: 200,
                        margin: const EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            ProductEditItem(
                              text: '수정하기',
                              iconData: Icons.edit,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductWriteScreen(
                                              post: product,
                                            )));
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
                                          Navigator.pop(dialogContext);
                                          context
                                              .read<PostProvider>()
                                              .deletePost(widget.pid, context);
                                        },
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(
                  Icons.more_vert,
                  color: mainBlack,
                ),
              ),
            )
          ]),
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
                    itemCount: product.imageDTOList.length,
                    itemBuilder: (_, index) {
                      final image = product.imageDTOList[index];
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
                            product.pname,
                            style: const TextStyle(
                              color: mainBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(product.pprice)}원',
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
                  child: Text(product.pexplain,
                      style: const TextStyle(
                        color: mainBlack,
                        height: 1.40,
                      )),
                ),
                Text(
                  DateFormat('yyyy.MM.dd').format(DateTime.parse(
                      product.regDate.isNotEmpty
                          ? product.regDate
                          : DateTime.now().toString())),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
            ProductReviewLayout(
              reviewWriteOnTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    context: context,
                    builder: (_) {
                      return SizedBox(
                        height: 380,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(24),
                              child: Text(
                                '문의 작성하기',
                                style: TextStyle(
                                  color: mainBlack,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GrayTextFieldLayout(
                                textController: _reviewTextController,
                                hintText: '궁금하신 사항을 적어주세요.',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: BottomButtonLayout(
                                  text: "완료",
                                  onTap: () {
                                    if (_reviewTextController.text.isEmpty) {
                                      Utils.util.showSnackBar(
                                          context, "문의사항을 입력해주세요.");
                                      return;
                                    }

                                    context.read<PostProvider>().postReviews(
                                        product.pid,
                                        _reviewTextController.text);
                                  },
                                  backgroundColor: mainColor),
                            ),
                          ],
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
