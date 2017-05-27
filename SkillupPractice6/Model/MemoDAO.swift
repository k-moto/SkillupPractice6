//
//  MemoDAO.swift
//  SkillupPractice6
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

final class MemoDao {
    
    static let dao = RealmDaoHelper<MemoModel>()
    
    static func add(model: MemoModel) {
        
        let object = MemoModel()
        object.id = MemoDao.dao.newId()!
        object.title = model.title
        object.text = model.text
        object.createDate = model.createDate
        object.updateDate = model.updateDate

        MemoDao.dao.add(d: object)
    }
    
    static func update(model: MemoModel) {
        
        guard let object = dao.findFirst(key: model.id as AnyObject) else {
            return
        }

        
        _ = dao.update(d: object,block:{() -> Void in
            object.title = model.title
            object.text = model.text
            object.updateDate = model.updateDate
        })
        
        
    }
    
    static func delete(id: Int) {
        
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return
        }
        dao.delete(d: object)
    }
    
    static func deleteAll() {
        dao.deleteAll()
    }
    
    static func findByID(id: Int) -> MemoModel? {
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return nil
        }
        return object
    }
    
    static func findAll() -> [MemoModel] {
        let objects =  MemoDao.dao.findAll()
        return objects.map { MemoModel(value: $0) }
    }
}
