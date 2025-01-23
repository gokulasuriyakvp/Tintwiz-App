import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:tintwiz_app/screen/contacts_screen.dart';



import 'lead_form.dart';


class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
         // primarySwatch: Colors.teal,
          useMaterial3: false
      ),
      home: const MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff6AB187),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 230,
            child: SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                // Customize selected title and icon colors
                selectedTitleTextStyle: TextStyle(color: Colors.blue),
                selectedIconColor: Colors.blue,
                backgroundColor: Colors.grey[200],
                iconSize: 20,
                // Set the display mode of the side menu
                displayMode: SideMenuDisplayMode.auto,

              ),
              items: [
                SideMenuItem(
                  title: 'Lead Forms',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.supervisor_account),
                ),
                SideMenuItem(
                  title: 'Contacts',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.download),
                ),
              ],
            ),
          )
          ,
          const VerticalDivider(width: 1),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                LeadForm(),
                ContactsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
