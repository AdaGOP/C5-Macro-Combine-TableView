//
//  WeatherModel.swift
//  ExerciseCombineTests
//
//  Created by Athoya on 16/09/22.
//

import Foundation

struct WeatherModel: Decodable {
    let latitude: Double?
    let longitude: Double?
    let hourly: WeatherHourlyModel?
}

struct WeatherHourlyModel: Decodable {
  let time: [String]?
  let temperature_2m: [Double]?
  let relativehumidity_2m: [Double]?
  let windspeed_10m: [Double]?
}
