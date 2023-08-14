import 'package:flutter/material.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:furry_friend/domain/providers/post_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'color.dart';

class PopularPostLayout extends StatelessWidget {
  const PopularPostLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final postList = context.select((PostProvider post) => post.postList);

    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                '최근 인기 상품 🚀',
                style: TextStyle(
                  color: mainBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            RoundBlueButton(text: '모두보기'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              final post = postList[index];
              return HomeListItem(post: post);
            },
          ),
        )
      ],
    );
  }
}

class RoundBlueButton extends StatelessWidget {
  const RoundBlueButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: ShapeDecoration(
          color: lightMainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: mainColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class HomeListItem extends StatelessWidget {
  const HomeListItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      constraints: const BoxConstraints(minHeight: 200),
      decoration: BoxDecoration(
        border: Border.all(
          color: deepGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            image: NetworkImage(post.imageDTOList.first.path),
            fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.black12, Colors.transparent])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.pname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: mainColor),
                  ),
                  child: Text(
                    post.pcategory,
                    style: const TextStyle(
                      color: Color(0xFF70A3F3),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.favorite_border_rounded,
                    color: lightGray,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Text(
                    '${NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0).format(post.pprice)}원',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
