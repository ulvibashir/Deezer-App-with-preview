//
//  MusicaTests.swift
//  MusicaTests
//
//  Created by Ulvi Bashirov on 10/30/20.
//

@testable import Musica
import XCTest

class MusicaTests: XCTestCase {

    var sut: MusicViewModel!
    
    override class func setUp() {
        super.setUp()
        sut = MusicViewModel()
        
    }
    
    override class func tearDown() {
        sut = nil
        super.tearDown()
    }
}
