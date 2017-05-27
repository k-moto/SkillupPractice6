//
//  MemoList.swift
//  SkillupPractice6
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

class MemoList: NSObject, UITableViewDataSource {
    
    var dataList: [MemoModel] = []
    var memoCountLabel: UIBarButtonItem!
    
    func add(dataList: [MemoModel]){
        self.dataList = dataList
    }
    
    func addMemoCountLabel(memoCountLabel: UIBarButtonItem){
        self.memoCountLabel = memoCountLabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoListCell.identifier,for: indexPath) as! MemoListCell
        
        let currentData = dataList[indexPath.row]
        
        cell.memoTitle.text = currentData.title
        cell.memoText.text = currentData.text
        
        cell.memoUpdateDate.text = currentData.updateDate.dateStyle()

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        MemoDao.delete(id: dataList[indexPath.row].id)
        dataList.remove(at: indexPath.row)
        setMemoCountLabel(dataCount: dataList.count)
        tableView.deleteRows(at: [indexPath], with: .fade)

    }
    
    func setMemoCountLabel(dataCount: Int){
        
        if dataCount > 0 {
            memoCountLabel.title = String(dataCount) + "件のメモ"
        } else {
            memoCountLabel.title = "メモなし"
            
        }
        
    }
    
}
