import 'package:blabla/dummy_data/dummy_data.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:blabla/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_time_util.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final void Function(RidePref)? onSubmit;

  const RidePrefForm({super.key, this.initRidePref, this.onSubmit});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  bool get _isFormValid =>
      departure != null &&
      arrival != null &&
      departure != arrival &&
      requestedSeats > 0;

  void _swapLocations() {
    setState(() {
      final tmp = departure;
      departure = arrival;
      arrival = tmp;
    });
  }

  void _submit() {
    if (!_isFormValid) return;

    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    widget.onSubmit?.call(ridePref);
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BlaSpacings.m),
      decoration: BoxDecoration(
        color: BlaColors.white,
        borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _locationRow(
            icon: Icons.radio_button_unchecked,
            text: departure != null
                ? '${departure!.name}, ${departure!.country.name}'
                : 'Arrival',
            trailing: IconButton(
              icon: Icon(Icons.swap_vert, color: BlaColors.primary),
              onPressed: _swapLocations,
            ),
            onTap: () {
              setState(() => departure = fakeLocations.first);
            },
          ),
          BlaDivider(),
          _locationRow(
            icon: Icons.radio_button_unchecked,
            text: arrival != null
                ? '${arrival!.name}, ${arrival!.country.name}'
                : 'Arrival',
            onTap: () {
              setState(() => arrival = fakeLocations.last);
            },
          ),
          BlaDivider(),
          _simpleRow(
            icon: Icons.calendar_today,
            text: DateTimeUtils.formatDateTime(departureDate),
            onTap: _pickDate,
          ),
          BlaDivider(),
          _simpleRow(
            icon: Icons.person,
            text: '$requestedSeats passenger${requestedSeats > 1 ? "s" : ""}',
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          BlaButton(
            icon: Icons.search,
            text: 'Search',
            onPressed: _isFormValid ? _submit : null,
          ),
        ],
      ),
    );
  }

  Widget _locationRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: BlaSpacings.m),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.iconLight),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: BlaTextStyles.body.copyWith(
                  color: text == 'Departure' || text == 'Arrival'
                      ? BlaColors.textLight
                      : BlaColors.textNormal,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _simpleRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: BlaSpacings.m),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.iconLight),
            const SizedBox(width: 12),
            Text(text, style: BlaTextStyles.body),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => departureDate = picked);
    }
  }
}
