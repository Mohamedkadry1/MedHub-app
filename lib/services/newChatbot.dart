import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grad_app/const.dart';
import 'package:grad_app/services/firestore_service.dart';

import '../model/chatbotMessage.dart';

class NewChatbotPage extends StatefulWidget {
  final String userId;
  final String title;
  final String fadyApi;

  NewChatbotPage(
      {required this.userId, required this.title, required this.fadyApi});

  @override
  _NewChatbotPageState createState() => _NewChatbotPageState();
}

class _NewChatbotPageState extends State<NewChatbotPage> {
  List<ChatbotModel> messages = [];
  FirestoreService firestore = FirestoreService();
  bool isLoading = true;
  TextEditingController _controller = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _showText = true;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    _listenForNewMessages();
  }

  Future<void> _fetchMessages() async {
    List<ChatbotModel> _fetchedMessages =
    await firestore.getChatbotMessages(widget.userId);
    setState(() {
      messages = _fetchedMessages;
      isLoading = false;
    });
  }
  void _listenForNewMessages() {
    firestore.getChatbotMessagesStream(widget.userId).listen((newMessages) {
      setState(() {
        messages = newMessages;
      });
    });
  }
  Future<void> _sendMessage({String? imageUrl, required bool isUser}) async {
    ChatbotModel message = ChatbotModel(
      id: widget.userId,
      text: _controller.text,
      imageUrl: imageUrl,
      timestamp: DateTime.now(), isUser: isUser,
    );
    if (_controller.text.isEmpty && imageUrl == null) return;
    ChatbotModel _message = ChatbotModel(
      id: '',
      text: _controller.text,
      imageUrl: imageUrl,
      isUser: isUser,
      timestamp: DateTime.now(),
    );
    setState(() {
      messages.insert(0, message);
    });
    _controller.clear();
    await firestore.addChatbotMessage(widget.userId, message);
    // Send message to AI model
    _getResponseAndSendRequest(imageUrl);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // String imageUrl = await firestore.uploadImage(widget.userId, pickedFile.path);
      _sendMessage(imageUrl: _imageFile?.path, isUser: true);
    }
  }

  Future<void> _getResponseAndSendRequest(String? imageUrl) async {
    await Future.delayed(Duration(seconds: 2), () {
      ChatbotModel aiResponse = ChatbotModel(
        text: 'hi',
        imageUrl: null,
        timestamp: DateTime.now(), isUser: false, id: '',
      );

      firestore.addChatbotMessage(widget.userId, aiResponse);
    });
    // ChatbotModel aiMessage = ChatbotModel(
    //   id: '',
    //   text: 'hi',
    //   isUser: false,
    //   timestamp: DateTime.now(),
    // );
    // await firestore.addChatbotMessage(widget.userId, aiMessage);
    if (_controller.text.isEmpty && imageUrl == null) return;

    String url = widget.fadyApi;
    String questionText = _controller.text;

    // Use Dio to send the prediction request
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(imageUrl!).readAsBytesSync(),
        filename: 'file.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
      'text': questionText,
    });
    try {
      Response response = await dio.post('$url/predict', data: formData);

      if (response.statusCode == 200) {
        String responseText = response.data.toString();
        ChatbotModel aiMessage = ChatbotModel(
          id: '',
          text: responseText,
          isUser: false,
          timestamp: DateTime.now(),
        );
        setState(() {
          messages.insert(0, aiMessage);
        });
        // await firestore.addChatbotMessage(widget.userId, aiMessage);
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
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
        child: CircularProgressIndicator(
          color: primary,
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<List<ChatbotModel>>(
              stream: firestore.getChatbotMessagesStream(widget.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: primary),
                  );
                }

                // if (!snapshot.hasData || snapshot.data!.isEmpty) {
                //   return Center(
                //     child: Text('No messages yet.'),
                //   );
                // }

                var newMsg = snapshot.data!;
                messages=newMsg;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: message.imageUrl != null
                          ? _buildImageMessage(message)
                          : _buildTextMessage(message),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.attach_file, color: primary),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: primary, width: 2.0),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primary)),
                        hintText: 'Type your message here...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _sendMessage(isUser: true),
                    icon: const Icon(Icons.send, color: primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextMessage(ChatbotModel message) {
    return Chip(
      backgroundColor: message.isUser ? primary : Colors.grey[200],
      label: Text(
        message.text,
        style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildImageMessage(ChatbotModel message) {
    return Column(
      crossAxisAlignment:
      message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Image.network(message.imageUrl!),
        ),
        if (message.text.isNotEmpty)
          Chip(
            backgroundColor: message.isUser ? primary : Colors.grey[200],
            label: Text(
              message.text,
              style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black),
            ),
          ),
      ],
    );
  }
}
