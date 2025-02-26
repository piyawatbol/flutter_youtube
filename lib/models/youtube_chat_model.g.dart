// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeChatModel _$YoutubeChatModelFromJson(Map<String, dynamic> json) =>
    YoutubeChatModel(
      nextPageToken: json['nextPageToken'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YoutubeChatModelToJson(YoutubeChatModel instance) =>
    <String, dynamic>{
      'nextPageToken': instance.nextPageToken,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      authorDetails:
          AuthorDetails.fromJson(json['authorDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'snippet': instance.snippet,
      'authorDetails': instance.authorDetails,
    };

AuthorDetails _$AuthorDetailsFromJson(Map<String, dynamic> json) =>
    AuthorDetails(
      displayName: json['displayName'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
    );

Map<String, dynamic> _$AuthorDetailsToJson(AuthorDetails instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'profileImageUrl': instance.profileImageUrl,
    };

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
      displayMessage: json['displayMessage'] as String,
      textMessageDetails: TextMessageDetails.fromJson(
          json['textMessageDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
      'displayMessage': instance.displayMessage,
      'textMessageDetails': instance.textMessageDetails,
    };

TextMessageDetails _$TextMessageDetailsFromJson(Map<String, dynamic> json) =>
    TextMessageDetails(
      messageText: json['messageText'] as String,
    );

Map<String, dynamic> _$TextMessageDetailsToJson(TextMessageDetails instance) =>
    <String, dynamic>{
      'messageText': instance.messageText,
    };
