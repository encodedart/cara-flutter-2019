
/*
[
  {
    "cuisine_id": "25",
    "cuisine_name": "Chinese"
  }
]
 */

class CuisineModel {
	int id = 0;
	String name = "";

	Map<String, dynamic> toMap() =>
		{
			"cuisine_id": id,
			"cuisine_name": name

		};

	static CuisineModel fromMap(Map<String, dynamic> map) {
		var loc = new CuisineModel();
		map.forEach((k,v) {
			switch (k) {
				case "cuisine_id": loc.id = v as int; break;
				case "cuisine_name": loc.name = v as String; break;
			}
		});
		return loc;
	}
}