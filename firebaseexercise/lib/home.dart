import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:kezel/About.dart';
import 'package:kezel/Products.dart';
import 'package:kezel/auth/auth.dart';
import 'package:kezel/modelclass.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Productsdetails> digitalMenuData;
  FirebaseAuth auth = FirebaseAuth.instance;
  String Name = "";
  String Email = "";
  @override
  void initState() {
    super.initState();
    digitalMenuData = fetchDigitalMenuData();
    _getDataFromDatabase();
  }

  Future<Productsdetails> fetchDigitalMenuData() async {
    final response = await http.post(
      Uri.parse('https://kezel.co/api/getAllDigitalMenu.php'),
      body: {'restaurant': 'LeisureInnVKL'},
    );

    if (response.statusCode == 200) {
      return Productsdetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load digital menu data');
    }
  }

  Future<void> _getDataFromDatabase() async {
    try {
      var userId = auth.currentUser?.uid;
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("Profile")
          .get();

      if (snapshot.docs.isNotEmpty) {
        var userData = snapshot.docs.first.data();

        setState(() {
          Name = userData['username'];
          Email = userData['email'];
        });
      } else {
        print("No documents found in Firestore, attempting Google login...");

        // Attempt Google login
        final userCredential = await signInWithGoogle();
        final User user = userCredential.user!;

        setState(() {
          Name = user.displayName ?? "No Name";
          Email = user.email ?? "No Email";
        });
      }
    } catch (e) {
      print("Error getting data from the database or Google login: $e");
    }
  }

  final ctrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          FutureBuilder<Productsdetails>(
            future: digitalMenuData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.deccanherald.com/deccanherald%2Fimport%2Fsites%2Fdh%2Ffiles%2Farticleimages%2F2021%2F08%2F20%2Ffile7h5h2m0my9d1idq08p75-1021903-1629480873.jpg?auto=format%2Ccompress&fmt=webp&fit=max&w=1200',
                            fit: BoxFit.cover,
                          
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 40,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: Icon(Icons.menu),
                            iconSize: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 111,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Order,Eat,',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 2,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: ' \nRepeat',
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            '\nSpecial menu offers',
                            style: TextStyle(
                              color: Color.fromARGB(255, 164, 199, 48),
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            'Discover our menu',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: 0,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              //scrollDirection: Axis.vertical,

                              itemCount: snapshot.data?.menuItems?.length ?? 0,
                              itemBuilder: (context, index) {
                                final menuItem =
                                    snapshot.data?.menuItems?[index]; //fgfgf
                                return Bounceable(
                                  onTap: () {
                                    Get.to(() => MenuitemDetails(),
                                        arguments: snapshot
                                            .data!.menuItems![index].products,
                                        transition: Transition.downToUp);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 170,
                                    margin: EdgeInsets.only(
                                        bottom: 10, left: 0, right: 18),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            menuItem?.sliderImage ??
                                                ""), //hghggg
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.2),
                                          Colors.transparent
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 10,
                                          bottom: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                menuItem?.name ?? "", //hghghg
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Name.isNotEmpty
                  ? "${Name[0].toUpperCase()}${Name.substring(1).toLowerCase()}"
                  : "Loading..."),
              accountEmail: Text(
                Email,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  Name.isNotEmpty ? Name[0] : "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Name'),
              subtitle: Text("$Name"),
              leading: Icon(Icons.person),
            ),
            Divider(thickness: 4),
            ListTile(
              title: Text('Email'),
              subtitle: Text("$Email"),
              leading: Icon(Icons.mail),
            ),
            Divider(thickness: 4),
            ListTile(
              title: Text('About'),
              subtitle: Text("About Us"),
              leading: Icon(Icons.format_align_center),
              onTap: () {
                digitalMenuData.then((productDetails) {
                  Website website = productDetails.website ?? Website();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebsitePage(website: website),
                  ));
                                });
              },
            ),
            Divider(thickness: 4),
            ListTile(
              title: Text('Logout'),
              textColor: Colors.red,
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onTap: () {
                ctrl.signout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
  