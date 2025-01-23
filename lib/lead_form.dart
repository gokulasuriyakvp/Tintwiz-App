import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tintwiz_app/paymentinfo.dart';


import 'dashboard.dart';
import 'details_form.dart';

class LeadForm extends StatefulWidget {
  const LeadForm({super.key});

  @override
  State<LeadForm> createState() => _LeadFormState();
}

class _LeadFormState extends State<LeadForm> {
  bool? value = false;

  final TextEditingController name = TextEditingController();
  final TextEditingController notes = TextEditingController();

  bool showForm = false;

  bool _isContentVisible = true; // Controls visibility of the content
  bool _isButtonVisible = true; // Controls visibility of the 'Add New' button
  String _pageTitle = "Lead Forms"; // Title of the page

  void _toggleContent() {
    setState(() {
      _isContentVisible = !_isContentVisible; // Toggle visibility of content
      _isButtonVisible =
          !_isButtonVisible; // Toggle visibility of 'Add New' button
      _pageTitle =
          _isContentVisible ? "Lead Forms" : "Create New Form"; // Update title
    });
  }

  final _formKey = GlobalKey<FormState>();

  DateTime trialStartDate = DateTime.now()
      .subtract(Duration(days: 60)); // Example: trial started 60 days ago
  late DateTime trialExpiryDate;
  bool showExpiryMessage = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    trialExpiryDate =
        trialStartDate.add(Duration(days: 60)); // Two months trial period
    checkTrialExpiry();
  }

  void checkTrialExpiry() {
    final now = DateTime.now();
    final difference = trialExpiryDate.difference(now).inDays;

    if (difference <= 14 && difference >= 0) {
      // Check if within the last two weeks
      setState(() {
        showExpiryMessage = true;
      });
    }
  }

  Widget trailmsg() {
    return Center(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(7),
        child: Container(
            height: 270,
            width: 1100,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: showExpiryMessage
                          ? Text(
                              "Your Trial Period Started",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          : Text(
                              "Your trial period will expire on ${DateFormat('MMM d h:mm a').format(trialExpiryDate)}. ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Let's Make it Official",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffa09aa9)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 1000,
                      child: Text(
                        "Time flies! Your trial period will expire at Nov 5 10:57 PM but we "
                        "hope you decide to move forward and join the Tint Wiz family."
                        " Remember, there are no contracts, and you can cancel your subscription any time.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentInfo()));
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Color(0xff6AB187),
                            borderRadius: BorderRadius.circular(7)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: Colors.white,
                            ),
                            Text(
                              "Enter Payment Info",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat,
                          size: 18,
                          color: Color(0xff6AB187),
                        ),
                        Text(
                          "Have Questions? Let's chate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            decoration: _isHovering
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            color: Color(0xff6AB187),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget completeSettings() {
    return Container(
      height: 50,
      width: 1110,
      decoration: BoxDecoration(
          color: Color(0xff6AB187), borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Complete setting up your business: Tab here to update your business address.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                trailmsg(),
                SizedBox(
                  height: 10,
                ),
                completeSettings(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Image.asset("assets/images/img.png"),
                            Text(
                              _pageTitle,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            _isButtonVisible, // Controls visibility of the "Add" button
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _toggleContent();
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xff6AB187),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _isContentVisible == true ? leadform() : addForm(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leadform() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Checkbox(
                value: value,
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.teal; // Fill color when selected
                  }
                  return Colors.transparent; // Fill color when not selected
                }),
                checkColor: Colors.white,
                onChanged: (bool? newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
              ),
              const Text(
                'Show Archived',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 20),
          Material(
            elevation: 4,
            child: Container(
              height: 440,
              width: 1100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Search Container
                  Container(
                    height: 40,
                    width: 1090,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey.withOpacity(.7)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search_rounded, color: Colors.grey),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.menu, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                "Field",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
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
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
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
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Created",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Actions",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider after Header Row
                  Divider(thickness: .6, color: Colors.grey.withOpacity(0.5)),

                  // Second Data Row
                  FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('formData').get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: documents.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            // Get the document ID
                            String docId = documents[index].id;
                            // Optionally, get the document data
                            Map<String, dynamic> data =
                                documents[index].data() as Map<String, dynamic>;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          data['name'] ?? 'No Name',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withOpacity(.7),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withOpacity(.7),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          data["date_time"] ?? "no date",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withOpacity(.7),
                                          ),
                                          textAlign: TextAlign.center,
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
                                          // Wrap the PopupMenuButton with Center to align it
                                          child: PopupMenuButton<String>(
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            onSelected: _handleMenuSelection,
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem<String>(
                                                value: "Details",
                                                child: _buildDropdownItem(
                                                    Icons.info, "Details"),
                                                onTap: () {
                                                  context.go(
                                                    '/details',
                                                  );
                                                },
                                              ),
                                              PopupMenuItem<String>(
                                                value: "Settings",
                                                child: _buildDropdownItem(
                                                    Icons.settings, "Settings"),
                                                onTap: () {
                                                  context.go(
                                                    '/settings',
                                                  );
                                                },
                                              ),
                                              PopupMenuItem<String>(
                                                value: "Delete",
                                                child: _buildDropdownItem(
                                                    Icons.delete, "Delete",
                                                    isDelete: true),
                                                onTap: () async {
                                                  try {
                                                    // Delete the document from Firestore
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("formData")
                                                        .doc(
                                                            docId) // Pass the document ID
                                                        .delete();

                                                    // Remove the row locally and update the UI
                                                    setState(() {
                                                      documents.removeAt(
                                                          index); // Remove the document at the given index
                                                    });

                                                    // Show success message
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Contact deleted successfully!")),
                                                    );
                                                  } catch (error) {
                                                    // Show error message if deletion fails
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Failed to delete contact: $error")),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                      thickness: .6,
                                      color: Colors.grey.withOpacity(0.5)),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  // Divider after Second Data Row

                  SizedBox(
                    height: 5,
                  ),
                  // Pagination Controls
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Prev",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Color(0xff6AB187),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

  Widget addForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Title",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title'; // Error message if input is empty
                }
                return null; // Return null if the input is valid
              },
            ),
            SizedBox(height: 20),
            Text(
              "Notes",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: notes,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Notes",
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _saveFormData();
                      // Add save functionality here if needed
                    },
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isContentVisible = true; // Show the lead form
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveFormData() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM/dd/yyyy hh:mm:ss a').format(now);

      try {
        await FirebaseFirestore.instance.collection('formData').add({
          'name': name.text,
          'notes': notes.text,
          'date_time': formattedDate,
          'timestamp': DateTime.now().microsecondsSinceEpoch,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully')),
        );
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsScreen()));
         /* context.go(
            '/details',

          );*/
        });
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }
}
