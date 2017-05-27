//
//  MemoViewController.swift
//  SkillupPractice6
//
//  Created by k_motoyama on 2017/05/27.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {
    
    @IBOutlet weak var memoText: UITextView!
    
    var selectId = 0
    
    override func viewDidLoad() {
        
        if selectId != 0 {
            let memoData = MemoDao.findByID(id: selectId)
            let dispMemo = memoData!.title + "\n" + memoData!.text
            memoText.text = dispMemo
        }
        
        memoText.becomeFirstResponder()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClick))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func doneClick(){
        
        if memoText.text != "" {
            
            let separateWord = "\n"
            
            let separateText = memoText.text.components(separatedBy: separateWord)
            
            let memoObject = MemoModel()
            
            memoObject.title = separateText.first!
            
            if separateText.count > 1 {
                let titleRow = separateText.first! + separateWord
                memoObject.text = memoText.text!.replacingOccurrences(of: titleRow, with: "")
            }
            
            memoObject.updateDate = Date()

            
            if selectId == 0 {
                memoObject.createDate = Date()
                MemoDao.add(model: memoObject)

            } else {
                memoObject.id = selectId
                MemoDao.update(model: memoObject)

            }
            
        }
        
        navigationController!.popViewController(animated: true)
        
    }
    
    
}
