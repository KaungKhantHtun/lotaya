import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:hakathon_service/utils/constants.dart';

import '../../widgets/loading_widget.dart';
import 'chat.dart';
import 'core/firebase_chat_core.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  bool showLoading = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showLoading = false;
      });
    });
    super.initState();
    //only test for first time
    // FirebaseChatCore.instance.createUserInFirestore(currentUser);
    // FirebaseChatCore.instance.createUserInFirestore(adminUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorPrimary,
        backgroundColor: colorPrimaryLight,
         centerTitle: true,
        title: Text(
          'Chats'.toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              showLoading) {
            print("loading data");

            return LoadingWidget();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No rooms'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final room = snapshot.data![index];

                return FutureBuilder<String>(
                    future: FirebaseChatCore.instance.lastMessages(room),
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: room,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    room.name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    snapshot.data ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    });
              },
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
