import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure) {
    final List<Ride> filterByDepartureRides = [];
    // for(int i = 0; i < remainingSeats.length; i++){
    for (int i = 0; i < availableRides.length; i++) {
      if (availableRides[i].departureLocation == departure) {
        filterByDepartureRides.add(availableRides[i]);
      }
    }
    return filterByDepartureRides;
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(int requestedSeat) {
    List<Ride> filterBySeatRequestedRides = [];
    for (int i = 0; i < availableRides.length; i++) {
      // if(availableRides[i].remainingSeats == requestedSeat) {
      if (availableRides[i].availableSeats >= requestedSeat) {
        filterBySeatRequestedRides.add(availableRides[i]);
      }
    }
    return filterBySeatRequestedRides;
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    final List<Ride> filterByBoth = [];

    for (final ride in availableRides) {
      if (departure != null && ride.departureLocation != departure) {
        continue;
      }
      if (seatRequested != null && ride.availableSeats < seatRequested) {
        continue;
      }
      filterByBoth.add(ride);
    }

    return filterByBoth;
  }
}
