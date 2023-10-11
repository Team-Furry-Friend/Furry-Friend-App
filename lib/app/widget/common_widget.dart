import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:furry_friend/domain/model/post/product_image.dart';
import 'package:go_router/go_router.dart';

import 'widget_color.dart';

PreferredSizeWidget DefaultAppBar(BuildContext context,
    {Widget? title, List<Widget>? actions, Function()? onTap}) {
  return AppBar(
    elevation: 0,
    title: title,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: onTap ??
          () {
            context.pop();
          },
      child: const Padding(
        padding: EdgeInsets.only(left: 18),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
        ),
      ),
    ),
    actions: actions,
  );
}

class WebMobileSizeMatchLayout extends StatelessWidget {
  final maxWebAppRatio = 4.8 / 6.0;
  final minWebAppRatio = 9.0 / 16.0;

  final Widget child;

  const WebMobileSizeMatchLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < constraints.maxWidth) {
          return Container(
            alignment: Alignment.center,
            child: ClipRect(
              child: AspectRatio(
                aspectRatio: getCurrentWebAppRatio(),
                child: child,
              ),
            ),
          );
        }
        return child;
      },
    );
  }

  double getCurrentWebAppRatio() {
    double webAppRatio = minWebAppRatio;

    var screenSize = PlatformDispatcher.instance.implicitView?.physicalSize;
    var screenWidth = screenSize?.width ?? 1200;
    var screenHeight = screenSize?.height ?? 900;

    webAppRatio = screenWidth / screenHeight;
    if (webAppRatio > maxWebAppRatio) {
      webAppRatio = maxWebAppRatio;
    } else if (webAppRatio < minWebAppRatio) {
      webAppRatio = minWebAppRatio;
    }
    return webAppRatio;
  }
}

class BottomButtonLayout extends StatelessWidget {
  const BottomButtonLayout({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
  });

  final Function() onTap;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: deepGray,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BottomButton(
            text: text,
            onTap: () => onTap(),
            backgroundColor: backgroundColor,
          ),
        )
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.backgroundColor = const Color(0xFF70A3F3),
  });

  final Function() onTap;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldRow extends StatelessWidget {
  const TextFieldRow(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.controller,
      this.inputType = TextInputType.text});

  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;

  final textStyle = const TextStyle(
    color: Color(0xFFB8B8B8),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: deepGray,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: TextField(
              controller: controller,
              obscureText: hintText == '비밀번호',
              keyboardType: inputType,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: textStyle,
                  focusColor: WidgetColor.mainColor),
            ),
          ),
        ),
      ],
    );
  }
}

class GrayTextFieldLayout extends StatelessWidget {
  const GrayTextFieldLayout(
      {super.key,
      required this.textController,
      required this.hintText,
      this.marginValue = 24,
      this.maxLines = 1,
      this.verticalPadding = 14,
      this.maxLength});

  final TextEditingController textController;
  final String hintText;
  final double marginValue;
  final double verticalPadding;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginValue),
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 18),
      decoration: BoxDecoration(
          color: WidgetColor.backgroundColor,
          borderRadius: BorderRadius.circular(16)),
      child: TextField(
          controller: textController,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            hintStyle: const TextStyle(
              color: Color(0xFFB8B8B8),
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}

class TextLabelLayout extends StatelessWidget {
  const TextLabelLayout({
    super.key,
    required this.selectLabel,
    required this.labelOnTap,
  });

  final String selectLabel;
  final Function(String) labelOnTap;
  final typeList = const [
    '사료',
    '간식',
    '용품',
    '의류',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: typeList.length,
          itemBuilder: (context, index) {
            final type = typeList[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TypeLabel(
                type: type,
                isSelectedLabel: selectLabel == type,
                onTap: () => labelOnTap(type),
              ),
            );
          }),
    );
  }
}

class TypeLabel extends StatelessWidget {
  const TypeLabel({
    super.key,
    required this.type,
    required this.isSelectedLabel,
    required this.onTap,
  });

  final String type;
  final bool isSelectedLabel;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            color: isSelectedLabel ? WidgetColor.mainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF70A3F3), width: 1)),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 15,
            color: isSelectedLabel
                ? WidgetColor.cleanWhite
                : const Color(0xFF70A3F3),
          ),
        ),
      ),
    );
  }
}

class SquareTypeLabel extends StatelessWidget {
  const SquareTypeLabel({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: WidgetColor.mainColor),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Color(0xFF70A3F3),
          fontSize: 14,
        ),
      ),
    );
  }
}

class ImageGridView extends StatelessWidget {
  const ImageGridView(
      {super.key,
      required this.imageList,
      required this.onTap,
      this.isWriteScreen = false});

  final List<ProductImage> imageList;
  final Function(ProductImage) onTap;
  final bool isWriteScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) {
            final image = imageList[index];
            return ProductGridItem(
              image: image,
              onTap: onTap,
              isWriteScreen: isWriteScreen,
            );
          }),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  const ProductGridItem(
      {super.key,
      required this.image,
      required this.onTap,
      this.isWriteScreen = false});

  final ProductImage image;
  final Function(ProductImage) onTap;
  final bool isWriteScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (!isWriteScreen) onTap(image);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: isWriteScreen
                    ? Image.asset(
                        image.path,
                        fit: BoxFit.cover,
                      )
                    : NetWorkImage(image: image)),
          ),
        ),
        Visibility(
          visible: isWriteScreen,
          child: Positioned(
            right: 10,
            child: GestureDetector(
              onTap: () => onTap(image),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black54, shape: BoxShape.circle),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NetWorkImage extends StatelessWidget {
  const NetWorkImage({
    super.key,
    required this.image,
  });

  final ProductImage image;

  @override
  Widget build(BuildContext context) {
    return Image.network(image.path, fit: BoxFit.cover, loadingBuilder: (
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
    });
  }
}
