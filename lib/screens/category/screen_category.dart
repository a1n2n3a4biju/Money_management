import 'package:flutter/material.dart';
import 'package:mom/db/category/category_db.dart';
import 'package:mom/screens/category/expence_categorylist.dart';
import 'package:mom/screens/category/income_categorylist.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'INCOME'),
              Tab(text: 'EXPENSE'),
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: const [
            IncomeCategorylist(),
            ExpenceCategorylist(),
          ],
        ))
      ],
    );
  }
}
