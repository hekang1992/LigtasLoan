//
//  LLBaseNavViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit

class LLBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
