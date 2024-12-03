import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:scanner/app/logger.dart';
import 'package:scanner/app/style.dart';
import 'package:scanner/src/rust/api/project_api.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:scanner/src/rust/api/tools_api.dart';
import 'package:treemap/treemap.dart';

import 'notifier.dart';

class ProjectViewScreen extends ConsumerStatefulWidget {
  const ProjectViewScreen({super.key});

  @override
  ConsumerState<ProjectViewScreen> createState() => _ProjectViewScreenState();
}

class _ProjectViewScreenState extends ConsumerState<ProjectViewScreen> {
  final stream = projectScanStream();

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      logger.info("${event.path}   ${filesize(event.size)}");
      ref.read(projectViewNotifierProvider.notifier).addDetails(event);
    });
  }

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> sizeConditions = [
    ">= 100 MB",
    ">= 200 MB",
    ">= 500 MB",
    ">= 1 GB",
    ">= 2 GB",
    ">= 5 GB",
    ">= 10 GB",
    ">= 20 GB",
    ">= 50 GB",
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectViewNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _controller,
                  enabled: false,
                  decoration: AppStyle.inputDecorationWithHintAndLabel(
                      "Please select a folder to scan", "Folder Path"),
                )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      ref
                          .read(projectViewNotifierProvider.notifier)
                          .startScan(_controller);
                    },
                    child: const Text("选择文件夹")),
                SizedBox(
                  width: 10,
                ),
                Checkbox(
                    value: state.accelerate,
                    onChanged: (v) {
                      if (ProjectViewScanningStatus.on == state.status) {
                        return;
                      }

                      if (v == null) {
                        return;
                      }
                      ref
                          .read(projectViewNotifierProvider.notifier)
                          .changeAccelerate(v);
                    }),
                Text("加速"),
                SizedBox(
                  width: 10,
                ),
                Tooltip(
                  message: "加速模式下，扫描速度更快，但占用更多资源",
                  child: Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (state.details.isNotEmpty)
            Row(
              children: [
                if (state.status == ProjectViewScanningStatus.on)
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotate,
                        colors: [
                          Colors.blue,
                          Colors.purpleAccent,
                          Colors.green
                        ],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.black),
                  ),
                const SizedBox(width: 10),
                if (state.current != null &&
                    state.current != "" &&
                    state.current != "last")
                  SizedBox(
                    width: 200,
                    child: Text(
                      style: TextStyle(fontSize: 14),
                      state.current!,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                Spacer(),
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: CustomDropdown(
                        hintText: '视图',
                        items: ShowOption.values,
                        headerBuilder: (context, selectedItem, enabled) =>
                            Text(selectedItem.label),
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) =>
                                Text(item.label),
                        onChanged: (s) {
                          if (s != null) {
                            ref
                                .read(projectViewNotifierProvider.notifier)
                                .changeShowOption(s);
                          }
                        }),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                if (state.status == ProjectViewScanningStatus.done &&
                    state.showOption == ShowOption.size)
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: CustomDropdown(
                          hintText: '占用筛选',
                          items: sizeConditions,
                          onChanged: (s) {
                            ref
                                .read(projectViewNotifierProvider.notifier)
                                .refreshWithSizeCondition(s);
                          }),
                    ),
                  )
              ],
            ),
          const SizedBox(height: 10),
          Expanded(
            child: state.getDetails().isEmpty
                ? SizedBox()
                : TreeMapLayout(
                    duration: Duration(milliseconds: 200),
                    tile: Squarify(),
                    children: [
                        TreeNode.node(
                            children: state
                                .getDetails()
                                .map(
                                  (n) => TreeNode.leaf(
                                    margin: EdgeInsets.all(5),
                                    options: TreeNodeOptions(
                                        child:
                                            state.showOption == ShowOption.size
                                                ? Text(
                                                    "${n.path}(${filesize(n.size)})",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    "${n.path}(${n.count} files)",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                        onTap: () {
                                          openFolder(s: n.path);
                                        },
                                        onSecondaryTapDown: (d) {
                                          // print(d);
                                          showContextMenu(
                                              d.globalPosition, context, (c) {
                                            return [
                                              ListTile(
                                                leading: Icon(Icons.more_horiz),
                                                title: Text('inspect'),
                                                onTap: () {
                                                  Navigator.of(c).pop();
                                                  _controller.text = n.path;
                                                  ref
                                                      .read(
                                                          projectViewNotifierProvider
                                                              .notifier)
                                                      .inspect(n.path);
                                                },
                                              )
                                            ];
                                          }, 10.0, 200.0);
                                        },
                                        color: Colors.primaries[n.size.toInt() %
                                            Colors.primaries.length]),
                                    value: state.showOption == ShowOption.size
                                        ? n.size.toInt()
                                        : n.count.toInt(),
                                  ),
                                )
                                .toList())
                      ]),
          )
        ],
      ),
    );
  }
}
