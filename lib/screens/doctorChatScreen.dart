// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:grad_app/services/firestore_service.dart';
// import '../const.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../model/doctor.dart';
// import 'HomeScreen.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String userId;
//   final String doctorId;
//
//   ChatScreen({required this.userId, required this.doctorId});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   FirestoreService firestore = FirestoreService();
//   TextEditingController _controller = TextEditingController();
//   File? _imageFile;
//   Uint8List? _imageBytes;
//   final ImagePicker _picker = ImagePicker();
//   List<ChatDoctorModel> messages = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialMessages();
//     _listenForNewMessages();
//   }
//
//   Future<void> _fetchInitialMessages() async {
//     List<ChatDoctorModel> initialMessages =
//         await firestore.getChatMessages(widget.userId, widget.doctorId);
//     setState(() {
//       messages = initialMessages;
//       isLoading = false;
//     });
//   }
//
//   void _listenForNewMessages() {
//     firestore
//         .getChatMessagesStream(widget.userId, widget.doctorId)
//         .listen((newMessages) {
//       if (mounted) {
//         setState(() {
//           messages = newMessages;
//         });
//       }
//     });
//   }
//
//   Future<void> _sendMessage({required bool isDoctor}) async {
//     if (_controller.text.isEmpty && _imageBytes == null) return;
//
//     ChatDoctorModel message = ChatDoctorModel(
//       id: '',
//       msg: _controller.text,
//       receiverId: widget.doctorId,
//       senderId: widget.userId,
//       timestamp: DateTime.now(),
//       isDoctor: isDoctor,
//     );
//
//     if (mounted) {
//       setState(() {
//         messages.insert(0, message);
//       });
//     }
//     await firestore.addChatMessage(widget.userId, widget.doctorId, message);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: Colors.white,
//         backgroundColor: primary,
//         centerTitle: true,
//         title: Text(
//           "Chat",
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontFamily: 'Open Sans',
//             fontWeight: FontWeight.bold,
//             height: 0.05,
//             letterSpacing: 0.44,
//           ),
//         ),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(color: primary),
//             )
//           : Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       reverse: true,
//                       itemCount: messages.length,
//                       itemBuilder: (context, index) {
//                         var message = messages[index];
//                         print(message.isDoctor);
//                         return Align(
//                           alignment: message.isDoctor
//                               ? Alignment.centerLeft
//                               : Alignment.centerRight,
//                           child: _buildTextMessage(message),
//                           // child: message.imageUrl != null
//                           //     ? _buildImageMessage(message)
//                           //     : _buildTextMessage(message),
//                         );
//                       },
//                     ),
//                   ),
//                   SafeArea(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: primary),
//                       padding: EdgeInsets.symmetric(vertical: 3),
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () async {
//                               _imageBytes = await pickImageFromGallery();
//                             },
//                             icon: Icon(Icons.attach_file, color: Colors.white),
//                           ),
//                           Expanded(
//                             child: TextField(
//                               controller: _controller,
//                               decoration: InputDecoration(
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: const BorderSide(
//                                       color: Colors.white, width: 2),
//                                 ),
//                                 border: const OutlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Colors.white)),
//                                 hintText: 'Type your message here...',
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 10),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () async {
//                               if (_controller.text.isNotEmpty) {
//                                 _sendMessage(isDoctor: isDoctor);
//                                 _controller.clear();
//                               }
//                             },
//                             icon: const Icon(Icons.send, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget _buildTextMessage(ChatDoctorModel message) {
//     return Container(
//       margin:  message.isDoctor
//           ? const EdgeInsets.only(right: 100, top: 5)
//           : const EdgeInsets.only(left: 100, top: 5),
//       child: Chip(
//         backgroundColor: Colors.grey[200],
//         label: Text(
//           overflow: TextOverflow.ellipsis,
//           maxLines: 100,
//           message.msg,
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageMessage(ChatDoctorModel message) {
//     return Column(
//       crossAxisAlignment:
//           message.isDoctor ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//           margin: message.isDoctor
//               ? const EdgeInsets.only(right: 100)
//               : const EdgeInsets.only(left: 100),
//           // child: Image.file(File(message.imageUrl!)),
//         ),
//         if (message.msg.isNotEmpty)
//           Container(
//             child: Chip(
//               backgroundColor: primary,
//               label: Text(
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 100,
//                 message.msg,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   Future<Uint8List?> pickImageFromGallery() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       return await pickedFile.readAsBytes();
//     } else {
//       return null;
//     }
//   }
// }
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/services/firestore_service.dart';
import '../const.dart';
import 'package:image_picker/image_picker.dart';

import '../model/doctor.dart';
import 'HomeScreen.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String doctorId;

  ChatScreen({required this.userId, required this.doctorId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirestoreService firestore = FirestoreService();
  TextEditingController _controller = TextEditingController();
  File? _imageFile;
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  List<ChatDoctorModel> messages = [];
  bool isLoading = true;
  var userName, docName;

  @override
  void initState() {
    super.initState();
    _fetchInitialMessages();
    _listenForNewMessages();
    // _checkIfDoctor();
  }

  Future<void> _fetchInitialMessages() async {
    var docInfo = await firestore.getUserInfo(widget.doctorId);
    var userInfo = await firestore.getUserInfo(widget.userId);
    docName = docInfo?['name'];
    userName = userInfo?['name'];
    List<ChatDoctorModel> initialMessages =
        await firestore.getChatMessages(widget.userId, widget.doctorId);
    setState(() {
      messages = initialMessages;
      isLoading = false;
    });
  }

  void _listenForNewMessages() {
    firestore
        .getChatMessagesStream(widget.userId, widget.doctorId)
        .listen((newMessages) {
      if (mounted) {
        setState(() {
          messages = newMessages;
        });
      }
    });
  }

  // Future<void> _checkIfDoctor() async {
  //   var docInfo = await firestore.getUserInfo(widget.doctorId);
  //   var userInfo = await firestore.getUserInfo(widget.userId);
  //   docName = docInfo?['name'];
  //   userName = userInfo?['name'];
  //   setState(() {});
  // }

  Future<void> _sendMessage({required bool isDoctor}) async {
    if (_controller.text.isEmpty && _imageBytes == null) return;

    ChatDoctorModel message = ChatDoctorModel(
      imageUrl: _imageFile?.path,
      id: '',
      msg: _controller.text,
      receiverId: widget.doctorId,
      senderId: widget.userId,
      timestamp: DateTime.now(),
      isDoctor: isDoctor,
    );

    if (mounted) {
      setState(() {
        messages.insert(0, message);
      });
    }
    await firestore.addChatMessage(widget.userId, widget.doctorId, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: primary,
        centerTitle: true,
        title: !isLoading
            ? Text(
                currentId == widget.userId ? "Dr. $docName" : userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  height: 0.05,
                  letterSpacing: 0.44,
                ),
              )
            : Text(''),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: primary),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        print(message.isDoctor);
                        if (isDoctor == message.isDoctor) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: _buildTextMessage(message),
                          );
                        } else if (isDoctor != message.isDoctor) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: _buildTextMessage(message),
                          );
                        }
                      },
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primary),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          if (_imageFile != null)
                            InkWell(
                              onTap: () {},
                      onLongPress: () {
                        _imageFile = null;
                        _imageBytes = null;
                        setState(() {});},
                              child: Container(
                                  padding: EdgeInsets.only(right: 3),
                                  height: 60,
                                  child: Image.file(File(_imageFile!.path))),
                            ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              maxLines: null,
                              minLines: 1,
                              controller: _controller,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: 'Type your message here...',
                                hintStyle: const TextStyle(color: Colors.white),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  _imageBytes = await pickImageFromGallery(
                                      isCamera: false);
                                },
                                icon: const Icon(Icons.attach_file,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (_controller.text.isNotEmpty) {
                                    _sendMessage(isDoctor: isDoctor);
                                    _controller.clear();
                                  }
                                  _imageFile = null;
                                  _imageBytes = null;
                                  setState(() {});
                                },
                                icon:
                                    const Icon(Icons.send, color: Colors.white),
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

  Widget _buildTextMessage(ChatDoctorModel message) {
    if (isDoctor == message.isDoctor) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            margin: message.senderId == widget.userId
                ? const EdgeInsets.only(left: 100)
                : const EdgeInsets.only(right: 100),
            child:message.imageUrl!=null? Image.file(File(message.imageUrl!)):null,
          ),
          Container(
            margin: const EdgeInsets.only(left: 100, top: 5),
            child: Chip(
              backgroundColor: primary,
              label: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
                message.msg,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    } else if (isDoctor != message.isDoctor) {
      return Container(
        margin: const EdgeInsets.only(right: 100, top: 5),
        child: Chip(
          backgroundColor: Colors.grey[200],
          label: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 100,
            message.msg,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      return const Text('');
    }
  }

  Widget _buildImageMessage(ChatDoctorModel message) {
    return Column(
      crossAxisAlignment: message.senderId == widget.userId
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          margin: message.senderId == widget.userId
              ? const EdgeInsets.only(left: 100)
              : const EdgeInsets.only(right: 100),
          child:message.imageUrl!=null? Image.file(File(message.imageUrl!)):null,
        ),
        if (message.msg.isNotEmpty)
          Container(
            child: Chip(
              backgroundColor: primary,
              label: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
                message.msg,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Future<Uint8List?> pickImageFromGallery({required bool isCamera}) async {
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
}
