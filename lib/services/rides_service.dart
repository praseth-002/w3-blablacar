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
    for(int i = 0; i < availableRides.length; i++){
      if(availableRides[i].departureLocation == departure){
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
    for(int i = 0; i < availableRides.length; i++){
      if(availableRides[i].remainingSeats == requestedSeat) {
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
    for(int i = 0; i < availableRides.length; i++){
      if(availableRides[i].remainingSeats == seatRequested || availableRides[i].departureLocation == departure || availableRides[i].departureLocation == departure && availableRides[i].remainingSeats == seatRequested) {
        filterByBoth.add(availableRides[i]);
      }
    }
    return filterByBoth;
  }
}
