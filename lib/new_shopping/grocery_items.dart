import 'package:flutter/material.dart';
import 'package:mealapp/new_shopping/modals.dart';
import 'package:mealapp/new_shopping/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
    // Logic to add a new item

    // You can navigate to a new screen or show a dialog here
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
    //groceryItems.add(newItem);
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No items added yet!',
        //style: Theme.of(context).textTheme.headline6,
      ),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          // final item = groceryItems[index];
          return Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (direction) {
              _removeItem(_groceryItems[index]);
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _groceryItems[index].category.color,
              ),
              title: Text(_groceryItems[index].name),
              subtitle: Text('Quantity: ${_groceryItems[index].quantity}'),
              trailing: Text(_groceryItems[index].category.title),
              onTap: () {
                // Add your item tap logic here
              },
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              addItem();
              // Add your add item logic here
            },
          ),
        ],
      ),
      body:
          // ListView.builder(
          //   itemCount: groceryItems.length,
          //   itemBuilder: (context, index) {
          //     final item = groceryItems[index];
          //     return ListTile(
          //       title: Text(item.name),
          //       subtitle: Text('Quantity: ${item.quantity}'),
          //       trailing: Text(item.category.title),
          //       onTap: () {
          //         // Add your item tap logic here
          //       },
          //     );
          //   },
          // ),
          content,
    );
  }
}
