//
//  PopUpProfile.swift
//  Rig
//
//  Created by Mac on 28/05/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
protocol ProfilePopUp: AnyObject  {
    func ButtonTapped(tag:Int)
}

class PopUpProfile: UIView {

    var delegate: ProfilePopUp?
    @IBOutlet weak var ViewProfile: UIButton!
    @IBOutlet weak var EditProfileImage: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet var gestureView: UIView!
    @IBOutlet var BgView: UIView!
    
    
    static let shared: PopUpProfile = PopUpProfile()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
        Initailize()
      }

      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          Initailize()

      }
    func Initailize(){
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
        BgView.cornerRadius = 10
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        gestureView.isUserInteractionEnabled = true
        gestureView.addGestureRecognizer(tapGestureRecognizer)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        let nibView = nib.instantiate(withOwner:self, options: nil).first as! UIView
        return nibView
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        removeFromSuperview()
    }

    @IBAction func ViewProfileimageTapped(_ sender: UIButton) {
        delegate?.ButtonTapped(tag: sender.tag)
    }
    @IBAction func EditProfileimageTapped(_ sender: UIButton) {
        delegate?.ButtonTapped(tag: sender.tag)
    }

}
