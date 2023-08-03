import 'package:flutter/material.dart';

import 'color.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: const Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                hintText: '건식 사료',
                hintStyle: TextStyle(color: lightGray),
                border: InputBorder.none),
          )),
          Icon(
            Icons.search,
            color: mainColor,
            size: 28,
          )
        ],
      ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
        border: Border.all(
          color: deepGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          const Image(
            image: NetworkImage("https://via.placeholder.com/269x229"),
            fit: BoxFit.fill,
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Icon(Icons.favorite_border_rounded,color: Colors.white,),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 270,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '건식 사료입니다.',
                        style: TextStyle(
                          color: mainBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '약 5일전',
                        style: TextStyle(
                          color: lightGray,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '12,000원',
                        style: TextStyle(
                          color: Color(0xFF626262),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
