import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'edit_contacts.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<String> items = ['Leads', 'Customers', 'Dismissed'];
  String? selectedItem;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Material(
              elevation: 4,
              child: Container(
                height: 300,
                width: 1100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 1100,
                        decoration: BoxDecoration(
                          color: Color(0xff6AB187),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "All",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text("Type"), // Placeholder
                                    value: selectedItem,
                                    // Set a custom icon
                                    icon: Icon(
                                      Icons
                                          .arrow_drop_down, // Any icon from Icons
                                      color:
                                          Color(0xff6AB187), // Change the color
                                      size: 30, // Adjust the size
                                    ),
                                    // Action when an item is selected
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedItem = newValue!;
                                      });
                                    },
                                    // Dropdown items
                                    items: items.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.question_mark,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: 1080,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border:
                              Border.all(color: Colors.grey.withOpacity(.7)),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.search_rounded,
                                  color: Colors.grey),
                            ),
                            VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search here...',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.menu, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    "Field",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Header Row
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Ensure alignment starts at the top
                          children: [
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start, // Align to start
                              children: [
                                Icon(Icons.run_circle, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "Acquisition",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start, // Align text to start
                            ),
                            Spacer(),
                            Text(
                              "Details",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start, // Align text to start
                            ),
                            Spacer(),
                            Text(
                              "Actions",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start, // Align text to start
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("SaveFeilds")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final documents =
                                snapshot.data!.docs; // List of documents
                            return ListView.builder(
                              itemCount: documents.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final name = documents[index]['firstname'];
                                final dateTime = documents[index]['date_time'];
                                final mobile = documents[index]['mobile'];
                                final address = documents[index]['address'];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align at the start
                                    children: [
                                      Expanded(
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withOpacity(.7),
                                          ),
                                          textAlign: TextAlign
                                              .start, // Align text to start
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Align text inside the column to start
                                          children: [
                                            Text(
                                              'Default',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(.7),
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              dateTime,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(.7),
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Align text inside the column to start
                                          children: [
                                            Text(
                                              mobile,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(.7),
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              address,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(.7),
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: PopupMenuButton<String>(
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            onSelected: _handleMenuSelection,
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem<String>(
                                                value: "Details",
                                                child: _buildDropdownItem(
                                                    Icons.person, "Details"),
                                              ),
                                              PopupMenuItem<String>(
                                                value: "Edit",
                                                child: _buildDropdownItem(
                                                    Icons.edit, "Edit"),
                                                onTap: () {
                                                  final documentId =
                                                      documents[index].id;
                                                  final contactData =
                                                      documents[index].data()
                                                          as Map<String,
                                                              dynamic>;
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        SingleChildScrollView(
                                                            child:
                                                                EditContactPage(
                                                      documentId: documentId,
                                                      contactData: contactData,
                                                    )),
                                                  );
                                                },
                                              ),
                                              PopupMenuItem<String>(
                                                value: "Merge",
                                                child: _buildDropdownItem(
                                                    Icons.merge, "Merge"),
                                                onTap: () {},
                                              ),
                                              PopupMenuItem<String>(
                                                value: "Delete",
                                                child: _buildDropdownItem(
                                                    Icons.delete, "Delete",
                                                    isDelete: true),
                                                onTap: () {
                                                  final documentId = documents[
                                                          index]
                                                      .id; // Get the document ID

                                                  // Show a confirmation dialog
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          "Delete Contact"),
                                                      content: Text(
                                                          "Are you sure you want to delete this contact?"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(), // Close dialog
                                                          child: Text("Cancel"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            try {
                                                              // Delete the document from Firestore
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "SaveFeilds")
                                                                  .doc(
                                                                      documentId)
                                                                  .delete();

                                                              // Remove the row locally and update the UI
                                                              setState(() {
                                                                documents
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                    content: Text(
                                                                        "Contact deleted successfully!")),
                                                              );
                                                            } catch (error) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                    content: Text(
                                                                        "Failed to delete contact: $error")),
                                                              );
                                                            }
                                                            // Close the confirmation dialog
                                                          },
                                                          child: Text("Delete"),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value) {
    // Define actions based on the selected value
    print("Selected: $value");
  }

  Widget _buildDropdownItem(IconData icon, String text,
      {bool isDelete = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        children: [
          Icon(icon, color: isDelete ? Colors.red : Colors.black),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: isDelete ? Colors.red : Colors.black,
              fontWeight: isDelete ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
