import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealapp/new_shopping/categories.dart';
import 'package:mealapp/new_shopping/modals.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final formkey = GlobalKey<FormState>();
  var itemname = '';
  var itemquantity = 1;
  var itemcategory = categories[Categories.vegetables]!;
  saveItem() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      print(itemname);
      print(itemquantity);
      print(itemcategory);
      final url = Uri.https(
        'fir-section12-96014-default-rtdb.firebaseio.com/',
        'groceryitems.json',
      );
      http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': itemname,
          'quantity': itemquantity,
          'category': itemcategory,
        }),
      );

      // Navigator.of(context).pop(
      //   GroceryItem(
      //     id: DateTime.now().toString(),
      //     name: itemname,
      //     quantity: itemquantity,
      //     category: itemcategory,
      //   ),
      // ); // Close the new item screen
    }
    // Save the form data
    // Save the form data
    // if (formkey.currentState!.validate()) {
    //   // If the form is valid, proceed with saving the item
    //   // You can access the saved values here
    //   // For example: final itemName = formkey.currentState!.fields['itemName']?.value;
    //   // final itemQuantity = formkey.currentState!.fields['itemQuantity']?.value;
    //   // final itemCategory = formkey.currentState!.fields['itemCategory']?.value;
    //   Navigator.pop(context); // Close the new item screen
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Call the function to add a new item
              Navigator.pop(context); // Close the new item screen
              // Save the new item
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (v1) {
                  if (v1 == null ||
                      v1.isEmpty ||
                      v1.trim().length <= 1 ||
                      v1.trim().length > 50) {
                    return 'Please enter an item name.and it shold be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (v1) => itemname = v1.toString(),
                // onSaved: (value) {
                //   // Save the item name
                // },
              ),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      validator: (v2) {
                        if (v2 == null ||
                            v2.isEmpty ||
                            int.tryParse(v2) == null ||
                            int.tryParse(v2)! <= 0) {
                          return 'valid quantity is required';
                        }
                        return null;
                      },
                      initialValue: '1',
                      onSaved: (v2) => itemquantity = int.parse(v2!),
                      // onSaved: (value) {
                      //   // Save the item quantity
                      // },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: itemcategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Container(
                              width: 100,
                              color: category.value.color,
                              child: Text(category.value.title),
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          itemcategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      formkey.currentState!.reset(); // Reset the form fields
                    },
                    child: Text('Reset'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        saveItem();
                      });
                      saveItem();
                    },
                    child: Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
