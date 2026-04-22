import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_dashboard/features/message/data/models/conversation_model.dart';
import 'package:doctor_dashboard/features/message/data/models/message_model.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ConversationModel>> getAllConversations() async {
    final snapshot = await _firestore.collection('conversations').orderBy('lastMessageTime', descending: true).get();

    return snapshot.docs.map((doc) => ConversationModel.fromJson(doc.data(), doc.id)).toList();
  }

  Stream<List<MessageModel>> getMessages(String conversationId) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => MessageModel.fromJson(doc.data(), doc.id)).toList());
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderType,
    required String content,
  }) async {
    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty) return;

    final messageRef = _firestore.collection('conversations').doc(conversationId).collection('messages').doc();

    final message = MessageModel(
      id: messageRef.id,
      senderId: senderId,
      senderType: senderType,
      content: trimmedContent,
      createdAt: DateTime.now(),
      isSeen: false,
    );

    await messageRef.set(message.toJson());

    await _firestore.collection('conversations').doc(conversationId).update({
      'lastMessage': trimmedContent,
      'lastMessageTime': Timestamp.fromDate(DateTime.now()),
      'lastSenderId': senderId,
    });
  }

  Future<void> deleteConversation(String conversationId) async {
    final conversationRef = _firestore.collection('conversations').doc(conversationId);
    final messagesSnapshot = await conversationRef.collection('messages').get();
    for (final doc in messagesSnapshot.docs) {
      await doc.reference.delete();
    }
    await conversationRef.delete();
  }
}
