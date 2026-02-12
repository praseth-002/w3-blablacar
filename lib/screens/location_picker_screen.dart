import 'package:flutter/material.dart';

import '../../model/ride/locations.dart';
import '../../dummy_data/dummy_data.dart';
import '../../theme/theme.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Location> _results = [];

  @override
  void initState() {
    super.initState();
    _results = fakeLocations;
  }

  void _onSearch(String query) {
    final q = query.toLowerCase().trim();

    setState(() {
      if (q.isEmpty) {
        _results = fakeLocations;
      } else {
        _results = fakeLocations.where((loc) {
          // 🔑 CITY NAME ONLY SEARCH
          return loc.name.toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  void _select(Location location) {
    Navigator.of(context).pop(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        elevation: 0,
        leading: BackButton(color: BlaColors.iconNormal),
        title: _searchBar(),
      ),
      body: ListView.separated(
        itemCount: _results.length,
        separatorBuilder: (_, __) =>
            Divider(color: BlaColors.greyLight, height: 1),
        itemBuilder: (context, index) {
          final location = _results[index];
          return _locationTile(location);
        },
      ),
    );
  }

  // ---------------------------
  // Widgets
  // ---------------------------
  Widget _searchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        autofocus: true,
        onChanged: _onSearch,
        decoration: InputDecoration(
          hintText: 'Search a city',
          border: InputBorder.none,
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear();
                    _onSearch('');
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _locationTile(Location location) {
    return ListTile(
      onTap: () => _select(location),
      title: Text(
        location.name,
        style: BlaTextStyles.body,
      ),
      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label.copyWith(
          color: BlaColors.textLight,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: BlaColors.iconLight,
      ),
    );
  }
}
