import 'package:file_selector/file_selector.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/app/logger.dart';
import 'package:scanner/src/rust/api/project_api.dart';
import 'package:scanner/src/rust/project.dart';

enum ProjectViewScanningStatus { done, none, on }

enum ShowOption {
  size("占用空间"),
  count("文件数量");

  final String label;

  const ShowOption(this.label);
}

class ProjectViewState {
  final String path;
  final ProjectViewScanningStatus status;
  final List<ProjectDetail> details;
  final String? sizeCondition;
  final String? current;
  final ShowOption showOption;
  final bool accelerate;

  ProjectViewState(
      {this.path = "",
      this.status = ProjectViewScanningStatus.none,
      this.details = const [],
      this.sizeCondition,
      this.current,
      this.showOption = ShowOption.size,
      this.accelerate = false});

  ProjectViewState copyWith(
      {String? path,
      ProjectViewScanningStatus? status,
      List<ProjectDetail>? details,
      String? sizeCondition,
      String? current,
      ShowOption? showOption,
      bool? accelerate}) {
    return ProjectViewState(
        path: path ?? this.path,
        status: status ?? this.status,
        details: details ?? this.details,
        sizeCondition: sizeCondition ?? this.sizeCondition,
        current: current ?? this.current,
        showOption: showOption ?? this.showOption,
        accelerate: accelerate ?? this.accelerate);
  }
}

extension Condition on List<ProjectDetail> {
  List<ProjectDetail> getBySizeCondition(String? condition) {
    if (condition == null) {
      return this;
    }

    final p = parseFilesize(condition);
    final result = where((element) => element.size.toInt() > p).toList();
    logger.info("condition: $condition, result: ${result.length}");
    return result;
  }
}

extension ProjectDetailExtension on ProjectViewState {
  List<ProjectDetail> getDetails() {
    return details.getBySizeCondition(sizeCondition);
  }
}

class ProjectViewNotifier extends AutoDisposeNotifier<ProjectViewState> {
  @override
  ProjectViewState build() {
    return ProjectViewState();
  }

  changeCurrent(String s) {
    if (s != "last") {
      state = state.copyWith(current: s);
    } else {
      state = state.copyWith(current: "");
    }
  }

  changeAccelerate(bool b) {
    if (b != state.accelerate) {
      state = state.copyWith(accelerate: b);
    }
  }

  startScan(TextEditingController controller) async {
    final String? directoryPath = await getDirectoryPath();
    if (directoryPath == null) {
      return;
    }
    refresh();

    controller.text = directoryPath;

    state = state.copyWith(
        path: directoryPath, status: ProjectViewScanningStatus.on);

    if (state.accelerate) {
      projectScanReallyFast(p: directoryPath);
    } else {
      projectScan(p: directoryPath);
    }
  }

  refresh() {
    state = ProjectViewState();
  }

  changeShowOption(ShowOption s) {
    state = state.copyWith(showOption: s);
  }

  refreshWithSizeCondition(String? condition) {
    if (condition == null) {
      return;
    }
    condition = condition.replaceAll(">=", "").trim();
    state = state.copyWith(sizeCondition: condition);
  }

  done() {
    state = state.copyWith(status: ProjectViewScanningStatus.done);
  }

  addDetails(ProjectDetail d) {
    state = state.copyWith(
        current: d.path,
        details: [...state.details, d],
        status: d.count.toInt() == 0 && d.path == "last"
            ? ProjectViewScanningStatus.done
            : ProjectViewScanningStatus.on);
  }

  inspect(String s) {
    refresh();

    state = state.copyWith(path: s, status: ProjectViewScanningStatus.on);
    if (state.accelerate) {
      projectScanReallyFast(p: s);
    } else {
      projectScan(p: s);
    }
  }
}

final projectViewNotifierProvider =
    AutoDisposeNotifierProvider<ProjectViewNotifier, ProjectViewState>(
        ProjectViewNotifier.new);
