import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPost {
  Image postImage;
  DateTime createdAt;
  String eventCategory;
  String jenjang;
  String keterangan;
  String lokasi;
  DateTime eventDate;

  DetailPost(
    this.postImage,
    this.createdAt,
    this.eventCategory,
    this.jenjang,
    this.keterangan,
    this.lokasi,
    this.eventDate,
);

  Map<String, dynamic> toJson() => {
    'postImage': postImage,
    'createdAt': createdAt,
    'eventCategory': eventCategory,
    'jejang': jenjang,
    'keterangan': keterangan,
    'lokasi': lokasi,
    'eventDate': eventDate,
  };

  DetailPost.fromSnapshot(DocumentSnapshot snapshot) :
      postImage = snapshot['postImage'],
      createdAt = snapshot['createdAt'],
      eventCategory = snapshot['eventCategory'],
      jenjang = snapshot['jenjang'],
      keterangan = snapshot['keterangan'],
      lokasi = snapshot['lokasi'],
      eventDate = snapshot['eventDate'];
}