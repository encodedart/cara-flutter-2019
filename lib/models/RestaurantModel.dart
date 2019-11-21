
/*

"phone_numbers"
"price_range"
"currency": "$",
      "thumb":
*/

class RestaurantModel {
	String id = "";
	String name = "";
	String url = "";
	String phone = "";
	int priceRange = 0;
	String currency = "";
	String thumb = "";
	RestaurantLocation location;

	static RestaurantModel fromMap(Map<String, dynamic> map) {
		var loc = new RestaurantModel();
		map['restaurant'].forEach((k, v) {
			switch (k) {
				case "id": loc.id = v as String; break;
				case "name": loc.name = v as String; break;
				case "url": loc.url = v as String; break;
				case "phone_numbers": loc.phone = v as String; break;
				case "price_range": loc.priceRange = v as int; break;
				case "currency": loc.currency = v as String; break;
				case "thumb": loc.thumb = v as String; break;
				case "location": loc.location = RestaurantLocation.fromMap(v); break;
			}
		});

		return loc;
	}
}

class RestaurantLocation {
	String address = "";

	static RestaurantLocation fromMap(Map<String, dynamic> map) {
		var loc = new RestaurantLocation();
		map.forEach((k,v) {
			switch (k) {
				case "address": loc.address = v as String; break;
			}
		});
		return loc;
	}
}