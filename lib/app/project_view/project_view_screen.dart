import 'package:duplicate_finder/app/style.dart';
import 'package:duplicate_finder/src/rust/api/project_api.dart';
import 'package:duplicate_finder/src/rust/project.dart';
import 'package:file_selector/file_selector.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:treemap/treemap.dart';

class ProjectViewScreen extends StatefulWidget {
  const ProjectViewScreen({super.key});

  @override
  State<ProjectViewScreen> createState() => _ProjectViewScreenState();
}

class _ProjectViewScreenState extends State<ProjectViewScreen> {
  final stream = projectScanStream();

  List<ProjectDetail> v = [];

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      print("${event.path}   ${filesize(event.size)}");
      setState(() {
        v.add(event);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  enabled: false,
                  decoration: AppStyle.inputDecorationWithHintAndLabel(
                      "Please select a folder to scan", "Folder Path"),
                )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String? directoryPath = await getDirectoryPath();
                      if (directoryPath == null) {
                        return;
                      }
                      projectScan(p: directoryPath);
                    },
                    child: const Text("Select folder"))
              ],
            ),
          ),
          Expanded(
            child: v.isEmpty
                ? SizedBox()
                : TreeMapLayout(
                    duration: Duration(milliseconds: 200),
                    tile: Squarify(),
                    children: [
                        TreeNode.node(
                            children: v
                                .map(
                                  (n) => TreeNode.leaf(
                                    margin: EdgeInsets.all(5),
                                    options: TreeNodeOptions(
                                        child: Text(
                                          "${n.path}(${filesize(n.size)})",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onTap: () {},
                                        color: Colors.primaries[n.size.toInt() %
                                            Colors.primaries.length]),
                                    value: n.size.toInt(),
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
