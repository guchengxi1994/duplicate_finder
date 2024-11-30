import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarState {
  int index;
  double width;

  SidebarState({this.index = 0, this.width = 40});

  SidebarState copyWith({int? index, double? width}) {
    return SidebarState(
      index: index ?? this.index,
      width: width ?? this.width,
    );
  }
}

class SidebarNotifier extends AutoDisposeNotifier<SidebarState> {
  final PageController pageController = PageController();

  @override
  SidebarState build() {
    return SidebarState();
  }

  void setIndex(int index) {
    state = state.copyWith(index: index);
    pageController.jumpToPage(
      index,
    );
  }

  void changeWidth(double delta) {
    if (state.width + delta < 40) return;
    if (state.width + delta > 200) return;
    state = state.copyWith(width: state.width + delta);
  }
}

final sidebarProvider =
    AutoDisposeNotifierProvider<SidebarNotifier, SidebarState>(
        SidebarNotifier.new);
