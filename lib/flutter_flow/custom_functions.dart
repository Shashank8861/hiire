import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

double ratingSummary(
  double totalRatings,
  double rating,
) {
  // get average rating to one decimal point from list of reviews
  if (totalRatings > 0) {
    return (rating +
            (totalRatings - rating) ~/ math.max((totalRatings ~/ 5), 1)) /
        2;
  } else {
    return rating;
  }
}

String ratingSummaryList(List<ReviewsRecord> rating) {
  if (rating.isEmpty) {
    return '-';
  }
  var ratingsSum = 0.0;
  for (final comment in rating) {
    ratingsSum += comment.rating!;
  }
  return (ratingsSum / rating.length).toStringAsFixed(1);
}

String? newCustomFunction(String price) {
  return "If you confirm, the job will be asigned and Rs." +
      price +
      " will be deducted from your wallet";
}

bool? newCustomFunction2(
  String mybalance,
  String jobPrice,
) {
  if (int.parse(mybalance) >= int.parse(jobPrice)) {
    return true;
  } else {
    return false;
  }
}

int? newCustomFunction3(String priceString) {
  return int.parse(priceString);
}
