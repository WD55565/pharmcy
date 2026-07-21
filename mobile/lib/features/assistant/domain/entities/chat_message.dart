import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

enum ChatMessageRole { user, assistant }

/// A single message in the assistant conversation. [content] is markdown —
/// rendered by `ChatMessageBubble`, not parsed here.
@freezed
sealed class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required ChatMessageRole role,
    required String content,
    required DateTime sentAt,
  }) = _ChatMessage;
}
