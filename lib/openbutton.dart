import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';

class OpenButton extends StatefulWidget {
  final Map<String, String> queryParams;
  final bool isNameVisible;
  final bool isAddressVisible;
  final bool isMobileVisible;
  final bool isCompanyNameVisible;
  final bool isEmailVisible;
  final bool isVehicleVisible;
  final bool isMessageVisible;

  const OpenButton({
    Key? key,
    required this.isNameVisible,
    required this.isAddressVisible,
    required this.isMobileVisible,
    required this.isCompanyNameVisible,
    required this.isEmailVisible,
    required this.isVehicleVisible,
    required this.isMessageVisible,
    required this.queryParams,
  }) : super(key: key);

  @override
  State<OpenButton> createState() => _OpenButtonState();
}

class _OpenButtonState extends State<OpenButton> {
  // Controllers to manage input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String? selectedState;
  String? selectedYear;
  String? selectedVehicleMake;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getDocId();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {

    // Dispose controllers to avoid memory leaks
    nameController.dispose();
    companyNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipcodeController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 900,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Get in Contact",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("We are looking forward to hearing from you!",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),

                // Form Fields Section

                  Row(
                    children: [
                      if (widget.isNameVisible || widget.queryParams.containsKey("Your Name"))
                        Expanded(
                          child: _buildField("Your Name", nameController, 420),
                        ),
                      SizedBox(width: 10),
                      if (widget.isCompanyNameVisible || widget.queryParams.containsKey("Company Name"))
                        Expanded(
                          child: _buildField(
                              "Company Name", companyNameController, 420),
                        ),
                    ],
                  ),
                SizedBox(height: 10),

                  Row(
                    children: [
                      if (widget.isMobileVisible || widget.queryParams.containsKey("Phone Number"))
                        Expanded(
                          child: _buildField(
                              "Phone Number", mobileController, 420,
                              keyboardType: TextInputType.phone),
                        ),
                      SizedBox(width: 10),
                      if (widget.isEmailVisible  || widget.queryParams.containsKey("Email"))
                        Expanded(
                          child: _buildField("Email", emailController, 420,
                              keyboardType: TextInputType.emailAddress),
                        ),
                    ],
                  ),
                SizedBox(height: 10),
                if (widget.isAddressVisible  || widget.queryParams.containsKey("Address"))
                  Row(
                    children: [
                      Expanded(
                        child: _buildField("Address", addressController, 420),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildField("2nd Line", TextEditingController(),
                            420), // Handle appropriately
                      ),
                    ],
                  ),
                SizedBox(height: 10),
                if (widget.isAddressVisible  || widget.queryParams.containsKey("Address"))
                  Row(
                    children: [
                      Expanded(
                        child: _buildField("City", cityController, 280),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: _buildField("Zipcode", zipcodeController, 280),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child:
                        _buildDropdown("State", [], selectedState, (value) {
                          setState(() {
                            selectedState = value;
                          });
                        }),
                      ),
                    ],
                  ),
                SizedBox(height: 10),
                if (widget.isVehicleVisible  || widget.queryParams.containsKey("Vehicle Year"))
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown("Vehicle Year", [], selectedYear,
                                (value) {
                              setState(() {
                                selectedYear = value;
                              });
                            }),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildDropdown(
                            "Vehicle Make", [], selectedVehicleMake, (value) {
                          setState(() {
                            selectedVehicleMake = value;
                          });
                        }),
                      ),
                    ],
                  ),

                _buildField("Message", messageController, 850, maxLines: 3),
                SizedBox(height: 20),

                // Save Button
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _saveForm,
                        child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text("Save",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Save form data
  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM/dd/yyyy hh:mm:ss a').format(now);

      try {
        // Ensure that docid is not null or empty before proceeding
        if (docid.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: Document ID is missing')),
          );
          return;
        }

        // Update the document with the specified docid
        await FirebaseFirestore.instance
            .collection('SaveForm')

            .add({
          'firstname': nameController.text.trim(),
          'address': addressController.text.trim(),
          'city': cityController.text.trim(),
          'zipcode': zipcodeController.text.trim(),
          'state': selectedState,
          'mobile': mobileController.text.trim(),
          'company': companyNameController.text.trim(),
          'email': emailController.text.trim(),
          'vehicleyear': selectedYear,
          'vehiclemake': selectedVehicleMake,
          'message': messageController.text.trim(),
          'date_time': formattedDate,
          'timestamp': DateTime.now().microsecondsSinceEpoch,
          'lastname':"",
          // If you have a separate controller for the last name, replace this with it
          '2ndlineaddress':"",
          'alternate_phone': "",
          'generated_link': "",
          // Replace with an alternate phone controller if available
        }).then((value) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data add successfully')),
          );

          // Navigate to "/settings" using GoRouter
          GoRouter.of(context).go('/settings');
        }).catchError((error) {
          // Show error message if update fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: Data not updated. $error')),
          );
        });
      } catch (e) {
        // Catch and handle other unexpected errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
    }
  }





  // Method to build a text field
  Widget _buildField(
      String label,
      TextEditingController controller,
      double width, {
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 5),
        Container(
          width: width,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }

  // Helper for Dropdown
  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          height: 45,
          width: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              hint: Text("Select $label"),
              onChanged: onChanged,
              items: items
                  .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
  String docid = "";
  getDocId() async {

    var user = await FirebaseFirestore.instance.collection("Users").get();
    for (int i = 0; i < user.docs.length; i++) {
      if (user.docs[i]["userid"] == FirebaseAuth.instance.currentUser!.uid) {
        setState(() {
          docid = user.docs[i].id;

        });
      }
    }
}
  }
