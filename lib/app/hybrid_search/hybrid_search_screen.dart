import 'package:flutter/material.dart';
import 'package:scanner/app/hybrid_search/expandable_list.dart';

class HybridSearchScreen extends StatefulWidget {
  const HybridSearchScreen({super.key});

  @override
  State<HybridSearchScreen> createState() => _HybridSearchScreenState();
}

class _HybridSearchScreenState extends State<HybridSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableList(),
    );
  }
}
