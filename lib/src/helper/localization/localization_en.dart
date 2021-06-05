import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static dynamic _notInlinedMessages(_) => {
        'home': MessageLookupByLibrary.simpleMessage('Home'),
        'search': MessageLookupByLibrary.simpleMessage('Search'),
        'favorite': MessageLookupByLibrary.simpleMessage('Favorite')
      };
}
