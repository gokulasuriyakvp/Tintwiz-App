import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class EditContactPage extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> contactData;

  const EditContactPage({super.key, required this.documentId, required this.contactData});
  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  bool _isHovering = false;
  bool? value = false;
  bool? value1 = false;
  bool? value2 = false;


  // Text editing controllers
  late TextEditingController _firstnameController = TextEditingController();
  late TextEditingController _lastnameController = TextEditingController();

  late TextEditingController _addressController = TextEditingController();
  late TextEditingController _2ndlineController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();
  late TextEditingController _zipcodeController = TextEditingController();

  late TextEditingController _mobileController = TextEditingController();
  late TextEditingController _altPhoneController = TextEditingController();

  late TextEditingController _companyNameController = TextEditingController();

  late TextEditingController _emailController = TextEditingController();

  late TextEditingController _messageController = TextEditingController();

  List<String> stateList = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming",
  ];
  String selectedState = "Alabama";

  List<String> vehicleMakes = [
    "Acura",
    "Audi",
    "BMW",
    "Chevrolet",
    "Dodge",
    "Ford",
    "GMC",
    "Honda",
    "Hyundai",
    "Jeep",
    "Kia",
    "Lexus",
    "Mazda",
    "Mercedes-Benz",
    "Nissan",
    "Subaru",
    "Tesla",
    "Toyota",
    "Volkswagen",
    "Volvo",
  ];
  String? selectedVehicleMake; // For the selected vehicle make



  List<String> yearList = [
    for (int year = 1924; year <= 2025; year++) year.toString()
  ];
  String selectedYear = "1924";

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.contactData['firstname']);
    _mobileController= TextEditingController(text: widget.contactData['mobile']);
    _altPhoneController = TextEditingController(text: widget.contactData['alternate_phone']);
    _companyNameController = TextEditingController(text: widget.contactData['company']);
    _addressController = TextEditingController(text: widget.contactData['address']);
    _2ndlineController = TextEditingController(text: widget.contactData['2ndlineaddress']);
    _zipcodeController = TextEditingController(text: widget.contactData['address']);
    _lastnameController = TextEditingController(text: widget.contactData['lastname']);
    _emailController = TextEditingController(text: widget.contactData['email']);
    _messageController = TextEditingController(text: widget.contactData['message']);
    _cityController = TextEditingController(text: widget.contactData['city']);

    // Initialize selected dropdown values from contactData
    selectedState = widget.contactData['state'] ?? "Alabama";
    selectedVehicleMake = widget.contactData['vehiclemake'] ?? vehicleMakes.first;
    selectedYear = widget.contactData['vehicleyear'] ?? "2022";
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _addressController.dispose();
    _2ndlineController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();
    _mobileController.dispose();
    _altPhoneController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }



  Future<void> _updateContact() async {
    try {
      await FirebaseFirestore.instance
          .collection("SaveForm")
          .doc(widget.documentId)
          .update({
        'firstname': _firstnameController.text,
        'lastname': _lastnameController.text,
        'address': _addressController.text,
        '2ndlineaddress': _2ndlineController.text,
        'city': _cityController.text,
        'zipcode': _zipcodeController.text,
        'state': selectedState,
        'mobile': _mobileController.text,
        'alternate_phone': _altPhoneController.text,
        'company': _companyNameController.text,
        'email': _emailController.text,
        'vehicleyear': selectedYear,
        'vehicleyear': selectedVehicleMake,
        'message': _messageController.text,
        'timestamp': DateTime.now().microsecondsSinceEpoch,

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Contact updated successfully!")));
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update contact: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 830, // Height of the dialog
        width: 1000, // Width of the dialog
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.group),
                    Text(
                      "Edit Contact",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close,size: 20,))
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 470,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Name"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller: _firstnameController,
                        decoration: InputDecoration(
                          labelText: "Enter firstName",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 470,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Company"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller: _companyNameController,
                        decoration: InputDecoration(
                          labelText: "Enter the company",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 310,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Phone Number (Cell)"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller: _mobileController,
                        decoration: InputDecoration(
                          labelText: "Enter the Phone Number (Cell)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),

                Container(
                  width: 310,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Alt. Phone (Landline)"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller:  _altPhoneController,
                        decoration: InputDecoration(
                          labelText: "Alt. Phone (Landline)",
                          border: OutlineInputBorder(),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 310,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Email"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller: _emailController ,
                        decoration: InputDecoration(
                          labelText: "Enter the Email",
                          border: OutlineInputBorder(),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
              children: [
                Text("Search Address"),
                Container(
                  height: 40,
                  width: 1080,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: Colors.grey.withOpacity(.7)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0),
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
                            EdgeInsets.symmetric(
                                horizontal: 8.0),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 470,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Street Address"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: "Street Address, P.O.box etc.",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 470,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("2nd Line"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      TextFormField(
                        controller: _2ndlineController,
                        decoration: InputDecoration(
                          labelText: "Apartment, suite, unit, building, floor etc.",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City"),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: "City",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),

                Container(
                  width: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Zipcode"),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _zipcodeController,
                        decoration: InputDecoration(
                          labelText: "Zipcode",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),

                Container(
                  width: 235,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("State"),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(5)
                        ),// Wrap DropdownButton in a container
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedVehicleMake, // Selected value
                            hint: Text("Select Vehicle Make"), // Placeholder
                            onChanged: (value) {
                              setState(() {
                                selectedVehicleMake = value; // Update the selected make
                              });
                            },
                            items: vehicleMakes.map((make) {
                              return DropdownMenuItem(
                                value: make,
                                child: Text(make),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),

                Container(
                  width: 235,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country"),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(5)
                        ),// Wrap DropdownButton in a container
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedVehicleMake, // Selected value
                            hint: Text("Select Vehicle Make"), // Placeholder
                            onChanged: (value) {
                              setState(() {
                                selectedVehicleMake = value; // Update the selected make
                              });
                            },
                            items: vehicleMakes.map((make) {
                              return DropdownMenuItem(
                                value: make,
                                child: Text(make),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.emoji_transportation,  color:  Colors.deepPurple,),
                GestureDetector(
                    onTap: (){
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _isHovering = true),
                      onExit: (_) => setState(() => _isHovering = false),
                      child: Text(
                        Constants.vehicle,
                        style: TextStyle(
                            decoration: _isHovering ? TextDecoration.underline : TextDecoration.none,
                            color:  Colors.deepPurple,
                            fontSize: 15
                        ),
                      ),
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 470,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Contact Tags"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      Container(
                        width: 470,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(5)
                        ),// Wrap DropdownButton in a container

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedVehicleMake, // Selected value
                            hint: Text("Select Vehicle Make"), // Placeholder
                            onChanged: (value) {
                              setState(() {
                                selectedVehicleMake = value; // Update the selected make
                              });
                            },
                            items: vehicleMakes.map((make) {
                              return DropdownMenuItem(
                                value: make,
                                child: Text(make),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 470,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the start
                    children: [
                      Text("Tax Exemption"),
                      SizedBox(height: 8), // Add spacing between Text and TextField
                      Container(
                        width: 470,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(5)
                        ),// Wrap DropdownButton in a container

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedVehicleMake, // Selected value
                            hint: Text("Select Vehicle Make"), // Placeholder
                            onChanged: (value) {
                              setState(() {
                                selectedVehicleMake = value; // Update the selected make
                              });
                            },
                            items: vehicleMakes.map((make) {
                              return DropdownMenuItem(
                                value: make,
                                child: Text(make),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Communication Preferences", style: TextStyle(fontSize: 20.0),),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: <Widget>[
                    Checkbox(
                      tristate: true, // Example with tristate
                      value: value,
                      onChanged: (bool? newValue) {
                        setState(() {
                          value = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Event Reminders',
                      style: TextStyle(fontSize: 17.0),
                    ),

                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: <Widget>[
                    Checkbox(
                      tristate: true, // Example with tristate
                      value: value1,
                      onChanged: (bool? newValue) {
                        setState(() {
                          value1 = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Proposal Followups',
                      style: TextStyle(fontSize: 17.0),
                    ),

                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: <Widget>[
                    Checkbox(
                      tristate: true, // Example with tristate
                      value: value2,
                      onChanged: (bool? newValue) {
                        setState(() {
                          value2 = newValue;
                        });
                      },
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Review Requests',
                      style: TextStyle(fontSize: 17.0),
                    ),

                  ],
                ),


              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Perform an action, like saving data
                  },
                  child: Text("Submit"),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}