//
//  MemoModel.swift
//  SkillupPractice6
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

class MemoModel: Object {
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var text = ""
    dynamic var createDate = Date()
    dynamic var updateDate = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
