import 'package:bp_reading/module/home/controller/item_data.dart';
import 'package:bp_reading/module/home/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:bp_reading/core.dart';
import '../controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget build(context, HomeController controller) {
    controller.view = this;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return TwoTextFieldDialog(
                  title: 'Add Record',
                );
              });
        },
      ),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.amber[200],
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (context) {
          //           return TwoTextFieldDialog(
          //             title: 'Add Record',
          //           );
          //         });
          //   },
          //   icon: const Icon(
          //     Icons.add,
          //     size: 24.0,
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("About"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text("TOS"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text("Privacy Policy"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text("Logout"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 30.0,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ListView.builder(
                itemCount: HomeController.instance.itemList.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  ItemData item = HomeController.instance.itemList[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.dateTime),
                      subtitle: Text(item.pulse),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<HomeView> createState() => HomeController();
}
