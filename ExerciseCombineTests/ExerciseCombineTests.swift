//
//  ExerciseCombineTests.swift
//  ExerciseCombineTests
//
//  Created by Athoya on 16/09/22.
//

import XCTest

class ExerciseCombineTests: XCTestCase {
    
    let viewModel: WeatherViewModel = WeatherViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() async throws {
        let successExpecaation = expectation(description: "Success")
        
        let geoCoordinate = GeoCoordinate(lat: 15.12, lon: 52.12)
        
        // 6. buat subs ke weather data kalo ada perubahan
        viewModel.weatherData.sink { model in
            XCTAssertNotNil(model)
            XCTAssertNotNil(model.latitude)
            XCTAssertNotNil(model.hourly?.temperature_2m?.first)
            print(model)
            successExpecaation.fulfill()
        }.store(in: &viewModel.cancellables)
        
        // 7. Kita coba ubah data coordinate, dan berharap data weather juga bisa dapet
        viewModel.coordinate.send(geoCoordinate)
        
        wait(for: [successExpecaation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
