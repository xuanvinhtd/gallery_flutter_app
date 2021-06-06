import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static dynamic _notInlinedMessages(_) => {
        'photos': MessageLookupByLibrary.simpleMessage('Photos'),
        'videos': MessageLookupByLibrary.simpleMessage('Videos'),
        'cloud': MessageLookupByLibrary.simpleMessage('Clouds'),
        'album': MessageLookupByLibrary.simpleMessage('Album'),
        'allMedia': MessageLookupByLibrary.simpleMessage('All'),
        'gallery': MessageLookupByLibrary.simpleMessage('Gallery'),
        'items': MessageLookupByLibrary.simpleMessage('items')
      };
}
