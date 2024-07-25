import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_supabase_riverpood/models/chat_model.dart';
import 'package:chat_supabase_riverpood/provider/chat_data.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  final TextEditingController messagecontroller = TextEditingController();
 @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController messagecontroller = TextEditingController();

  @override
  void initState() {
    messagecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
     final insertData = ref.watch(chatStreamProvider);

        return insertData.when(
          data: (data) {
            List<ChatModel> chatModels = convertToChatModelList(data);
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatModels.length,
                        itemBuilder: (context, index) {
                          return chatModels[index].is_me
                              ? SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                          child: Text(chatModels[index].message),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                          child: Text(chatModels[index].message),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              controller: messagecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                           onPressed: () async {
                                final newmsg = ChatModel(
                                   id: null,
                                   is_me: false,
                                  message: messagecontroller.text,
                                );
                              //await insertmsg(newmsg);
                              //  sersta();

                            messagecontroller.clear();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text("Error: $error"));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
