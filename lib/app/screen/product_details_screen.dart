import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/product_details_widget.dart';
import 'package:furry_friend/common/prefs_utils.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/chat_provider.dart';
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
  int selectImageIndex = 0;
  int myId = 0;

  @override
  void initState() {
    myId = PrefsUtils.getInt(PrefsUtils.utils.userId);
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
          title: Text(
            '상품 상세',
            style: TextStyle(
              fontSize: 18,
              color: WidgetColor.mainBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            ProductDetailsAction(
              product: product,
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductInfoFrame(children: [
              SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: product.imageDTOList.isNotEmpty
                          ? NetWorkImage(
                              image: product.imageDTOList
                                  .elementAt(selectImageIndex),
                            )
                          : Container())),
              ImageGridView(
                imageList: product.imageDTOList,
                onTap: (image) {
                  setState(() {
                    selectImageIndex = product.imageDTOList.indexOf(image);
                  });
                },
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
                            style: TextStyle(
                              color: WidgetColor.mainBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(product.pprice)}원',
                          style: TextStyle(
                            color: WidgetColor.mainBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: product.mid != myId,
                    child: Column(
                      children: [
                        const VerticalDivider(),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ChatProvider>()
                                .createChatRoom(context, myId);
                          },
                          child: const Column(
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
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
            ProductInfoFrame(
              children: [
                Text(
                  '상품정보',
                  style: TextStyle(
                    color: WidgetColor.mainBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(product.pexplain,
                      style: TextStyle(
                        color: WidgetColor.mainBlack,
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
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                '문의 작성하기',
                                style: TextStyle(
                                  color: WidgetColor.mainBlack,
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
                                  backgroundColor: WidgetColor.mainColor),
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
