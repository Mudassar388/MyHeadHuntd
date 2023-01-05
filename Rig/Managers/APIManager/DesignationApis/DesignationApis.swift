//
//  DesignationApis.swift
//  Rig
//
//  Created by Sufyan Qasim on 17/10/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class DesignationData {
    
    
    
    func editProfileDrop(completion: @escaping () -> Void) {
        let designation = "designation"
        
        HTTPManager.shared.get("skill/industry?type=\(designation)") { (response: GenericModel<userskills>?) in
            guard let respo = response else {return}
            if respo.status == 200 {
                Constants.skills = respo.data ?? []
                completion()
                print(Constants.skills, "this our skill")
            }
        }
    }

}















