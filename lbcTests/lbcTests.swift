//
//  lbcTests.swift
//  lbcTests
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import XCTest
@testable import lbc

final class lbcTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitAdvertisement() {
        let advertisement = Advertisement(id: 1701863796,
                                          category: Category(id: 1.0,
                                                             name: "Véhicule"),
                                          title: "Suzuki gn 125 - Parfait état",
                                          description: "Vends moto SUZUKI GN 125 Rouge Parfait état Véhicule soigné et faiblement kilométré Dort dans un parking fermé et chauffé Utilisée uniquement en ville Kilométrage : 33768 Régulièrement entretenue chez Actua Scoot (Bd Beaumarchais) depuis plus de 10 ans 1er contact par téléphone",
                                          price: 1550,
                                          smallImage: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/f8d72ff2d2dfc0b9488bc20dbb0669eced1099ef.jpg"),
                                          thumbImage: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/f8d72ff2d2dfc0b9488bc20dbb0669eced1099ef.jpg"),
                                          creationDate: Date(),
                                          isUrgent: true,
                                          siret: "476 324 343")

        XCTAssertEqual("Suzuki gn 125 - Parfait état", advertisement.title)
        XCTAssertEqual(true, advertisement.isUrgent)
        XCTAssertEqual(1550, advertisement.price)
        XCTAssertEqual("Véhicule", advertisement.category.name)
    }
    
    func testGetPriceString() {
         let price: Double = 4200.99
         let expectedString = "4 200,99 €"
         let resultString = price.getPriceString()
         XCTAssertEqual(resultString, expectedString)
     }
}
