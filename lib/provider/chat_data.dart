import 'package:chat_supabase_riverpood/models/chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabaseprovider = Provider((ref) => Supabase.instance.client);
final insertmessageProvider = Provider((ref) {
  final supabase = ref.watch(supabaseprovider);

  Future<ChatModel> insertmsg(ChatModel chatmodel) async {
    final response = await supabase
        .from('Chat')
        .insert({'message': chatmodel.message, 'is_me': chatmodel.is_me})
        .select()
        .single();

    if (response != null) {
      print("Insertion failed");
    }

    final insertedRecord = response as Map<String, dynamic>;
    final id = insertedRecord['id'];
    print("Inserted record message: $id");

    return ChatModel(id: id,message: chatmodel.message, is_me: chatmodel.is_me );
  }

  return insertmsg;
});


final chatStreamProvider = StreamProvider.autoDispose((ref) {
  final supabase = ref.watch(supabaseprovider);
  return supabase.from('Chat').stream(primaryKey: ['*']);
});