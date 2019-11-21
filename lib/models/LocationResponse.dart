/*
{
  "location_suggestions": [
    {
      "entity_type": "city",
      "entity_id": 89,
      "title": "Toronto, Ontario",
      "latitude": 43.627499,
      "longitude": -79.396167,
      "city_id": 89,
      "city_name": "Toronto",
      "country_id": 37,
      "country_name": "Canada"
    }
  ],
  "status": "success",
  "has_more": 0,
  "has_total": 0
}
 */
import 'package:flutter_coding_challenge/models/LocationModel.dart';

class LocationResponse {
	List<LocationModel> locations = [];
	String status;
	int hasMore = 0;
	int total = 0;

	Map<String, dynamic> toMap() =>
		{
			"location_suggestions": locations,
			"status": status,
			"has_more": hasMore,
			"has_total": total

		};

	static LocationResponse fromMap(Map<String, dynamic> map) {
		var loc = new LocationResponse();
		map.forEach((k, v) {
			switch (k) {
				case "location_suggestions": loc.locations = (v as List<dynamic>)
					.map((item) => LocationModel.fromMap(new Map<String, dynamic>.from(item)))
					.toList();
					break;
				case "status": loc.status = v as String; break;
				case "has_more": loc.hasMore = v as int; break;
				case "has_total": loc.total = v as int; break;
			}
		});
		return loc;
	}
}