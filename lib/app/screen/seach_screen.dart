import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/color.dart';
import 'package:furry_friend/domain/providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../widget/common_widget.dart';
import '../widget/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchProvider searchProvider;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final dropdownList = ['최신순', '선호순', '가격순'];
  final typeList = [
    '사료',
    '간식',
    '용품',
    '의류',
  ];

  int selectLabelIndex = 0;
  bool isLoading = false;
  String dropdownValue = '최신순';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(nextPageLoad);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchProvider = Provider.of<SearchProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SearchWidget(
                    isHomeScreen: false,
                    controller: _textController,
                    searchOnTap: () {
                      if (_textController.text.isNotEmpty) {
                        searchProvider.getPostKeyWord(
                            typeList[selectLabelIndex], _textController.text,
                            page: 1);
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    for (int index = 0; index < typeList.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TypeLabel(
                          type: typeList[index],
                          isSelectedLabel: selectLabelIndex == index,
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
          ),
          SearchListLayout(
            scrollController: _scrollController,
          )
        ],
      ),
    );
  }

  void labelOnTap(int index) {
    if (index != selectLabelIndex) {
      setState(() {
        selectLabelIndex = index;
      });
    }
  }

  void nextPageLoad() {
    if (searchProvider.hasNextPage &&
        !searchProvider.isLoadingPage &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      setState(() {
        searchProvider.isLoadingPage = true;
      });
      searchProvider.getPostKeyWord('사료', '');
    }
  }
}
