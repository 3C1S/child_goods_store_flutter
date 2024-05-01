import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ESubCategory {
  manTop('남아 상의', EMainCategory.clothing, FontAwesomeIcons.shirt),
  womanTop('여아 상의', EMainCategory.clothing, FontAwesomeIcons.shirt),
  manBottom('남아 하의', EMainCategory.clothing, FontAwesomeIcons.tent),
  womanBottom('여아 하의', EMainCategory.clothing, FontAwesomeIcons.tent),
  socks('양말', EMainCategory.clothing, FontAwesomeIcons.socks),
  otherClothing(
      '기타 의류', EMainCategory.clothing, FontAwesomeIcons.barsStaggered),

  manShoes('남아 신발', EMainCategory.accessories, FontAwesomeIcons.shoePrints),
  womanShoes('여아 신발', EMainCategory.accessories, FontAwesomeIcons.shoePrints),
  bag('가방', EMainCategory.accessories, FontAwesomeIcons.briefcase),
  hat('모자', EMainCategory.accessories, FontAwesomeIcons.hatWizard),
  accessory('악세서리', EMainCategory.accessories, FontAwesomeIcons.splotch),
  otherAccessories(
      '기타 잡화', EMainCategory.accessories, FontAwesomeIcons.barsStaggered),

  diaper('기저귀', EMainCategory.babyKidsItems, FontAwesomeIcons.baby),
  stroller('유모차', EMainCategory.babyKidsItems, FontAwesomeIcons.babyCarriage),
  babyCarrier(
      '아기띠', EMainCategory.babyKidsItems, FontAwesomeIcons.personBreastfeeding),
  carSeat('카시트', EMainCategory.babyKidsItems, FontAwesomeIcons.car),
  rider('보행기/쏘서', EMainCategory.babyKidsItems, FontAwesomeIcons.personWalking),
  furniture('가구/침대/매트', EMainCategory.babyKidsItems, FontAwesomeIcons.bed),
  bedding(
      '이불/침구', EMainCategory.babyKidsItems, FontAwesomeIcons.mattressPillow),
  babySkincare('유아동 스킨케어', EMainCategory.babyKidsItems, FontAwesomeIcons.flask),
  otherBabyKidsItems(
      '기타 유아동 용품', EMainCategory.babyKidsItems, FontAwesomeIcons.barsStaggered),

  wipes('물티슈', EMainCategory.hygieneCleaning, FontAwesomeIcons.boxTissue),
  bath('목욕/구강용품', EMainCategory.hygieneCleaning, FontAwesomeIcons.bath),
  cleaningItems(
      '세정용품', EMainCategory.hygieneCleaning, FontAwesomeIcons.pumpSoap),
  disinfectant(
      '소독기', EMainCategory.hygieneCleaning, FontAwesomeIcons.hardDrive),
  otherHygieneCleaning('기타 위생/세척', EMainCategory.hygieneCleaning,
      FontAwesomeIcons.barsStaggered),

  doll('인형', EMainCategory.toys, FontAwesomeIcons.otter),
  robot('로봇', EMainCategory.toys, FontAwesomeIcons.robot),
  sports('스포츠', EMainCategory.toys, FontAwesomeIcons.baseballBatBall),
  waterPlay('물놀이', EMainCategory.toys, FontAwesomeIcons.personSwimming),
  educationalToy('교구', EMainCategory.toys, FontAwesomeIcons.bookOpen),
  playhouseTent('놀이집 텐트/미끄럼틀', EMainCategory.toys, FontAwesomeIcons.campground),
  otherToys('기타 교구/완구', EMainCategory.toys, FontAwesomeIcons.barsStaggered),

  maternityClothing('임부의류/수유복', EMainCategory.maternityItems,
      FontAwesomeIcons.personBreastfeeding),
  maternitySkincare(
      '임부 스킨케어', EMainCategory.maternityItems, FontAwesomeIcons.flask),
  otherMaternityItems('기타 임부 의류/용품', EMainCategory.maternityItems,
      FontAwesomeIcons.barsStaggered),

  food('식품', EMainCategory.feedingSupplies, FontAwesomeIcons.bowlRice),
  formula(
      '분유', EMainCategory.feedingSupplies, FontAwesomeIcons.prescriptionBottle),
  bottle('젖병', EMainCategory.feedingSupplies, FontAwesomeIcons.bottleWater),
  feedingSupplies('수유 용품', EMainCategory.feedingSupplies,
      FontAwesomeIcons.personBreastfeeding),
  plates('수저/식판/이유식 용품', EMainCategory.feedingSupplies,
      FontAwesomeIcons.kitchenSet),
  otherFeedingSupplies('기타 식품/수유/이유 용품', EMainCategory.feedingSupplies,
      FontAwesomeIcons.barsStaggered);

  final String text;
  final EMainCategory mainCategory;
  final IconData icon;

  const ESubCategory(
    this.text,
    this.mainCategory,
    this.icon,
  );

  static String? toJson(ESubCategory? en) {
    switch (en) {
      case ESubCategory.manTop:
        return 'MAN_TOP';
      case ESubCategory.womanTop:
        return 'WOMAN_TOP';
      case ESubCategory.manBottom:
        return 'MAN_BOTTOM';
      case ESubCategory.womanBottom:
        return 'WOMAN_BOTTOM';
      case ESubCategory.socks:
        return 'SOCKS';
      case ESubCategory.otherClothing:
        return 'OTHER_CLOTHING';

      case ESubCategory.manShoes:
        return 'MAN_SHOES';
      case ESubCategory.womanShoes:
        return 'WOMAN_SHOES';
      case ESubCategory.bag:
        return 'BAG';
      case ESubCategory.hat:
        return 'HAT';
      case ESubCategory.accessory:
        return 'ACCESSORY';
      case ESubCategory.otherAccessories:
        return 'OTHER_ACCESSORIES';

      case ESubCategory.diaper:
        return 'DIAPER';
      case ESubCategory.stroller:
        return 'STROLLER';
      case ESubCategory.babyCarrier:
        return 'BABY_CARRIER';
      case ESubCategory.carSeat:
        return 'CAR_SEAT';
      case ESubCategory.rider:
        return 'RIDER';
      case ESubCategory.furniture:
        return 'FURNITURE';
      case ESubCategory.bedding:
        return 'BEDDING';
      case ESubCategory.babySkincare:
        return 'BABY_SKINCARE';
      case ESubCategory.otherBabyKidsItems:
        return 'OTHER_BABY_KIDS_ITEMS';

      case ESubCategory.wipes:
        return 'WIPES';
      case ESubCategory.bath:
        return 'BATH';
      case ESubCategory.cleaningItems:
        return 'CLEANING_ITEMS';
      case ESubCategory.disinfectant:
        return 'DISINFECTANT';
      case ESubCategory.otherHygieneCleaning:
        return 'OTHER_HYGIENE_CLEANING';

      case ESubCategory.doll:
        return 'DOLL';
      case ESubCategory.robot:
        return 'ROBOT';
      case ESubCategory.sports:
        return 'SPORTS';
      case ESubCategory.waterPlay:
        return 'WATER_PLAY';
      case ESubCategory.educationalToy:
        return 'EDUCATIONAL_TOY';
      case ESubCategory.playhouseTent:
        return 'PLAYHOUSE_TENT';
      case ESubCategory.otherToys:
        return 'OTHER_TOYS';

      case ESubCategory.maternityClothing:
        return 'MATERNITY_CLOTHING';
      case ESubCategory.maternitySkincare:
        return 'MATERNITY_SKINCARE';
      case ESubCategory.otherMaternityItems:
        return 'OTHER_MATERNITY_ITEMS';

      case ESubCategory.food:
        return 'FOOD';
      case ESubCategory.formula:
        return 'FORMULA';
      case ESubCategory.bottle:
        return 'BOTTLE';
      case ESubCategory.feedingSupplies:
        return 'FEEDING_SUPPLIES';
      case ESubCategory.plates:
        return 'PLATES';
      case ESubCategory.otherFeedingSupplies:
        return 'OTHER_FEEDING_SUPPLIES';
      default:
        return null;
    }
  }

  static ESubCategory? fromJson(String? str) {
    switch (str?.toUpperCase()) {
      case 'MAN_TOP':
        return ESubCategory.manTop;
      case 'WOMAN_TOP':
        return ESubCategory.womanTop;
      case 'MAN_BOTTOM':
        return ESubCategory.manBottom;
      case 'WOMAN_BOTTOM':
        return ESubCategory.womanBottom;
      case 'SOCKS':
        return ESubCategory.socks;
      case 'OTHER_CLOTHING':
        return ESubCategory.otherClothing;

      case 'MAN_SHOES':
        return ESubCategory.manShoes;
      case 'WOMAN_SHOES':
        return ESubCategory.womanShoes;
      case 'BAG':
        return ESubCategory.bag;
      case 'HAT':
        return ESubCategory.hat;
      case 'ACCESSORY':
        return ESubCategory.accessory;
      case 'OTHER_ACCESSORIES':
        return ESubCategory.otherAccessories;

      case 'DIAPER':
        return ESubCategory.diaper;
      case 'STROLLER':
        return ESubCategory.stroller;
      case 'BABY_CARRIER':
        return ESubCategory.babyCarrier;
      case 'CAR_SEAT':
        return ESubCategory.carSeat;
      case 'RIDER':
        return ESubCategory.rider;
      case 'FURNITURE':
        return ESubCategory.furniture;
      case 'BEDDING':
        return ESubCategory.bedding;
      case 'BABY_SKINCARE':
        return ESubCategory.babySkincare;
      case 'OTHER_BABY_KIDS_ITEMS':
        return ESubCategory.otherBabyKidsItems;

      case 'WIPES':
        return ESubCategory.wipes;
      case 'BATH':
        return ESubCategory.bath;
      case 'CLEANING_ITEMS':
        return ESubCategory.cleaningItems;
      case 'DISINFECTANT':
        return ESubCategory.disinfectant;
      case 'OTHER_HYGIENE_CLEANING':
        return ESubCategory.otherHygieneCleaning;

      case 'DOLL':
        return ESubCategory.doll;
      case 'ROBOT':
        return ESubCategory.robot;
      case 'SPORTS':
        return ESubCategory.sports;
      case 'WATER_PLAY':
        return ESubCategory.waterPlay;
      case 'EDUCATIONAL_TOY':
        return ESubCategory.educationalToy;
      case 'PLAYHOUSE_TENT':
        return ESubCategory.playhouseTent;
      case 'OTHER_TOYS':
        return ESubCategory.otherToys;

      case 'MATERNITY_CLOTHING':
        return ESubCategory.maternityClothing;
      case 'MATERNITY_SKINCARE':
        return ESubCategory.maternitySkincare;
      case 'OTHER_MATERNITY_ITEMS':
        return ESubCategory.otherMaternityItems;

      case 'FOOD':
        return ESubCategory.food;
      case 'FORMULA':
        return ESubCategory.formula;
      case 'BOTTLE':
        return ESubCategory.bottle;
      case 'FEEDING_SUPPLIES':
        return ESubCategory.feedingSupplies;
      case 'PLATES':
        return ESubCategory.plates;
      case 'OTHER_FEEDING_SUPPLIES':
        return ESubCategory.otherFeedingSupplies;
      default:
        return null;
    }
  }
}

