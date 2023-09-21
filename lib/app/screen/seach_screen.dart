import 'package:flutter/material.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../widget/search_widget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, this.selectLabel = '사료'});

  String selectLabel;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchProvider searchProvider;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final sortTypeList = ['최신순', '가격 낮은 순', '가격 높은 순'];
  final typeList = [
    '사료',
    '간식',
    '용품',
    '의류',
  ];

  bool isLoading = false;
  String sortType = '최신순';

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
      backgroundColor: WidgetColor.cleanWhite,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 4),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SearchWidget(
                    controller: _textController,
                    searchOnTap: () {
                      if (_textController.text.isNotEmpty) {
                        searchProvider.getPostKeyWord(
                            widget.selectLabel, _textController.text, sortType,
                            page: 1);
                      } else {
                        Utils.util.showSnackBar(context, '검색어를 입력해 주세요.');
                      }
                    },
                  ),
                ),
                TextLabelLayout(
                  selectLabel: widget.selectLabel,
                  labelOnTap: labelOnTap,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '전체 ${searchProvider.productList.isNotEmpty ? '${searchProvider.productList.length}개' : ''}',
                          style: TextStyle(
                              fontSize: 16, color: WidgetColor.mainBlack),
                        ),
                      ),
                      DropdownButton<String>(
                        value: sortType,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        borderRadius: BorderRadius.circular(8),
                        elevation: 0,
                        underline: Container(),
                        onChanged: (String? value) {
                          setState(() {
                            sortType = value!;
                            searchProvider.listSort(sortType);
                          });
                        },
                        items: sortTypeList.map((String value) {
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
          Expanded(
            child: SearchListLayout(
              scrollController: _scrollController,
            ),
          )
        ],
      ),
    );
  }

  void labelOnTap(String type) {
    if (type != widget.selectLabel) {
      setState(() {
        widget.selectLabel = type;
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
      searchProvider.getPostKeyWord(
        widget.selectLabel,
        _textController.text,
        sortType,
      );
    }
  }
}
