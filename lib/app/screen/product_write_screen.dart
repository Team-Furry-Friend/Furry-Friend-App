import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/product_write_widget.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/model/post/post_image.dart';
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

  final List<PostImage> imageList = [];

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
                      onTap: () => getImageOnTap(),
                      child: imageList.isEmpty
                          ? Container(
                              height: 280,
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
                              ))
                          : Container(
                              width: double.infinity,
                              height: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: imageList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final image = imageList[index];
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.asset(
                                                image.path,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ],
                                    );
                                  }),
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
              backgroundColor: mainColor),
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
        imageDTOList: imageList,
      );

      if (widget.post != null) {
        context.read<PostProvider>().putPost(context, product);
      } else {
        context.read<PostProvider>().postProduct(context, product.toJson());
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
          imageList.add(PostImage(imgName: image.name, path: image.path));
        }
      });
    });
  }
}
