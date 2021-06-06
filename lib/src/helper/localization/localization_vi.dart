import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'vi';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static dynamic _notInlinedMessages(_) => {
        'photos': MessageLookupByLibrary.simpleMessage('Hình ảnh'),
        'videos': MessageLookupByLibrary.simpleMessage('Videos'),
        'cloud': MessageLookupByLibrary.simpleMessage('Đám mây'),
        'album': MessageLookupByLibrary.simpleMessage('Album'),
        'allMedia': MessageLookupByLibrary.simpleMessage('Tất cả'),
        'gallery': MessageLookupByLibrary.simpleMessage('Bộ sưu tập ảnh'),
        'items': MessageLookupByLibrary.simpleMessage('Mục')
      };
}
