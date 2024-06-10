import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mom/db/category/category_db.dart';
import 'package:mom/models/category/category_model.dart';
import 'package:mom/screens/add_transaction/screen_add_transaction.dart';
import 'package:mom/screens/category/category_add_popup.dart';
import 'package:mom/screens/category/screen_category.dart';
import 'package:mom/screens/home/widgets/bottom_navigation.dart';
import 'package:mom/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Manger'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add transaction');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            print('Add category');

            showCategoryAddPopup(context);

            // final _sample = CategoryModel(
            // id: DateTime.now().millisecondsSinceEpoch.toString(),
            //name: 'Travel',
            //type: CategoryType.expense,
            //);
            //CategoryDb().insertCategory(_sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
