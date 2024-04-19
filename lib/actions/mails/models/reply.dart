import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply.freezed.dart';

part 'reply.g.dart';

@freezed
class Reply with _$Reply {
  factory Reply({
    required int id,
    required String description,
    required DateTime created,
    required DateTime modified,
  }) = _Reply;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}
