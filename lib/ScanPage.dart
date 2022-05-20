import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fridge/Dialogs/Dialogs.dart';
import 'package:fridge/templates/templates.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool _toggle = true;
  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      floatingButton: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "point the camera at a barcode",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
          GestureDetector(
            onTap: () async {
              String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", "Cancel", false, ScanMode.DEFAULT);
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (context) => ErrorDialog(
                  action: () {
                    Navigator.pop(context);
                  },
                  title: 'SCANNED',
                  text: barcodeScanRes != "-1"
                      ? barcodeScanRes
                      : "No item scanned",
                  buttonTitle: "OK THANKS",
                ),
              );
            },
            child: const Image(
              image: AssetImage('image/scanCamera.png'),
              height: 220,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            elevation: 6,
            shadowColor: const Color(0x77767FCB),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
              height: 60,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _toggle = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: const AssetImage('image/scan.png'),
                              opacity: _toggle ? 1 : 0.5),
                        ),
                        height: 60,
                        width: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _toggle = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: const AssetImage('image/add.png'),
                              opacity: _toggle ? 0.5 : 1),
                        ),
                        height: 60,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 110,
          )
        ],
      ),
    );
  }
}
