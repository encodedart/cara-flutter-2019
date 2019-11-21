/*
{
  "entity_type": "group",
  "entity_id": "36932",
  "title": "Chelsea Market, Chelsea, New York City",
  "latitude": "40.742051",
  "longitude": "-74.004821",
  "city_id": "280",
  "city_name": "New York City",
  "country_id": "216",
  "country_name": "United States"
}
 */

class LocationModel {
	String type = "";
	int id = 0;
	String title = "";
	double latitude = 0.0;
	double longitude = 0.0;
	int cityId = 0;
	String cityName= "";
	int countryId = 0;
	String countryName = "";

	Map<String, dynamic> toMap() =>
		{
			"entity_type": type,
			"entity_id": id,
			"title": title,
			"latitude": latitude,
			"longitude": longitude,
			"city_id": cityId,
			"city_name": cityName,
			"country_id": countryId,
			"country_name": countryName
		};

	static LocationModel fromMap(Map<String, dynamic> map) {
		var loc = new LocationModel();
		map.forEach((k,v) {
			switch (k) {
				case "entity_type": loc.type = v as String; break;
				case "entity_id": loc.id = v as int; break;
				case "title": loc.title = v as String; break;
				case "latitude": loc.latitude = v as double; break;
				case "longitude": loc.longitude = v as double; break;
				case "city_id": loc.cityId = v as int; break;
				case "city_name": loc.cityName = v as String; break;
				case "country_id": loc.countryId = v as int; break;
				case "country_name": loc.countryName = v as String; break;
			}
		});
		return loc;
	}
}
