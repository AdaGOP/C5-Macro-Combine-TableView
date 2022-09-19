//
//  WeatherViewModel.swift
//  ExerciseCombineTests
//
//  Created by Athoya on 19/09/22.
//

import Foundation
import Combine

struct GeoCoordinate {
    var lat: Double = 0
    var lon: Double = 0
}

class WeatherViewModel {
    // Publishers
    // 1. CurrentValueSubject bakal nyimpen nilainya, dan ketika di subscribe bakal di eksekusi data terakhir
    var coordinate: CurrentValueSubject<GeoCoordinate, Never> = CurrentValueSubject(GeoCoordinate())
    // 2. PassthroughSubject bakal notify subscriber kalo ada data baru, tp data ga di simpen, jadi ga bisa ambil data terakhir
    var weatherData: PassthroughSubject<WeatherModel, Never> = PassthroughSubject()
    
    // 3. cancellables bakal nyimpen subscription, jadi kalo misal ada perubahanb life cycle bisa dilepas atau dicancel
    var cancellables: Set<AnyCancellable> = Set()
    
    var networkService = NetworkService()
    
    init() {
        // 5. buat subcription ke coordinate kalo ada perubahan
        coordinate.flatMap { coordinate in
            self.getWeatherDataToFuture()
        }.sink { model in
            self.weatherData.send(model)
        }.store(in: &cancellables)
    }
    
    // 4. Ubah async type function ke bentuk yang bisa di cerna combine, yaitu future
    func getWeatherDataToFuture() -> Future<WeatherModel, Never> {
        Future { promise in
            Task {
                let (data, response) = try await self.networkService.getWeatherData(geoCoordinate: self.coordinate.value)
                promise(.success(data))
            }
        }
    }
}
