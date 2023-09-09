import 'package:flutter/material.dart';
import 'package:hakathon_service/domain/entities/cloth_entity.dart';
import 'package:hakathon_service/domain/entities/wear_type.dart';

const String testTable = "test";
const String bookingTable = "booking";
const Color colorPrimary = Color(0xff1f467d);
const Color headerSectionColor = Color(0xfff0ffff);
const Color colorSecondary = Color(0xffffba00);
const Color colorSecondaryVariant = Color(0xfff9f3e8);
const Color colorGrey = Color(0xfff7f8fa);
const Color fontColorGrey = Color(0xffadb4b6);

const TextStyle headerStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

const TextStyle regularStyle = TextStyle(
  fontSize: 13,
  // fontWeight: FontWeight.w600,
);

const String mapApiKey = "AIzaSyBcQNwTBaKpuGRkJWDCytVvG0v7nqZRrwc";
List<ClothEntity> originalClothList = [
  ClothEntity(
      id: "1",
      name: "Coat",
      imgUrl: "assets/jacket.png",
      wearType: WearType.outWear,
      dryCleanPrice: 500,
      washAndIconPrice: 250,
      ironPrice: 200),
  ClothEntity(
      id: "2",
      name: "Coat",
      imgUrl: "assets/jacket.png",
      wearType: WearType.outWear,
      dryCleanPrice: 500,
      washAndIconPrice: 250,
      ironPrice: 200),
  ClothEntity(
      id: "3",
      name: "Coat",
      imgUrl: "assets/jacket.png",
      wearType: WearType.outWear,
      dryCleanPrice: 500,
      washAndIconPrice: 250,
      ironPrice: 200),
];
