class Weather{
 late String cityname;
 late String description;
 late int temperature;
 late int humidity;
 late int windspeed;
 late int sunrise;
 late int sunset;

Weather({required this.cityname,
required this.description,
required this.temperature,
required this.humidity,
required this.windspeed,
required this.sunrise,
required this.sunset});

Weather.fromjson(Map<String,dynamic> parsedjson){
    cityname = parsedjson["name"];
   description= parsedjson["weather"]["main"];
    temperature = parsedjson["main"]["temp"] - 273.15;
    humidity = parsedjson["main"]["humidity"];
    windspeed = parsedjson["wind"]["speed"];
    sunrise = parsedjson["sys"]["sunrise"];
    sunset = parsedjson["sys"]["sunset"];
}
}

