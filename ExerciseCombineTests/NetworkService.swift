//
//  NetworkingTest.swift
//  ExerciseCombine
//
//  Created by Athoya on 16/09/22.
//

import Foundation

class NetworkService {
    // Url for fetching api
    let baseUrl = "https://api.open-meteo.com/v1/forecast"
    let urlSession = URLSession(configuration: .default)

    // Get API call to get weather data from api
    func getWeatherData(geoCoordinate: GeoCoordinate) async throws -> (WeatherModel, URLResponse) {
        let url = "\(baseUrl)?latitude=\(geoCoordinate.lat)&longitude=\(geoCoordinate.lon)&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
        return (weatherData, response)
    }
}
