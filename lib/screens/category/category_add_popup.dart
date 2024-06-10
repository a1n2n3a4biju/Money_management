import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mom/db/category/category_db.dart';
import 'package:mom/models/category/category_model.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _namedEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _namedEditingController,
              decoration: InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _namedEditingController.text;
                if (_name.isEmpty) {
                  return;
                }
                final _type = selectedCategoryNotifier.value;
                final _category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type);
                CategoryDB.instance.insertCategory(_category);
                Navigator.of(ctx).pop();
              },
              child: Text('Add'),
            ),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
