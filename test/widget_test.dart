// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:blabla/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'w3bla/main.dart';

import '../lib/model/ride/ride.dart';
import '../lib/services/rides_service.dart';
import '../lib/model/ride/locations.dart';

void main() {
  Location locationTest1 = Location(name: "Leeds", country: Country.uk);
  Location locationTest2 = Location(name: "Glasgow", country: Country.uk);
  User userTest = User(
    firstName: "Alice",
    lastName: "Dupont",
    email: "alice.dupont@example.com",
    phone: "+33 612345678",
    profilePicture: "https://randomuser.me/api/portraits/women/1.jpg",
    verifiedProfile: true,
  );
  RidesService ridesServiceTest = RidesService();
  Ride rideTest = Ride(departureLocation: locationTest1, departureDate: DateTime.now(), arrivalLocation: locationTest2, arrivalDateTime: DateTime.now(), driver: userTest, availableSeats: 2, pricePerSeat: 10);

  RidesService.filterBy(departure: locationTest1);
}
