// ref. https://codelabs.developers.google.com/codelabs/dart-patterns-records?hl=ja#6
import 'dart:convert';

void main() {
  final (title, :modified) = getMetadata();
  print('title: $title, modified: $modified');
}

final _json = jsonDecode('''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''') as Map<String, Object?>;

// Dart 3以前の場合
// (String, {DateTime modified}) getMetadata() {
//   if (_json.containsKey('metadata')) {
//     final metadataJson = _json['metadata'];
//     if (metadataJson is Map) {
//       final title = metadataJson['title'] as String;
//       final localModified = DateTime.parse(metadataJson['modified'] as String);
//       return (title, modified: localModified);
//     }
//   }
//   throw const FormatException('Unexpected JSON');
// }

// Dart 3以上の場合
(String, {DateTime modified}) getMetadata() {
  if (_json
      case {
        'metadata': {
          'title': final String title,
          'modified': final String localModified,
        }
      }) {
    return (title, modified: DateTime.parse(localModified));
  } else {
    throw const FormatException('Unexpected JSON');
  }
}
