import 'package:flutter_coding_challenge/models/CuisinesModel.dart';
import 'package:flutter_coding_challenge/models/LocationResponse.dart';
import 'package:flutter_coding_challenge/models/RestaurantResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class Zomato  {
	final String baseUrl = 'https://developers.zomato.com/api/v2.1/';
	final String apiKey = '462230264536ab2b52c75c40eea19f17';

	Future<LocationResponse> getLocationsByText(String search) async {
		String url = baseUrl + 'locations?query=$search';
		final response = await http.get(url, headers: {'user-key': apiKey});
		final j = json.decode(response.body);
		return LocationResponse.fromMap(j);
	}

	Future<LocationResponse> getLocations(double lat, double lon) async {
		String url = baseUrl + 'locations?query=&lat=$lat&lon=$lon';
		final response = await http.get(url, headers: {'user-key': apiKey});
		final j = json.decode(response.body);
		return LocationResponse.fromMap(j);
	}

	Future<List<CuisineModel>> getCuisines(int cityCode) async {
		String url = baseUrl + 'cuisines?city_id=$cityCode';
		print(url);
		final response = await http.get(url, headers: {'user-key': apiKey});
		final j = json.decode(response.body);

		return (j['cuisines'] as List<dynamic>)
			.map((item) => CuisineModel.fromMap(new Map<String, dynamic>.from(item['cuisine'])))
			.toList();
	}

	Future<RestaurantResponse> getRestaurants(int start, int cityCode, int cuisineCode) async {
		String url = baseUrl + 'search?entity_id=$cityCode&entity_type=city&cuisines=$cuisineCode&start=$start';
		final response = await http.get(url, headers: {'user-key': apiKey});
		return RestaurantResponse.fromMap(json.decode(response.body));
	}
}