import 'package:flutter/material.dart';
import 'package:scanner/app/hybrid_search/expandable_list.dart';
import 'package:scanner/src/rust/api/hybrid_search_api.dart';
import 'package:scanner/src/rust/hybrid_search.dart';

class HybridSearchScreen extends StatefulWidget {
  const HybridSearchScreen({super.key});

  @override
  State<HybridSearchScreen> createState() => _HybridSearchScreenState();
}

class _HybridSearchScreenState extends State<HybridSearchScreen> {
  bool isExpanded = false;
  final GlobalKey<ExpandableListState> key = GlobalKey<ExpandableListState>();
  final stream = searchStream();

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      print(event.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (isExpanded) {
            setState(() {
              isExpanded = false;
            });
          }
        },
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.transparent,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey[300]!)),
                            child: Center(
                              child: Text("混合高级检索"),
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            final v = key.currentState!.getValues();
                            if (v.$1.isEmpty &&
                                v.$2.isEmpty &&
                                v.$3.isEmpty &&
                                v.$4.isEmpty &&
                                v.$5.isEmpty) {
                              return;
                            }

                            hybridSearchStream(
                              p: r"D:\github_repo\duplicate_finder",
                              startsWith: v.$1,
                              endsWith: v.$2,
                              includes: v.$3,
                              excludes: v.$4,
                              regex: v.$5,
                              searchType: SearchType.and,
                            );
                          },
                          child: Icon(Icons.start),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Column())
                ],
              ),
              AnimatedPositioned(
                left: (MediaQuery.of(context).size.width - 500) / 2,
                top: !isExpanded ? -500 : 80,
                duration: Duration(milliseconds: 300),
                child: ExpandableList(
                  key: key,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
