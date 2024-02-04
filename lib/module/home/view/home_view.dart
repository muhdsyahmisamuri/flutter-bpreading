import 'package:flutter/material.dart';
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
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const TwoTextFieldDialog(
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
                    title: const Text("Confirm Delete"),
                    content: const Text(
                        "Are you sure you want to delete all items?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("OK"),
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
        backgroundColor: Colors.amber[200],
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text("Information"),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Information"),
                      content: const Text(
                          "To delete an item, swipe it to the side."),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Blood Pressure Chart"),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Blood Pressure Chart"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const Text(
                                "Understand your blood pressure readings:"),
                            const SizedBox(height: 10),
                            Image.asset(
                                'assets/bp_chart.jpg'), // Replace with your image asset
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("About This App"),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text("Blood Pressure Tracker"),
                            Text("Version: 1.0.0"),
                            Text(
                                "This app helps you track and manage your blood pressure readings."),
                            Text("Developed by syahmisam"),
                            Text(
                                "For more information or feedback, contact me at: syahmiemoboyz00@gmail.com"),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: HomeController.instance.itemBox.isEmpty
          ? Center(
              child: SizedBox(
                width: 200, // Medium width, adjust as needed
                height: 200, // Medium height, adjust as needed
                child: Image.asset(
                  'assets/bp_logo.png',
                  fit: BoxFit
                      .contain, // This ensures the image maintains its aspect ratio
                ),
              ),
            )
          : SingleChildScrollView(
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IndicatorWidget(label: 'Low', color: Colors.yellow),
                          IndicatorWidget(label: 'Good', color: Colors.green),
                          IndicatorWidget(label: 'High', color: Colors.red),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: HomeController.instance.itemBox.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final item =
                            HomeController.instance.itemBox.getAt(index);
                        if (item != null) {
                          return Dismissible(
                            key: Key(item.dateTime +
                                index.toString()), // Unique key for Dismissible
                            direction:
                                DismissDirection.endToStart, // Swipe direction
                            onDismissed: (direction) {
                              // Handle the dismissal
                              HomeController.instance.removeItem(index);
                            },
                            background: Container(
                              color: Colors.white,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(Icons.remove_circle_outline,
                                  color: Colors.black38),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: HomeController.instance
                                    .getColorForStatus(item.status),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    item.dateTime,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          const Text(
                                            'SYS',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            item.systolic,
                                            style: const TextStyle(
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
                                              color: Colors.green[200],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            item.diastolic,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          const Text(
                                            'PUL',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            item.pulse,
                                            style: const TextStyle(
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
                            ),
                          );
                        } else {
                          return Container();
                        }
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
