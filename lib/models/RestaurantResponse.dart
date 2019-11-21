/*
  "results_found": "53",
  "results_start": "11",
  "results_shown": "10",
  "restaurants": [
 */
import 'package:flutter_coding_challenge/models/RestaurantModel.dart';

class RestaurantResponse {
	int found = 0;
	int start = 0;
	int show = 0;
	List<RestaurantModel> restaurants = [];

	static RestaurantResponse fromMap(Map<String, dynamic> map) {
		var loc = new RestaurantResponse();
		map.forEach((k, v) {
			switch (k) {
				case "results_found": loc.found = v as int; break;
				case "results_start": loc.start = v as int; break;
				case "results_shown": loc.show = v as int; break;
				case "restaurants": loc.restaurants = (v as List<dynamic>)
					.map((item) => RestaurantModel.fromMap(new Map<String, dynamic>.from(item)))
					.toList();
					break;
			}
		});
		return loc;
	}
}