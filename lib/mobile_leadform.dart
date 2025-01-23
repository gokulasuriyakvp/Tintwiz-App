import 'package:flutter/material.dart';
import 'package:tintwiz_app/paymentinfo.dart';


class MobileLeadForm extends StatefulWidget {
  const MobileLeadForm({super.key});

  @override
  State<MobileLeadForm> createState() => _MobileLeadFormState();
}

class _MobileLeadFormState extends State<MobileLeadForm> {
  bool _isHovering = false;
  bool? value = false;
  bool _isDropdownVisible = false;

  bool showForm = false;

  bool _isContentVisible = true; // Controls visibility of the content
  bool _isButtonVisible = true; // Controls visibility of the 'Add New' button
  String _pageTitle = "Lead Forms"; // Title of the page

  void _toggleContent() {
    setState(() {
      _isContentVisible = !_isContentVisible; // Toggle visibility of content
      _isButtonVisible = !_isButtonVisible; // Toggle visibility of 'Add New' button
      _pageTitle = _isContentVisible ? "Lead Forms" : "Create New Form"; // Update title
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
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
                              child: Text(
                                "Your Trial Period will Expire Soon",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
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
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute
                                  (builder: (context)=>PaymentInfo()));
                              },
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
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
                              onEnter: (_) =>
                                  setState(() => _isHovering = true),
                              onExit: (_) =>
                                  setState(() => _isHovering = false),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 18,
                                    color: Colors.deepPurple.shade300,
                                  ),
                                  Text(
                                    "Have Questions? Let's chate",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        decoration: _isHovering
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 1110,
                decoration: BoxDecoration(
                    color: Color(0xff330099).withOpacity(.8),
                    borderRadius: BorderRadius.circular(6)),
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
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      height: 30,

                      child: Image.asset("assets/images/img.png")),
                  Text("Leads Forms"),
                ],
              ),
              _isContentVisible?
              Column(
                children: [

                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Checkbox(
                        tristate: true, // Example with tristate
                        value: value,
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
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 4,
                    child: Container(
                      height: 330,
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
                              children: [
                                Expanded(
                                  flex: 4,
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
                                  flex: 4,
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
                          Divider(
                              thickness: .6, color: Colors.grey.withOpacity(0.5)),

                          // First Data Row
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Default",
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
                                    "0",
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
                                    "10/05/2020",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Icon(Icons.keyboard_arrow_down),
                                ),
                              ],
                            ),
                          ),

                          // Divider after First Data Row
                          Divider(
                              thickness: .6, color: Colors.grey.withOpacity(0.5)),

                          // Second Data Row
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Mobile App Developer",
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
                                    "0",
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
                                    "10/05/2020",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: PopupMenuButton<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    onSelected: _handleMenuSelection,
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem<String>(
                                        value: "Option 1",
                                        child: _buildDropdownItem(Icons.info, "Option 1"),
                                      ),
                                      PopupMenuItem<String>(
                                        value: "Option 2",
                                        child: _buildDropdownItem(Icons.settings, "Option 2"),
                                      ),
                                      PopupMenuItem<String>(
                                        value: "Delete",
                                        child: _buildDropdownItem(Icons.delete, "Delete", isDelete: true),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Divider after Second Data Row
                          Divider(
                              thickness: .6, color: Colors.grey.withOpacity(0.5)),
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
                                    color: Color(0xff330099),
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
              ): Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.all(16.0), // Add padding for better spacing
                    width: 1100, // Adjust width to fit screen sizes better
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align texts to start
                      mainAxisSize: MainAxisSize.min, // Minimize space use to content size
                      children: [
                        Text("Name"),
                        SizedBox(height: 8), // Space between text and input field
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name",
                          ),
                        ),
                        SizedBox(height: 16), // Space between form fields
                        Text("Notes"),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Notes",
                          ),
                        ),
                        SizedBox(height: 20), // Space between form fields and buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // Add save action logic here
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.save),
                                    SizedBox(width: 4),
                                    Text("Save Form"),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isContentVisible = false; // Hide the form and show the lead forms list
                                  _isButtonVisible = false;  // Hide the 'Add New' button
                                });
                              },
                              child: Container(
                                alignment: Alignment.center, // Center text inside container
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text("Cancel"),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuSelection(String value) {
    // Define actions based on the selected value
    print("Selected: $value");
  }

  Widget _buildDropdownItem(IconData icon, String text, {bool isDelete = false}) {
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
