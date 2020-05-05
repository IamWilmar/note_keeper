// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

NotesModel notesModelFromJson(String str) => NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
    int id;
    String title;
    String note;
    String secret;

    NotesModel({
        this.id,
        this.title,
        this.note,
        this.secret,
    });

    factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        secret: json["secret"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "secret": secret,
    };
}
