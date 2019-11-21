
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_challenge/api/Zomato.dart';
import 'package:flutter_coding_challenge/models/RestaurantModel.dart';

class RestaurantListView extends StatefulWidget {
	final int cityCode;
	final int cuisineCode;
	final int price;

	RestaurantListView({Key key, @required this.cityCode, @required this.cuisineCode, @required this.price}): super(key: key);

  	@override State<StatefulWidget> createState() => _RestaurantList(cityCode: cityCode, cuisineCode: cuisineCode, price: price);

}

class _RestaurantList extends State<RestaurantListView> {
	final int cityCode;
	final int cuisineCode;
	final int price;

	List<RestaurantModel> _all = [];
	bool _showIndicator = true;
	bool _emptyList = false;

	_RestaurantList({@required this.cityCode, @required this.cuisineCode, @required this.price}): super() {
		_loadData();
	}

	_loadData() async {
		final _api = new Zomato();
		List<RestaurantModel> all = [];
		bool hasNext = true;
		int start = 0;
		while (hasNext) {
			final result = await _api.getRestaurants(start, cityCode, cuisineCode);
			if (result.show == 0) {
				hasNext = false;
				break;
			}
			result.restaurants.removeWhere((item) => item.priceRange != price);
			all.addAll(result.restaurants);
			start += result.show;
			if (start >= result.found) {
				hasNext = false;
				break;
			}
		}
		setState(() {
			_showIndicator = false;
			if (all.isEmpty) {
				_emptyList = true;
			} else {
				_all = all;
			}
		});

	}

	@override Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				appBar: AppBar(
					title: Text('Random List'),
					leading: IconButton(icon:Icon(Icons.arrow_back),
						onPressed:() => Navigator.pop(context, false),
					)
				),
				body: SafeArea(
					child: Stack(children: <Widget>[
						ListView.separated(
							separatorBuilder: (context, index) => Divider(color: Colors.grey),
							itemCount: _all.length,
							itemBuilder: (context, index) {
								return RestaurantListItem(model: _all[index]);
							}
						),
						Visibility(
							visible: _showIndicator,
							child: Center(
								child: CircularProgressIndicator()
							)
						),
						Visibility(
							visible: _emptyList,
							child: Center(
								child: Text(
									'No restaurants found. Please try again.',
									style: TextStyle(
										fontSize: 18,
										color: Colors.black45
									),
								),
							),
						)
					],)
				)
			),
		);
  	}

}



class RestaurantListItem extends StatelessWidget {
	final RestaurantModel model;

	RestaurantListItem({Key key, @required this.model}): super(key: key);

	@override Widget build(BuildContext context) {
    	return Padding(
			padding: EdgeInsets.all(16),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Padding(
						padding: EdgeInsets.only(bottom: 4),
						child: Text(
							model.name,
							style: TextStyle(
								fontSize: 18,
								color: Colors.black
							),
						),
					),
					Text(
						model.location.address,
						style: TextStyle(
							fontSize: 14,
							color: Colors.black38
						),

					),
					Text(
						model.phone,
						style: TextStyle(
							fontSize: 14,
							color: Colors.black38
						),
					)
			],),
		);
  	}
}