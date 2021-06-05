import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'vi';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static dynamic _notInlinedMessages(_) => {
        'home': MessageLookupByLibrary.simpleMessage('Trang chủ'),
        'search': MessageLookupByLibrary.simpleMessage('Tìm kiếm'),
        'favorite': MessageLookupByLibrary.simpleMessage('Yêu thích')
      };
}
