//
//  FileCacherTest.swift
//  DICacheMasterFrameworkTests
//
//  Created by MACBOOK PRO on 28/04/2019.
//  Copyright © 2019 DAO Ibrahim. All rights reserved.
//

import XCTest

class FileCacherTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    struct data : Codable{
        let id:String?
        let created_at: String?
        let width: Int?
        let height: Int?
        let color: String?
        let likes: Int?
        let liked_by_user: Bool?
        let links:image?
        //let user:Dictionary<String, Dictionary<String,String>>?
        let urls:Dictionary<String, String>?
        //let categories:Dictionary<String, String>?
        //let bio: String?
    }
    
    struct image : Codable{
        //let self:String?
        let html: String?
        let download: String?
    }
}
