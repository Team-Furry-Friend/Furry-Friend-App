import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/product_write_widget.dart';

class ProductWriteScreen extends StatefulWidget {
  const ProductWriteScreen({super.key});

  @override
  State<ProductWriteScreen> createState() => _ProductWriteScreenState();
}

class _ProductWriteScreenState extends State<ProductWriteScreen> {
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  int selectTypeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context,
          title: const Text(
            '상품 등록',
            style: TextStyle(
              fontSize: 18,
              color: mainBlack,
              fontWeight: FontWeight.w600,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 70),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFFE1E1E1),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: Color(0xFFB8B8B8),
                              size: 36,
                            ),
                            Text(
                              '사진 추가',
                              style: TextStyle(
                                color: Color(0xFFB8B8B8),
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 24),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '상품정보',
                                style: TextStyle(
                                  color: mainBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '  필수',
                                style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          ProductWriteFrame(
                            titleText: '상품명',
                            childWidget: ProductTextField(
                              controller: _productNameController,
                              hintText: '상품명...',
                            ),
                          ),
                          ProductWriteFrame(
                            titleText: '가격',
                            childWidget: ProductTextField(
                              controller: _priceController,
                              hintText: '10,000원',
                              inputType: TextInputType.number,
                            ),
                          ),
                          ProductWriteFrame(
                            titleText: '상품 타입',
                            childWidget: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: TextLabelLayout(
                                selectLabelIndex: selectTypeIndex,
                                labelOnTap: (int index) {
                                  if (index != selectTypeIndex) {
                                    setState(() {
                                      selectTypeIndex = index;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          ProductWriteFrame(
                            titleText: '상품 설명',
                            childWidget: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: GrayTextFieldLayout(
                                marginValue: 0,
                                maxLines: 6,
                                textController: _descriptionController,
                                hintText: '상품에 관한 설명을 적어주세요',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          BottomButtonLayout(
              onTap: completeButtonOnTap,
              text: "다음",
              backgroundColor: completeCheck() ? mainColor : deepGray),
        ],
      ),
    );
  }

  bool completeCheck() {
    return false;
  }

  void completeButtonOnTap() {}
}
