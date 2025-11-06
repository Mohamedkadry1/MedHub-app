import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grad_app/const.dart';
import 'package:grad_app/services/firestore_service.dart';
import '../model/chatbotMessage.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class NewChatbotPage extends StatefulWidget {
  final String userId;
  final String title;
  final String url;

  NewChatbotPage(
      {required this.userId, required this.title, required this.url});

  @override
  _NewChatbotPageState createState() => _NewChatbotPageState();
}

class _NewChatbotPageState extends State<NewChatbotPage> {
  FirestoreService firestore = FirestoreService();
  TextEditingController _controller = TextEditingController();
  File? _imageFile;
  Uint8List? _imageBytes;
  List<ChatbotModel> messages = [];
  bool isLoading = true;
  Uint8List? imageData;
  List<String> questions = [];
  List<String> answers = [];
  bool showProgress = false;
  @override
  void initState() {
    super.initState();
    _fetchInitialMessages();
    _listenForNewMessages();
  }

  Future<void> _fetchInitialMessages() async {
    List<ChatbotModel> initialMessages =
        await firestore.getChatbotMessages(widget.userId);
    setState(() {
      messages = initialMessages;
      for (var message in messages) {
        if (message.isUser) {
          questions.add(message.text);
        } else {
          answers.add(message.text);
        }
      }
      isLoading = false;
    });
  }

  void _listenForNewMessages() {
    firestore.getChatbotMessagesStream(widget.userId).listen((newMessages) {
      if (mounted) {
        setState(() {
          messages = newMessages;
          questions.clear();
          answers.clear();
          for (var message in messages) {
            if (message.isUser) {
              questions.add(message.text);
            } else {
              answers.add(message.text);
            }
          }
        });
      }
    });
  }

  Future<void> _sendMessage(
      {required bool isUser, required bool isImage, String? q}) async {
    // if (_controller.text.isEmpty && imageData == null) return;

    ChatbotModel message = ChatbotModel(
      id: '',
      text: q!,
      imageUrl: isImage ? _imageFile?.path : null,
      isUser: isUser,
      timestamp: DateTime.now(),
    );

    if (mounted) {
      setState(() {
        messages.insert(0, message);
      });
    }
    await firestore.addChatbotMessage(widget.userId, message);
  }

