import 'package:flutter/material.dart';
import 'package:whatsweatherdoing/utilities/constants.dart';
import 'package:url_launcher/link.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.photoData}) : super(key: key);
  final photoData;

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, String> _photoData = {};
  String artistName = '';
  String artistUri = '';
  String fallbackUri = '';
  String imageUri = '';
  var city = '';
  var customImg;
  String utmSource = '?utm_source=https://www.whatsweatherdoing.com';
  String utmReferral = '&utm_medium=referral';
  String unsplashUri = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.photoData);
  }

  void updateUI(Map<String, String> photoData) {
    _photoData = photoData;
    // render random image
    setState(() {
      artistName = _photoData['artistName'].toString();
      artistUri = _photoData["artistUri"].toString() + utmSource + utmReferral;
      imageUri = _photoData['imageUri'].toString();
      unsplashUri = 'https://unsplash.com$utmSource$utmReferral';

      if (imageUri != '') {
        customImg = NetworkImage(imageUri, scale: 1);
      } else {
        customImg = NetworkImage(fallbackUri, scale: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle uiButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.white,
      minimumSize: const Size(64, 64),
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor: Colors.white30,
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(
              style: BorderStyle.none,
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          }
          return BorderSide(
            style: BorderStyle.none,
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ); // Defer to the widget's default.
        },
      ),
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: customImg,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 0, bottom: 0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 42.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter city name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: OutlinedButton(
                          style: uiButtonStyle,
                          onPressed: () {
                            // pass data back to previous screen/or any screen
                            Navigator.pop(context, city);
                          },
                          child: const Icon(
                            Icons.search_outlined,
                            color: Color(kBrandBlue),
                            size: 42.0,
                          ),
                        ),
                      ),
                      onChanged: ((value) {
                        // assign value and pass value to weather module
                        city = value;
                      }),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Photo by: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Link(
                        uri: Uri.parse(artistUri),
                        target: LinkTarget.blank,
                        builder: (context, followLink) => MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: followLink,
                            child: Text(
                              artistName,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'on',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Link(
                        uri: Uri.parse(unsplashUri),
                        target: LinkTarget.blank,
                        builder: (context, followLink) => MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: followLink,
                            child: const Text(
                              "Unsplash",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
