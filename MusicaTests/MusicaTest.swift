//
//  MusicaTest.swift
//  MusicaTests
//
//  Created by Ulvi Bashirov on 10/30/20.
//

@testable import Musica

import XCTest

class MusicaTest: XCTestCase {

    
    var sut: MusicViewModel!
    
    override func setUp() {
        super.setUp()
        sut = MusicViewModel()
        
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_get_music() throws {
        
        let expectedError: ValidationErrors = .outOfRange
        var error: ValidationErrors?
        
        XCTAssertThrowsError(try sut.getMusic(with: 0)) { errorThrown in
            error = errorThrown as? ValidationErrors
        }
        XCTAssertEqual(expectedError, error)
    }
    


}