extension SSubCategoryExtension on String {
  ESubCategory get subCategoryEnum {
    switch (this) {
      case '남아 상의':
        return ESubCategory.manTop;
      case '여아 상의':
        return ESubCategory.womanTop;
      case '남아 하의':
        return ESubCategory.manBottom;
      case '여아 하의':
        return ESubCategory.womanBottom;
      case '양말':
        return ESubCategory.socks;
      case '기타 의류':
        return ESubCategory.otherClothing;

      case '남아 신발':
        return ESubCategory.manShoes;
      case '여아 신발':
        return ESubCategory.womanShoes;
      case '가방':
        return ESubCategory.bag;
      case '모자':
        return ESubCategory.hat;
      case '악세서리':
        return ESubCategory.accessory;
      case '기타 잡화':
        return ESubCategory.otherAccessories;

      case '기저귀':
        return ESubCategory.diaper;
      case '유모차':
        return ESubCategory.stroller;
      case '아기띠':
        return ESubCategory.babyCarrier;
      case '카시트':
        return ESubCategory.carSeat;
      case '보행기/쏘서':
        return ESubCategory.rider;
      case '가구/침대/매트':
        return ESubCategory.furniture;
      case '이불/침구':
        return ESubCategory.bedding;
      case '유아동 스킨케어':
        return ESubCategory.babySkincare;
      case '기타 유아동 용품':
        return ESubCategory.otherBabyKidsItems;

      case '물티슈':
        return ESubCategory.wipes;
      case '목욕/구강용품':
        return ESubCategory.bath;
      case '세정용품':
        return ESubCategory.cleaningItems;
      case '소독기':
        return ESubCategory.disinfectant;
      case '기타 위생/세척':
        return ESubCategory.otherHygieneCleaning;

      case '인형':
        return ESubCategory.doll;
      case '로봇':
        return ESubCategory.robot;
      case '스포츠':
        return ESubCategory.sports;
      case '물놀이':
        return ESubCategory.waterPlay;
      case '교구':
        return ESubCategory.educationalToy;
      case '놀이집 텐트/미끄럼틀':
        return ESubCategory.playhouseTent;
      case '기타 교구/완구':
        return ESubCategory.otherToys;

      case '임부의류/수유복':
        return ESubCategory.maternityClothing;
      case '임부 스킨케어':
        return ESubCategory.maternitySkincare;
      case '기타 임부 의류/용품':
        return ESubCategory.otherMaternityItems;

      case '식품':
        return ESubCategory.food;
      case '분유':
        return ESubCategory.formula;
      case '젖병':
        return ESubCategory.bottle;
      case '수유 용품':
        return ESubCategory.feedingSupplies;
      case '수저/식판/이유식 용품':
        return ESubCategory.plates;
      case '기타 식품/수유/이유 용품':
        return ESubCategory.otherFeedingSupplies;
      default:
        throw Exception(
            '[SSubCategoryExtension.enumVal] Unknown string value: $this');
    }
  }
}

