
//  JobFeedsSocializerCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 03/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
protocol CollectionTappedDelegate{
   func tabOnSocializer(profileid:Int?)
}
class JobFeedsSocializerCell: UITableViewCell {

    var delegate:CollectionTappedDelegate?
    var allUserData: AllUser?
    @IBOutlet weak var socializerCollectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!

    var JobFeedsSocializerCellViewModel : JobFeedsSocializerCellViewModel!
    {
        didSet
        {
            self.socializerCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerXib()

        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width:0.0, height:3.0);
        bgView.layer.shadowOpacity = 0.20;
        bgView.layer.masksToBounds = false;
      //  getAllUser()
        socializerCollectionView.delegate = self
        socializerCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerXib() {
        socializerCollectionView.register(UINib(nibName: "SwipeSocializerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SwipeSocializerCollectionViewCell")
    }
    
     
}

extension JobFeedsSocializerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return self.allUserData?.users?.count ?? 0
        return JobFeedsSocializerCellViewModel.socializers?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeSocializerCollectionViewCell", for: indexPath) as! SwipeSocializerCollectionViewCell
        let model = SwipeFriendCellViewModel(socialize: JobFeedsSocializerCellViewModel.socializers?[indexPath.row], viewController: JobFeedsSocializerCellViewModel.viewController)
        cell.SwipeFriendCellViewModel = model

        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let PID = JobFeedsSocializerCellViewModel.socializers?[indexPath.row].id
        delegate?.tabOnSocializer(profileid: PID)
    }
}
