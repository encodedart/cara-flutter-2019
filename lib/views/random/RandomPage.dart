
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coding_challenge/api/Zomato.dart';
import 'package:flutter_coding_challenge/models/CuisinesModel.dart';
import 'package:flutter_coding_challenge/models/LocationResponse.dart';
import 'package:flutter_coding_challenge/models/RestaurantModel.dart';
import 'package:flutter_coding_challenge/views/list/RestaurantListView.dart';
import 'package:location/location.dart';

class RandomPage extends StatefulWidget {
	@override _RandomPageState createState() => new _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {

	String _searchText = '';
	String _locationText = '';
	final _api = new Zomato();
	int _selectedCuisine = -1;
	int _cityCode = 0;
	String _selectedPrice = 'Pick for me';
	List<DropdownMenuItem<int>> _cuisines = [];
	bool _show = false;

	_updateList(LocationResponse result) async {
		if (result.locations != null && result.locations.isNotEmpty) {
			final loc = result.locations.first;
			_cityCode = loc.cityId;
			setState(() {
				_locationText = '${loc.cityName}, ${loc.countryName}';
			});
			final c = await _api.getCuisines(loc.cityId);
			if (c.isNotEmpty) {
				List<DropdownMenuItem<int>> list = [];
				list.add(new DropdownMenuItem<int>(value: -1, child: Text('Pick for me')));
				list.addAll(
					c.map((item) => new DropdownMenuItem(child: Text(item.name), value: item.id,)).toList()
				);
				setState(() {
					_cuisines = list;
					_selectedCuisine = -1;
					_show = true;
				});
			}
		}
	}

	_searchCity() async {
		FocusScope.of(context).unfocus();
		final result = await _api.getLocationsByText(_searchText);
		_updateList(result);
	}

	_searchByDeviceLocation() async {
		final location = new Location();
		try {
			var curLocation = await location.getLocation();
			final result = await _api.getLocations(curLocation.latitude, curLocation.longitude);
			_updateList(result);
		} on PlatformException catch (e) {
			//TODO: Show alert fail to get device current location
		}
	}

	_search() async {
		int cuisine;
		final random = new Random();
		if (_selectedCuisine == -1) {
			int i = random.nextInt(_cuisines.length);
			cuisine = _cuisines[i].value;
		} else {
			cuisine = _selectedCuisine;
		}
		int price = 1;
		if (_selectedPrice.length > 3) {
			price = random.nextInt(3) + 1;
		} else {
			price = _selectedPrice.length;
		}
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => RestaurantListView(cityCode: _cityCode, cuisineCode: cuisine,price: price)
			),
		);
	}

	@override Widget build(BuildContext context) {
    	return Column(
			children: <Widget>[
				Padding(
					padding: EdgeInsets.only(left: 16,right: 16, bottom: 8, top: 16),
					child: TextField(
						decoration: InputDecoration(
							hintText: "Search for city"
						),
						onChanged: (text) {
							_searchText = text;
						},
					),
				),
				SizedBox(
					height: 60,
					width: double.infinity,
					child: Padding(
						padding: EdgeInsets.only(left: 16,right: 16, bottom: 8, top: 16),
						child: RaisedButton(
							onPressed: _searchCity,
							child: Text('Search for City'),
						)
					)
				),
				SizedBox(
					height: 60,
					width: double.infinity,
					child: Padding(
						padding: EdgeInsets.only(left: 16,right: 16, bottom: 8, top: 16),
						child: RaisedButton(
							onPressed: _searchByDeviceLocation,
							child: Text('Search by Device Location'),
						)
					)
				),
				SizedBox(
					height: 20,
				),
				Visibility(
					visible: _show,
					child: Text(
						'Found city: $_locationText',
						style: new TextStyle(
							fontSize: 18.0,
							color: new Color(0xFF8B1122),
							fontWeight: FontWeight.w600,
						),
					),
				),
				SizedBox(
					height: 20,
				),
				Visibility(
					visible: _show,
					child: DropdownButton(
						value: _selectedCuisine,
						icon: Icon(Icons.arrow_downward),
						items: _cuisines,
						onChanged: (int newValue) {
							setState(() {
								_selectedCuisine = newValue;
							});
						},
					),
				),
				SizedBox(
					height: 20,
				),
				Visibility(
					visible: _show,
					child: DropdownButton<String>(
						value: _selectedPrice,
						icon: Icon(Icons.arrow_downward),
						onChanged: (String newValue) {
							setState(() {
								_selectedPrice = newValue;
							});
						},
						items: <String>['Pick for me', r"$", r'$$', r'$$$']
						.map<DropdownMenuItem<String>>((String value) {
							return DropdownMenuItem<String>(
								value: value,
								child: Text(value)
							);
						}).toList(),
					),
				),
				SizedBox(
					height: 20,
				),
				Visibility(
					visible: _show,
					child: SizedBox(
						height: 60,
						width: double.infinity,
						child: Padding(
							padding: EdgeInsets.only(left: 16,right: 16, bottom: 8, top: 16),
							child: RaisedButton(
								onPressed: _search,
								child: Text('Search Restaurant'),
							)
						)
					),
				),
		],);
  	}

}