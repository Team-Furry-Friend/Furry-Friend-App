import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';

import '../../domain/providers/post_provider.dart';
import '../widget/common_widget.dart';
import '../widget/seach_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PostProvider postProvider = PostProvider();
  final ScrollController _controller = ScrollController();
  final dropdownList = ['최신순', '선호순', '가격순'];
  final typeList = [
    '사료',
    '간식',
    '용품',
    '의류',
  ];

  List<int> selectLabelList = [];

  String dropdownValue = '최신순';

  @override
  void initState() {
    _controller.addListener(nextPageLoad);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(nextPageLoad);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SearchWidget(isHomeScreen: false),
                ),
                Row(
                  children: [
                    for (int index = 0; index < typeList.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TypeLabel(
                          type: typeList[index],
                          isSelectedLabel: selectLabelList.contains(index),
                          onTap: () => labelOnTap(index),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '전체',
                          style: TextStyle(fontSize: 16, color: mainBlack),
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        borderRadius: BorderRadius.circular(8),
                        elevation: 0,
                        underline: Container(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: dropdownList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black45,
          )
        ],
      ),
    );
  }

  void labelOnTap(int index) {
    setState(() {
      if (selectLabelList.contains(index)) {
        selectLabelList.remove(index);
      } else {
        selectLabelList.add(index);
      }
    });
  }

  void nextPageLoad() {
    if (postProvider.hasNextPage &&
        !postProvider.isFirstLoading &&
        !postProvider.isLoadingPage &&
        _controller.position.extentAfter < 100) {
      postProvider.isLoadingPage = true;
      postProvider.getPostKeyWord(20, '사료', '사료');
    }
  }
}
