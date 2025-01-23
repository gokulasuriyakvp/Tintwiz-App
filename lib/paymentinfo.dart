import 'package:flutter/material.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.save),
                        const SizedBox(width: 8),
                        const Text("Tintwize"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.group_work),
                        const SizedBox(width: 8),
                        const Text("Tintwize"),
                        const SizedBox(width: 8),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Icon(Icons.arrow_drop_down),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.settings,size: 35,),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios,size: 30),
                SizedBox(width: 8),
                Icon(Icons.refresh,size: 35,),
                SizedBox(width: 8),
                Text("Subscription",style: TextStyle(
                  fontSize: 30,
                ),),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Manage your subscription",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 4,
              child: Container(
                height: 70,
                width: 750,
                //padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically if possible
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(width: 8),
                          const Text(
                            "You don't have an active subscription.",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center, // Center-aligns the text within its container
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      const Text(
                        "Subscribe below to get access to the advanced features of Tintwize",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

              ),
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 6,
              child: Container(
                height: 350,
                width: 750,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 4,
                      child: Container(
                        width: 700,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: const [
                                  Icon(Icons.check),
                                  SizedBox(width: 8),
                                  Text("Standard"),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right:50,top: 10),
                              child: Text(
                                "Get unlimited access to all Tint Wiz features and"
                                    " continuous support for one business/location.",
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(

                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("\$100.00 / month / business"),
                                  Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.check, color: Colors.white, size: 16),
                                        SizedBox(width: 4),
                                        Text("Selected", style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Payment Information",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20
                          ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 700,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.picture_as_pdf),
                              const SizedBox(width: 8), // Space between the icon and text field
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none, // Removes the default border
                                    hintText: "Enter your information",
                                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjusts vertical padding
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xff000000),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Text(
                                    "Autofill Link",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 150,
                            //padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check, color: Colors.white, size: 16),
                                SizedBox(width: 4),
                                Text("Subscribe", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            // padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(child: Text("Back")),
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
      ),
    );
  }
}