  Future<void> _generateAndDownloadPdf(
      {required List<String> questions,
      required List<String> answers,
      required bool isArabic}) async {
    String url = isArabic
        ? 'https://render-api-ar.onrender.com/generate_pdf/?'
        : 'https://api-report-8b02.onrender.com/generate_pdf/?';

    for (int i = 0; i < questions.length; i++) {
      url +=
          "question=${Uri.encodeQueryComponent(questions[i])}&answer=${Uri.encodeQueryComponent(answers[i])}&";
    }
    String name = 'report.pdf';

    setState(() {
      isLoading = true;
    });

    try {
      await FileDownloader.downloadFile(
        url: url,
        name: name,
        onProgress: (String? fileName, double progress) {
          setState(() {
            isLoading = false;
          });
          print('Downloading $fileName: $progress');
        },
        onDownloadCompleted: (String path) {
          setState(() {
            isLoading = false;
          });
          print('File downloaded to: $path');
        },
        onDownloadError: (String error) {
          setState(() {
            isLoading = false;
          });
          print('Download error: $error');
        },
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error while downloading: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                // showCustomDialog(context,
                //     isImage: false,
                //     title: 'Download Report',
                //     t1: 'English Version',
                //     t2: "Arabic Version");
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    animType: AnimType.rightSlide,
                    title: 'Download Report',
                    desc: 'Select language.',
                    btnCancel: InkWell(
                      onTap: () {
                        _generateAndDownloadPdf(
                            questions: questions,
                            answers: answers,
                            isArabic: false);
                      },
                      child: Image.asset(
                        'images/united-kingdom.png',
                        width: 50,
                        height: 45,
                      ),
                    ),
                    btnOk: InkWell(
                      onTap: () {
                        _generateAndDownloadPdf(
                            questions: questions,
                            answers: answers,
                            isArabic: true);
                      },
                      child: Image.asset('images/arabic.png',
                          width: 50, height: 45),
                    )).show();
              },
              icon: const Icon(
                Icons.download,
                color: primary,
                size: 35,
              ),
            ),
          )
        ],
        shadowColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: primary,
            fontSize: 24,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            height: 0.05,
            letterSpacing: 0.44,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: primary),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        print("is user${message.isUser}");
                        return Align(
                          alignment: message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: message.imageUrl != null
                              ? _buildImageMessage(message)
                              : _buildTextMessage(message),
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primary),
                      padding: EdgeInsets.only(left: 3, top: 4, bottom: 4),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          if (_imageFile != null)
                            InkWell(
                              onTap: () {},
                              onLongPress: () {
                                _imageFile = null;
                                _imageBytes = null;
                                imageData = null;
                                setState(() {});
                              },
                              child: Container(
                                  padding: EdgeInsets.only(right: 3),
                                  height: 60,
                                  child: Image.file(File(_imageFile!.path))),
                            ),
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              minLines: 1,
                              controller: _controller,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                hintText: 'Type your message here...',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => showCustomDialog(context,
                                    title: 'Choose Camera or Gallery',
                                    isImage: true,
                                    t1: "Camera",
                                    t2: "Gallery"),
                                //     () async {
                                //   // pickImageFromGallery(); //getImage(false);
                                //   // imageData = await pickImageFromGallery();
                                // },
                                icon: Icon(Icons.attach_file,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (_controller.text.isEmpty) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Error',
                                      desc: 'Type your question ...',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  } else {
                                    try {
                                      String q = _controller.text;
                                      _controller.clear();
                                      if (imageData != null) {
                                        _imageBytes = imageData;
                                        String res =
                                            await checkImage(_imageBytes!);
                                        print(res.length);
                                        print(res);
                                        if (!res.contains('N')) {
                                          print('assssssssssdd');
                                          print(imageData);
                                          _sendMessage(
                                              isUser: true,
                                              isImage: true,
                                              q: q);
                                          print("is Image? = $res");
                                          _controller.clear();
                                          _imageFile = null;
                                          imageData = null;
                                          String response =
                                              await predict(_imageBytes!, q);
                                          print('Prediction: $response');
                                          setState(() {});
                                        } else {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.rightSlide,
                                            title: 'Error',
                                            desc:
                                                'The image is not CT,MRI or X-ray',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {},
                                          ).show();
                                        }
                                      } else {
                                        askQuestion(q: q);
                                        _sendMessage(
                                            isUser: true, isImage: false, q: q);
                                      }
                                    } catch (e) {
                                      print('Error: $e');
                                      // Handle error
                                    }
                                  }
                                },
                                icon:
                                     Icon(Icons.send, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextMessage(ChatbotModel message) {
    return Container(
      margin: message.isUser
          ? const EdgeInsets.only(left: 100, top: 5)
          : const EdgeInsets.only(right: 100, top: 5),
      child: Chip(
        backgroundColor: message.isUser ? primary : Colors.grey[200],
        label: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 100,
          message.text,
          style: TextStyle(color: message.isUser ? white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildImageMessage(ChatbotModel message) {
    return Column(
      crossAxisAlignment:
          message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          margin: message.isUser
              ? const EdgeInsets.only(left: 100)
              : const EdgeInsets.only(right: 100),
          child: Image.file(File(message.imageUrl!)),
        ),
        if (message.text.isNotEmpty)
          Container(
            child: Chip(
              backgroundColor: primary,
              label: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
                message.text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Future<Uint8List?> pickImageFromGallery(bool isCamera) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      return await pickedFile.readAsBytes();
    } else {
      return null;
    }
  }

  Future<String> predict(Uint8List imageData, String question) async {
    String url =
        '${widget.url}/predict'; // Replace with your FastAPI server URL
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        http.MultipartFile.fromBytes('file', imageData, filename: 'image.jpg'));
    request.fields['question'] = question;
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String _response = jsonResponse['prediction'];
        ChatbotModel aiMessage = ChatbotModel(
          id: '',
          text: _response,
          isUser: false,
          timestamp: DateTime.now(),
        );
        if (mounted) {
          setState(() {
            messages.insert(0, aiMessage);
          });
        }
        await firestore.addChatbotMessage(widget.userId, aiMessage);
        return jsonResponse[
            'prediction']; // Adjust based on API response structure
      } else {
        throw 'Failed to get prediction: ${response.statusCode}';
      }
    } catch (e) {
      String _response = 'Failed to connect to server: $e';
      ChatbotModel aiMessage = ChatbotModel(
        id: '',
        text: _response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      if (mounted) {
        setState(() {
          messages.insert(0, aiMessage);
        });
      }
      await firestore.addChatbotMessage(widget.userId, aiMessage);
      throw 'Failed to connect to server: $e';
    }
  }

  Future<String> checkImage(Uint8List imageData) async {
    String url = 'https://type-of-image.onrender.com/predict';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        http.MultipartFile.fromBytes('file', imageData, filename: 'image.jpg'));
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse['image_type'];
      } else {
        throw 'Failed to get prediction: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to connect to server: $e';
    }
  }

  Future<String> askQuestion({required String q}) async {
    String url = 'https://render-llm.onrender.com/chat?question=$q';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        ChatbotModel aiMessage = ChatbotModel(
          id: '',
          text: jsonResponse['text'],
          isUser: false,
          timestamp: DateTime.now(),
        );
        if (mounted) {
          setState(() {
            messages.insert(0, aiMessage);
          });
        }
        await firestore.addChatbotMessage(widget.userId, aiMessage);
        print('ressssssssss= $jsonResponse');
        return jsonResponse['text'];
      } else {
        String _response =
            'Failed to connect to server: ${response.statusCode}';
        ChatbotModel aiMessage = ChatbotModel(
          id: '',
          text: _response,
          isUser: false,
          timestamp: DateTime.now(),
        );
        if (mounted) {
          setState(() {
            messages.insert(0, aiMessage);
          });
        }
        await firestore.addChatbotMessage(widget.userId, aiMessage);
        throw 'Failed to get prediction: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to connect to server: $e';
    }
  }

  void showCustomDialog(BuildContext context,
      {required String title,
      required bool isImage,
      required String t1,
      required String t2}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: 50, // Adjust these values to position the dialog
              top: isImage
                  ? 500
                  : 100, // Adjust these values to position the dialog
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
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          Navigator.of(context).pop();
                          if (isImage) {
                            imageData = await pickImageFromGallery(true);
                          } else {}
                        },
                        child: Row(
                          children: [
                            isImage
                                ? Icon(Icons.camera_alt_outlined, size: 35)
                                : Image.asset(
                                    'images/united-kingdom.png',
                                    width: 35,
                                    height: 35,
                                  ),
                            SizedBox(width: 10),
                            Text(t1),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          Navigator.of(context).pop();
                          if (isImage) {
                            imageData = await pickImageFromGallery(false);
                          }
                        },
                        child: Row(
                          children: [
                            isImage
                                ? Icon(Icons.photo, size: 35)
                                : Image.asset(
                                    'images/arabic.png',
                                    width: 35,
                                    height: 35,
                                  ),
                            SizedBox(width: 10),
                            Text(t2),
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
}
