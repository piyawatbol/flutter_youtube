import 'package:json_annotation/json_annotation.dart';

part 'youtube_chat_model.g.dart';

@JsonSerializable()
class YoutubeChatModel {
  @JsonKey(name: "nextPageToken")
  String nextPageToken;
  @JsonKey(name: "items")
  List<Item> items;

  YoutubeChatModel({
    required this.nextPageToken,
    required this.items,
  });

  factory YoutubeChatModel.fromJson(Map<String, dynamic> json) =>
      _$YoutubeChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$YoutubeChatModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "snippet")
  Snippet snippet;
  @JsonKey(name: "authorDetails")
  AuthorDetails authorDetails;

  Item({
    required this.snippet,
    required this.authorDetails,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class AuthorDetails {
  @JsonKey(name: "displayName")
  String displayName;
  @JsonKey(name: "profileImageUrl")
  String profileImageUrl;

  AuthorDetails({
    required this.displayName,
    required this.profileImageUrl,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);
}

@JsonSerializable()
class Snippet {
  @JsonKey(name: "displayMessage")
  String displayMessage;
  @JsonKey(name: "textMessageDetails")
  TextMessageDetails textMessageDetails;

  Snippet({
    required this.displayMessage,
    required this.textMessageDetails,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);
}

@JsonSerializable()
class TextMessageDetails {
  @JsonKey(name: "messageText")
  String messageText;

  TextMessageDetails({
    required this.messageText,
  });

  factory TextMessageDetails.fromJson(Map<String, dynamic> json) =>
      _$TextMessageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TextMessageDetailsToJson(this);
}
