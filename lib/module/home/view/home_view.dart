import 'package:flutter/material.dart';
import 'package:bp_reading/module/home/controller/item_data.dart';
import 'package:bp_reading/module/home/widget/dialog.dart';
import 'package:bp_reading/core.dart';
import '../controller/home_controller.dart';
import '../widget/indicator_status.dart';

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
            },
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.amber[200],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Delete"),
                    content: Text("Are you sure you want to delete all items?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          HomeController.instance.clearItems();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.delete_forever,
              size: 24.0,
              color: Colors.red[400],
            ),
          ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IndicatorWidget(label: 'High', color: Colors.red),
                    IndicatorWidget(label: 'Good', color: Colors.green),
                    IndicatorWidget(label: 'Low', color: Colors.yellow),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: HomeController.instance.itemList.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  ItemData item = HomeController.instance.itemList[index];
                  return Dismissible(
                      key: Key(item.dateTime +
                          index.toString()), // Unique key for Dismissible
                      direction: DismissDirection.endToStart, // Swipe direction
                      onDismissed: (direction) {
                        // Handle the dismissal
                        HomeController.instance.removeItem(index);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              item.dateTime,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'SYS',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      item.systolic,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'DIA',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      item.diastolic,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'PUL',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      item.pulse,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
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
