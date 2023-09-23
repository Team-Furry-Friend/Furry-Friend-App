import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/product_write_widget.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/model/post/product_image.dart';
import 'package:furry_friend/domain/model/post/product.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductWriteScreen extends StatefulWidget {
  const ProductWriteScreen({super.key, this.post});

  final Post? post;

  @override
  State<ProductWriteScreen> createState() => _ProductWriteScreenState();
}

class _ProductWriteScreenState extends State<ProductWriteScreen> {
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<ProductImage> imageList = [];

  String selectType = '사료';

  @override
  void initState() {
    if (widget.post != null) {
      imageList.addAll(widget.post!.imageDTOList);

      _productNameController.text = widget.post!.pname;
      _priceController.text = widget.post!.pprice.toString();
      _descriptionController.text = widget.post!.pexplain;

      selectType = widget.post!.pcategory;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context,
          title: Text(
            '상품 등록',
            style: TextStyle(
              fontSize: 18,
              color: WidgetColor.mainBlack,
              fontWeight: FontWeight.w600,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: WidgetColor.backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                  children: [
                    Visibility(
                      visible: imageList.length < 4,
                      child: GestureDetector(
                          onTap: () => getImageOnTap(),
                          child: Container(
                              height: imageList.isEmpty ? 280 : 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE1E1E1),
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              ))),
                    ),
                    Visibility(
                      visible: imageList.isNotEmpty,
                      child: ImageGridView(
                        imageList: imageList,
                        onTap: (image) {
                          setState(() {
                            imageList.remove(image);
                          });
                        },
                        isWriteScreen: widget.post == null,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(top: imageList.isNotEmpty ? 0 : 25),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 24),
                      decoration: BoxDecoration(
                          color: WidgetColor.cleanWhite,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '상품정보',
                                style: TextStyle(
                                  color: WidgetColor.mainBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '  필수',
                                style: TextStyle(
                                  color: WidgetColor.mainColor,
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
                                selectLabel: selectType,
                                labelOnTap: (type) {
                                  if (type != selectType) {
                                    setState(() {
                                      selectType = type;
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
                                maxLength: 300,
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
              onTap: () => completeButtonOnTap(),
              text: "완료",
              backgroundColor: WidgetColor.mainColor),
        ],
      ),
    );
  }

  bool completeCheck() {
    return _descriptionController.text.isNotEmpty &&
        _productNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        imageList.isNotEmpty;
  }

  void completeButtonOnTap() {
    if (completeCheck()) {
      final product = Product(
        pcategory: selectType,
        pexplain: _descriptionController.text,
        pname: _productNameController.text,
        pprice: int.parse(_priceController.text),
        imageDTOList: [],
      );

      if (widget.post != null) {
        context.read<PostProvider>().putPost(context, product);
      } else {
        context.read<PostProvider>().postImages(context, imageList, product);
      }
    } else {
      Utils.util.showSnackBar(context, '모든 정보를 입력해주세요.');
    }
  }

  Future<void> getImageOnTap() async {
    final ImagePicker _picker = ImagePicker();
    await _picker.pickMultiImage().then((value) {
      setState(() {
        for (final image in value) {
          imageList.add(ProductImage(imgName: image.name, path: image.path));
        }
      });
    });
  }
}
