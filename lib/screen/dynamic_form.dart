import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tintwiz_app/dashboard.dart';


class DynamicFormWithLayoutBuilderr extends StatefulWidget {
  @override
  _DynamicFormWithLayoutBuilderState createState() =>
      _DynamicFormWithLayoutBuilderState();
}

class _DynamicFormWithLayoutBuilderState
    extends State<DynamicFormWithLayoutBuilderr> {
  // Field visibility states
  bool _isNameVisible = true;
  bool _isAddressVisible = false;
  bool _isMobileVisible = false;
  bool _isCompanyNameVisible = true;
  bool _isEmailVisible = false;
  bool _isVehicleVisible = false;
  bool _isMessageVisible = true;
  bool _isPreviewVisible = true;

  // Text editing controllers
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _2ndlineController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _alPhoneController = TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();


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

  String generatedURL = "";
  void _generateURL() {
    final queryParams = {
      if (_isCompanyNameVisible) 'Company Name': 'true',
      if (_isNameVisible) 'Your Name': 'true',
      if (_isEmailVisible) 'Email': 'true',
      if (_isMobileVisible) 'Phone Number': 'true',
      if (_isVehicleVisible) 'Vehicle Year': 'true',
      if (_isAddressVisible) 'Address': 'true',
      if (_isMessageVisible) 'Message': 'true',
    };

    final uri = Uri(path: '/about', queryParameters: queryParams);

    setState(() {
      generatedURL = uri.toString();
    });
  }

  Future<String?> getHostingURL() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('hosting')
          .get();

      if (doc.exists) {
        return doc.data()?['base_url'] as String?;
      }
    } catch (e) {
      print('Error fetching hosting URL: $e');
    }
    return null;
  }

  Future<void> setHostingURL(String url) async {
    await FirebaseFirestore.instance.collection('config').doc('hosting').set({
      'base_url': url,
    });
  }


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _generateURL();
  }

  final _formKey =
      GlobalKey<FormState>(); // Step 1: Create a GlobalKey for the form
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6AB187),
        title: Text(
          'Responsive Dynamic Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: _buildCheckboxSection(),
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 2,
                  child: Material(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isPreviewVisible = !_isPreviewVisible;
                                  });
                                },
                                child: Text(
                                  _isPreviewVisible
                                      ? 'Hide Preview'
                                      : 'Show Preview',
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              _isPreviewVisible
                                  ? ElevatedButton(
                                      onPressed: () {
                                        final Map<String, bool> parameters = {
                                          'isNameVisible': _isNameVisible,
                                          'isAddressVisible': _isAddressVisible,
                                          'isMobileVisible': _isMobileVisible,
                                          'isCompanyNameVisible':
                                              _isCompanyNameVisible,
                                          'isEmailVisible': _isEmailVisible,
                                          'isVehicleVisible': _isVehicleVisible,
                                          'isMessageVisible': _isMessageVisible,
                                        };

                                        // Pass parameters to the '/about' route
                                        context.go('/about', extra: parameters);
                                      },
                                      child: Text('Open'))
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(height: 20),
                          if (_isPreviewVisible) _buildFormSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxSection() {
    return Material(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Fields to Add to the Form:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Name'),
              value: _isNameVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isNameVisible = value ?? true;
                  _generateURL();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Address'),
              value: _isAddressVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isAddressVisible = value ?? false;
                  _generateURL();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Mobile'),
              value: _isMobileVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isMobileVisible = value ?? false;
                  _generateURL();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Company Name'),
              value: _isCompanyNameVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isCompanyNameVisible = value ?? false;
                  _generateURL();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Email'),
              value: _isEmailVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isEmailVisible = value ?? false;
                  _generateURL();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Vehicle'),
              value: _isVehicleVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isVehicleVisible = value ?? false;
                  _generateURL();
                });
              },
            ),
            CheckboxListTile(
              title: Text('Message'),
              value: _isMessageVisible,
              onChanged: (bool? value) {
                setState(() {
                  _isMessageVisible = value ?? false;
                  _generateURL();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    final iframeCode =
        '<iframe width="100%" height="1200px" src="$generatedURL" frameborder="0"></iframe>';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        if (_isNameVisible)
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: _buildTextField(
                    _firstnameController,
                    'First Name',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your firstname' : null,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 2,
                  child: _buildTextField(
                    _lastnameController,
                    'LastName',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your lastname' : null,
                  )),
            ],
          ),
        if (_isCompanyNameVisible)
          _buildTextField(
            _companyNameController,
            'Company Name',
            validator: (value) =>
                value!.isEmpty ? 'Please enter your company Name' : null,
          ),
        if (_isAddressVisible)
          Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align items to the start of the column
            children: [
              // Dropdown for State
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: _buildTextField(
                        _addressController,
                        'Address',
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your address' : null,
                      )),
                  SizedBox(width: 10), // Space between Dropdown and TextFields

                  Expanded(
                      flex: 2,
                      child: _buildTextField(
                        _2ndlineController,
                        '2nd Line',
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your 2ndline' : null,
                      )),
                ],
              ),

              SizedBox(height: 10), // Space between Dropdown and TextFields

              // Row for City and Zipcode TextFields
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align items evenly
                children: [
                  // City TextField
                  Expanded(
                    flex: 2, // Adjust flex as needed
                    child: _buildTextField(
                      _cityController,
                      'City',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your city' : null,
                    ),
                  ),
                  SizedBox(width: 10), // Space between TextFields

                  // Zipcode TextField
                  Expanded(
                    flex: 2, // Adjust flex as needed
                    child: _buildTextField(
                      _zipcodeController,
                      'Zipcode',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your zipcode' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: 430,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedState,
                    onChanged: (value) {
                      setState(() {
                        selectedState = value!;
                        // Update the controller
                      });
                    },
                    items: stateList.map((state) {
                      return DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        SizedBox(
          height: 10,
        ),
        if (_isMobileVisible)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(
                  _mobileController,
                  'Mobile',
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your mobile' : null,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: _buildTextField(
                  _alPhoneController,
                  'Alternate Phone',
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your Alternate phone number'
                      : null,
                ),
              ),
            ],
          ),
        if (_isEmailVisible)
          _buildTextField(
            _emailController,
            'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value!.isEmpty ? 'Please enter your email' : null,
          ),
        if (_isVehicleVisible)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: 430,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedYear,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!; // Update the selected year
                        });
                      },
                      items: yearList.map((year) {
                        return DropdownMenuItem(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: 430,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedVehicleMake, // Selected value
                      hint: Text("Select Vehicle Make"), // Placeholder
                      onChanged: (value) {
                        setState(() {
                          selectedVehicleMake =
                              value; // Update the selected make
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
              ),
            ],
          ),

        if (_isMessageVisible)
          _buildTextField(
            _messageController,
            'Message',
            validator: (value) =>
                value!.isEmpty ? 'Please enter your message' : null,
          ),

        GestureDetector(
          onTap: () async {
            String? hostingURL = await getHostingURL();
            if (hostingURL != null) {
              String fullURL = '$hostingURL$generatedURL';
              context.go(fullURL);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Hosting URL not found')),
              );
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: FutureBuilder<String?>(
              future: getHostingURL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading URL...');
                }
                if (snapshot.hasData) {
                  String fullURL = '${snapshot.data}$generatedURL';
                  return Text(
                    'Click to Open: $fullURL',
                    style: TextStyle(color: Colors.blue),
                  );
                }
                return Text(
                  'No Hosting URL Available',
                  style: TextStyle(color: Colors.red),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        // Embed Code Display
        InkWell(
          onTap: (){
            Clipboard.setData(ClipboardData(text: iframeCode));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Iframe code copied to clipboard!"),
              ),
            );
          },
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
            ),
            child: SelectableText(
              iframeCode,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: _saveFormData,
          child: Container(
            height: 40,
            width: 130,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                "Save Form",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    double height = 50.0,
    double width = double.infinity,
    int maxLines = 1,
    int? minLines,
    String? Function(String?)? validator, // Add validator parameter
  }) {
    return Container(
      height: height + 25,
      width: width,
      child: TextFormField(
        // Use TextFormField instead of TextField
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: label,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
       // validator: validator, // Set the validator
      ),
    );
  }

  void _saveFormData() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM/dd/yyyy hh:mm:ss a').format(now);

      // Generate the link
      //String generatedLink = generateLink();

      try {
        await FirebaseFirestore.instance.collection('SaveForm').add({
          'firstname': _firstnameController.text,
          'lastname': _lastnameController.text,
          // If you have a separate controller for the last name, replace this with it
          'address': _addressController.text,
          '2ndlineaddress': _2ndlineController.text,
          'city': _cityController.text,
          'zipcode': _zipcodeController.text,
          'state': selectedState,
          'mobile': _mobileController.text,
          'alternate_phone': "",
          // Replace with an alternate phone controller if available
          'company': _companyNameController.text,
          'email': _emailController.text,
          'vehicleyear': selectedYear,
          'vehiclemake': selectedVehicleMake,
          'message': _messageController.text,
          'date_time': formattedDate,
          'timestamp': DateTime.now().microsecondsSinceEpoch,
          "userid":FirebaseAuth.instance.currentUser!.uid,
          'generated_link': generatedURL, // Store the generated link
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully')),
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard()));

        // Clear form fields after saving
        _clearFields();
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  // Method to clear all the fields after saving
  void _clearFields() {
    _firstnameController.clear();
    _lastnameController.clear();
    _addressController.clear();
    _2ndlineController.clear();
    _cityController.clear();
    _zipcodeController.clear();
    _mobileController.clear();
    _companyNameController.clear();
    _emailController.clear();
    _alPhoneController.clear();
    _messageController.clear();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _addressController.dispose();
    _2ndlineController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();
    _mobileController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _alPhoneController.dispose();
    _messageController.dispose();

    super.dispose();
  }
}
