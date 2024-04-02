import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:quotes_app/headers.dart';

import '../../utills/app_data.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({super.key});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  double opacity = 1;
  GlobalKey widgetKey = GlobalKey();
  Color color = Colors.white;
  bool _canPop = false;
  TextStyle fontFamily = AppData.instance.quoteFontFamily[0];
  double quoteFontSize = 14;

  GlobalKey key = GlobalKey();

  Future<File> getFile() async {
    RenderRepaintBoundary boundary =
    key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 15,
    );
    ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List uInt8list = bytes!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
        "${directory.path}/QA-${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(uInt8list);

    return file;
  }

  Widget saveChild = const Icon(Icons.save_alt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Quote quote = ModalRoute.of(context)!.settings.arguments as Quote;
    // Quote author = ModalRoute.of(context)!.settings.arguments as Quote;
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        if (val) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Alert !!"),
            content: const Text("Are you sure to exit?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ],
          ),
        ).then((value) {
          if (_canPop) {
            Navigator.pop(context);
          }
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2D2F41),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Details Page"),
          actions: [
            IconButton(
              onPressed: () {
                opacity = 1;
                color = Colors.white;
                setState(() {});
              },
              icon: const Icon(Icons.next_plan),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color.withOpacity(opacity),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(quote.quote),
                          SelectableText("- ${quote.author}"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.25,
                          ),
                          const Text(
                            "Edit BackGround  Color",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              opacity = 1;
                              color = Colors.white;
                              setState(() {});
                            },
                            icon: const Icon(Icons.refresh_sharp),
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            18,
                            (index) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  color = Colors.primaries[index];
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.primaries[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Slider(
                          activeColor: Colors.white60,
                          // secondaryActiveColor: Colors.black54,
                          value: opacity,
                          min: 0,
                          max: 1,
                          onChanged: (val) {
                            opacity = val;
                            setState(() {});
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          color = Colors.grey;
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text("Pick a color")),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: color,
                                        paletteType: PaletteType.hueWheel,
                                        onColorChanged: (Color value) {
                                          color = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                  FloatingActionButton(
                                    onPressed: () async {
                                      saveChild = const CircularProgressIndicator();
                                      setState(() {});
                                      File file = await getFile();
                                      ImageGallerySaver.saveFile(file.path).then((value) {
                                        saveChild = const Icon(Icons.done);
                                        setState(() {});
                                      });
                                    },
                                    child: saveChild,
                                  ),
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
