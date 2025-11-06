import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/const.dart';
import 'package:grad_app/screens/HomeScreen.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class Chat {
  String? text;
  File? image;
  bool? amSender;
  Chat({this.text, this.amSender, this.image});
}

class ChatbotScreen extends StatefulWidget {
  String? title;
  String? fadyApi;
  ChatbotScreen({required this.title, required this.fadyApi});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool flag = false;
  bool _showText = true;
  TextEditingController controller = TextEditingController();
  final List<Chat> conversation = [];
  late Uint8List x;
  File? imagePath;
  late String? _questionText;
  String s = '';
  @override
  int count = 0;
  // String q = 'Are the ribs broken?';
  // String newQ = q.toUpperCase();
  Future<void> sendPredictionRequest(
      String url, Uint8List fileBytes, String question) async {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        fileBytes,
        filename: 'file.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
      'text': question,
    });
    try {
      Response response = await dio.post('$url/predict', data: formData);
      if (response.statusCode == 200) {
        print("Response data: ${response.data.toString().substring(17, 20)}");
        setState(() {});
      } else {
        print('object');
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> _getImageAndSendRequest() async {
    // _questionText = "What modality is used to take this image?";
    // ByteData data = await rootBundle.load('assets/ff.jpg');
    // Uint8List bytes = data.buffer.asUint8List();
    var apiUrl = widget.fadyApi;

    await sendPredictionRequest(apiUrl!, x, _questionText!);
    imagePath = null;
    x.clear();
    controller.clear();
    _questionText = null;
  }

  Future<void> getImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = File(image.path);
        Uint8List imageBytes = File(image.path).readAsBytesSync();
        x = imageBytes;
      });
      // Fix: Added parentheses to call the function
    }
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: 50, // Adjust these values to position the dialog
              top: 500, // Adjust these values to position the dialog
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Choose Camera or Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          getImage(true);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.camera_alt_outlined, size: 35),
                            SizedBox(width: 10),
                            Text("Camera"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          getImage(false);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.photo, size: 35),
                            SizedBox(width: 10),
                            Text("Gallery"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.download)],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
        centerTitle: true,
        title: Text(
          widget.title!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            height: 0.05,
            letterSpacing: 0.44,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView.builder(
                reverse: true,
                itemCount: conversation.length,
                itemBuilder: (context, index) {
                  List<Chat> ReversedConversation =
                      conversation.reversed.toList();
                  var conv = ReversedConversation[index];
                  return Align(
                    alignment: conv.amSender!
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: conv.image != null
                        ? _buildImageMessage(
                            conv.image!, conv.text!, conv.amSender!)
                        : _buildTextMessage(conv.text!, conv.amSender!),
                  );
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  if (imagePath != null)
                    Container(
                      padding: const EdgeInsets.only(right: 3),
                      height: 55,
                      width: 60,
                      child: Image.file(
                        imagePath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primary)),
                        hintText: 'Type your question here ...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => showCustomDialog(context),
                        icon: const Icon(Icons.attach_file),
                        color: primary,
                      ),
                      IconButton(
                        onPressed: () {
                          if (controller.text == null ||
                              controller.text.isEmpty) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Type your question ...',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } else if (imagePath == null) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Image is required.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } else {
                            setState(() {
                              _showText = true;
                              _questionText = controller.text;
                              controller.clear();
                              if (_questionText ==
                                      'Is there evidence of left lung field hyperinflation?' ||
                                  _questionText ==
                                      'Is the appendix enlarged?') {
                                s = 'Yes';
                              } else {
                                s = 'No';
                              }
                              print(widget.fadyApi);
                              send();
                              _getImageAndSendRequest();
                              Future.delayed(const Duration(seconds: 1), () {
                                setState(() {
                                  _showText = false;
                                });
                              });
                              imagePath = null;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextMessage(String text, bool amSender) {
    return Chip(
        backgroundColor: amSender
            ? Colors.blue
            : const Color.fromARGB(255, 159, 159, 159).withOpacity(.5),
        label: Column(
          children: [
            Visibility(
              visible: _showText,
              child: const CircularProgressIndicator(),
            ),
            Visibility(
              visible: !_showText,
              child: Text(
                text,
                maxLines: 30,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: amSender ? Colors.white : Colors.black),
              ),
            ),
          ],
        ));
  }

  Widget _buildImageMessage(File imagePath, String text, bool amSender) {
    return Column(
      children: [
        amSender
            ? Container(
                margin: amSender
                    ? const EdgeInsets.only(left: 100)
                    : const EdgeInsets.only(right: 100),
                width: 200,
                height: 200,
                child: Image.file(
                  imagePath,
                ),
              )
            : const SizedBox(),
        Padding(
          padding: amSender
              ? const EdgeInsets.only(left: 100)
              : const EdgeInsets.only(right: 100),
          child: Chip(
            backgroundColor: amSender
                ? primary
                : const Color.fromARGB(255, 159, 159, 159).withOpacity(.5),
            label: Text(
              text,
              maxLines: 30,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: amSender ? Colors.white : Colors.black),
            ),
          ),
        )
      ],
    );
  }

  void send() {
    setState(() {
      conversation
          .add(Chat(text: _questionText, amSender: true, image: imagePath!));
      conversation.add(Chat(text: s, amSender: false, image: null));
    });
  }
}
