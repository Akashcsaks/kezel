
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kezel/modelclass.dart';

class WebsitePage extends StatefulWidget {
  final Website website;

  WebsitePage({required this.website});

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8, top: 2),
              width: 200,
              height: 200,
              child: Image.network(
                '${widget.website.image}',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11, top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About us",
                    style: GoogleFonts.abyssinicaSil(
                      fontSize: 27,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text("${widget.website.aboutUs}"),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Contact info",
                    style: GoogleFonts.abyssinicaSil(
                      fontSize: 27,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text('phone: ${widget.website.phone}'),
                  Text('mobile : ${widget.website.mobile}'),
                  Text('email: ${widget.website.email}'),
                  Text("address:${widget.website.address}"),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                "${widget.website.copyright}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
