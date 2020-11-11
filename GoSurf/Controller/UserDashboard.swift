
//  DashboardListViewController.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 10/28/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit
import SwiftUI
@available(iOS 13.4, *)
class UserDashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationController?.navigationBar.isHidden = true
        
        let controller =  UIHostingController(rootView: payNplay())
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate(
            [
                controller.view.widthAnchor.constraint(equalToConstant: 450),
            controller.view.heightAnchor.constraint(equalToConstant: 800),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        ])
        
        // Do any additional setup after loading the view.
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

@available(iOS 13.0, *)
struct DashboardListViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
