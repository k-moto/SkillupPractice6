//
//  MemoDaoTest.swift
//  SkillupPractice6
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import STV_Extensions
import XCTest
@testable import SkillupPractice6

class MemoDaoTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        MemoDao.deleteAll()
    }
    
    func testAdd(){
        let object = MemoModel()
        
        let createDate = "2016/01/01 10:00"
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.title = "テストタイトル1"
        object.text = "東京\n埼玉\n千葉"
        object.createDate = createDate.toDate(dateFormat: format)
        object.updateDate = updateDate.toDate(dateFormat: format)
        
        MemoDao.add(model:object)
        
        verifyItem(id: 1, title: "テストタイトル1", text: "東京\n埼玉\n千葉", createDateStr: createDate, updateDateStr: updateDate)
    }
    
    func testUpdate(){
        
        let object = MemoModel()
        
        let createDate = "2016/01/01 10:00"
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.title = "テストタイトル1"
        object.text = "メモ1"
        object.createDate = createDate.toDate(dateFormat: format)
        object.updateDate = updateDate.toDate(dateFormat: format)
        
        MemoDao.add(model:object)
        
        object.id = 1
        object.title = "テストタイトル2"
        object.text = "メモ更新"
        object.updateDate = "2016/01/01 20:30".toDate(dateFormat: format)
        
        MemoDao.update(model:object)
        
        verifyItem(id: 1, title: "テストタイトル2", text: "メモ更新", createDateStr: createDate, updateDateStr: "2016/01/01 20:30")
    }
    
    func testDelete(){
        
        let object = MemoModel()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.title = "テストタイトル1"
        object.text = "メモ"
        object.createDate = startTime.toDate(dateFormat: format)
        object.updateDate = endTime.toDate(dateFormat: format)
        
        MemoDao.add(model:object)
        
        MemoDao.delete(id: 1)
        
        verifyCount(count:0)
    }
    
    func testFindByID(){
        
        let object = MemoModel()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.title = "テストタイトル1"
        object.text = "メモ"
        object.createDate = startTime.toDate(dateFormat: format)
        object.updateDate = endTime.toDate(dateFormat: format)
        
        MemoDao.add(model:object)
        
        let result = MemoDao.findByID(id: 1)
        
        XCTAssertEqual(result?.id, 1)
    }
    
    func testFindAll(){
        
        let tasks = [MemoModel(),MemoModel(),MemoModel()]
        
        _ = tasks.map {
            MemoDao.add(model:$0)
        }
        
        verifyCount(count:3)
    }
    
    //MARK:-private method
    private func verifyItem(id: Int, title: String, text: String, createDateStr: String, updateDateStr: String) {
        
        let format = "yyyy/MM/dd HH:mm"
        
        let result = MemoDao.findAll()
        
        XCTAssertEqual(result.first?.id, id)
        
        XCTAssertEqual(result.first?.title, title)
        
        if let text = result.first?.text {
            XCTAssertEqual(text, text)
        }
        
        XCTAssertEqual(result.first?.createDate.toStr(dateFormat: format), createDateStr)
        
        XCTAssertEqual(result.first?.updateDate.toStr(dateFormat: format), updateDateStr)

    }
    
    private func verifyCount(count: Int) {
        
        let result = MemoDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
