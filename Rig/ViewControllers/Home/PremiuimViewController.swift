//
//  PremiuimViewController.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-09-04.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class PremiuimViewController: UIViewController {

    @IBOutlet weak var premiumView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var addNowButtonOutlet: UIButton!
    @IBOutlet weak var laterButtonOutlet: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.setTitle("", for: .normal)
    }
    
    @IBAction func laterButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func addNowButton(_ sender: Any) {
        let storyoardID = UIStoryboard.init(name: RIGStoryboards.CandidateStoryboard, bundle: nil)
        guard let memberVC = storyoardID.instantiateViewController(withIdentifier: RIGViewControllers.membershipReferenceVC) as? MembershipReferanceViewController else {
            return
        }
        dismiss(animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                UIApplication.topViewController()?.navigationController?.pushViewController(memberVC, animated: true)
            })
        })
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true)
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
