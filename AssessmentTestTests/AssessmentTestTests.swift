//
//  AssessmentTestTests.swift
//  AssessmentTestTests
//
//  Created by Михаил Юранов on 02.10.2020.
//  Copyright © 2020 Михаил Юранов. All rights reserved.
//

import XCTest
@testable import AssessmentTest

class AssessmentTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainViewBuilding() throws {
        let mainBuilder = MainViewBuilder.build() as? MainViewController
        XCTAssertNotNil(mainBuilder)
        
        let presenter = mainBuilder?.presenter
        XCTAssertNotNil(presenter)
        
        let interactor = presenter?.interactor
        let router = presenter?.router
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor)
        
        let interactorOutput = interactor?.intercatorOutput
        XCTAssertNotNil(interactorOutput as? MainViewPresenter)
        
        let mainViewController = router?.mainViewController
        XCTAssertNotNil(mainViewController)
    }
    
    func testEditViewBuilding() throws {
        let editBuilder = EditorViewBuilder.build(with: nil)
        XCTAssertNotNil(editBuilder)
        
        let presenter = editBuilder?.presenter
        XCTAssertNotNil(presenter)
        
        let interactor = presenter?.interactor
        let router = presenter?.router
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        
        let interactorOutput = interactor?.interactorOutput
        XCTAssertNotNil(interactorOutput as? EditorViewPresenter)
     
        let editorViewController = router?.editorViewController
        XCTAssertNotNil(editorViewController)
    }
}
