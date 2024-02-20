
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kezel/modelclass.dart';

class MenuitemDetails extends StatefulWidget {
  const MenuitemDetails({Key? key}) : super(key: key);

  @override
  State<MenuitemDetails> createState() => _MenuitemDetailsState();
}

class _MenuitemDetailsState extends State<MenuitemDetails> {
  List<Products> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    'Sorry',
                    style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'No products available.',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100),
                  ),

                ],
              ),
            )
          :  GridView.count(
        childAspectRatio: 0.50,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          for (int i = 1; i <= products.length; i++)
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromARGB(66, 7, 7, 7),
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 100,
                      height: 100,
                      child: ClipOval(
                        child: Image.network(
                          products[i - 1].image ?? '',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2),
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Text(
                        products[i - 1].name ?? "Product Title",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      products[i - 1].desc ??
                          'Write Description of the product',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          products[i - 1].currency ??
                              'Write Description of the product ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10), // Add space between texts
                        Text(
                          products[i - 1].amount ??
                              'Write Description of the product',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                              
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