extension ESubCategoryExtension on ESubCategory {
  String get key {
    switch (this) {
      case ESubCategory.manTop:
        return 'MAN_TOP';
      case ESubCategory.womanTop:
        return 'WOMAN_TOP';
      case ESubCategory.manBottom:
        return 'MAN_BOTTOM';
      case ESubCategory.womanBottom:
        return 'WOMAN_BOTTOM';
      case ESubCategory.socks:
        return 'SOCKS';
      case ESubCategory.otherClothing:
        return 'OTHER_CLOTHING';

      case ESubCategory.manShoes:
        return 'MAN_SHOES';
      case ESubCategory.womanShoes:
        return 'WOMAN_SHOES';
      case ESubCategory.bag:
        return 'BAG';
      case ESubCategory.hat:
        return 'HAT';
      case ESubCategory.accessory:
        return 'ACCESSORY';
      case ESubCategory.otherAccessories:
        return 'OTHER_ACCESSORIES';

      case ESubCategory.diaper:
        return 'DIAPER';
      case ESubCategory.stroller:
        return 'STROLLER';
      case ESubCategory.babyCarrier:
        return 'BABY_CARRIER';
      case ESubCategory.carSeat:
        return 'CAR_SEAT';
      case ESubCategory.rider:
        return 'RIDER';
      case ESubCategory.furniture:
        return 'FURNITURE';
      case ESubCategory.bedding:
        return 'BEDDING';
      case ESubCategory.babySkincare:
        return 'BABY_SKINCARE';
      case ESubCategory.otherBabyKidsItems:
        return 'OTHER_BABY_KIDS_ITEMS';

      case ESubCategory.wipes:
        return 'WIPES';
      case ESubCategory.bath:
        return 'BATH';
      case ESubCategory.cleaningItems:
        return 'CLEANING_ITEMS';
      case ESubCategory.disinfectant:
        return 'DISINFECTANT';
      case ESubCategory.otherHygieneCleaning:
        return 'OTHER_HYGIENE_CLEANING';

      case ESubCategory.doll:
        return 'DOLL';
      case ESubCategory.robot:
        return 'ROBOT';
      case ESubCategory.sports:
        return 'SPORTS';
      case ESubCategory.waterPlay:
        return 'WATER_PLAY';
      case ESubCategory.educationalToy:
        return 'EDUCATIONAL_TOY';
      case ESubCategory.playhouseTent:
        return 'PLAYHOUSE_TENT';
      case ESubCategory.otherToys:
        return 'OTHER_TOYS';

      case ESubCategory.maternityClothing:
        return 'MATERNITY_CLOTHING';
      case ESubCategory.maternitySkincare:
        return 'MATERNITY_SKINCARE';
      case ESubCategory.otherMaternityItems:
        return 'OTHER_MATERNITY_ITEMS';

      case ESubCategory.food:
        return 'FOOD';
      case ESubCategory.formula:
        return 'FORMULA';
      case ESubCategory.bottle:
        return 'BOTTLE';
      case ESubCategory.feedingSupplies:
        return 'FEEDING_SUPPLIES';
      case ESubCategory.plates:
        return 'PLATES';
      case ESubCategory.otherFeedingSupplies:
        return 'OTHER_FEEDING_SUPPLIES';
    }
  }
}
