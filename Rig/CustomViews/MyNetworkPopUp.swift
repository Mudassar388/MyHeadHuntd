//
//  MyNetworkPopUp.swift
//  Rig
//
//  Created by Muhammad Mudassar Yasin on 06/07/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
protocol MYNetworkCellPopUp: AnyObject  {
    func ButtonTapped(tag:Int)

}

class MyNetworkPopUp: UIView {
    var delegate : MYNetworkCellPopUp?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
//    class func getView() -> MyNetworkPopUp {
//        let view = Bundle.main.loadNibNamed("MyNetworkPopUp", owner: nil)?.first as! MyNetworkPopUp
//        return view
//    }
    
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
        contentView.frame = CGRect(x: 0, y: 0, width: 100, height: 74)
        contentView.addshadowColor()
        addSubview(contentView)
        let tapView = UITapGestureRecognizer(target: self, action: #selector(self.popover(recognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapView)
    }

    @objc func popover(recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        print("Tap occurred at location \(tapLocation)")
  //  }
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer:)))
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(tapGestureRecognizer)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        let nibView = nib.instantiate(withOwner:self, options: nil).first as! UIView
        return nibView
    }

    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        removeFromSuperview()
    }

//    let nib = "MyNetworkPopUp"
//    override init(frame: CGRect) {
//          super.init(frame: frame)
//        Initailize()
//      }
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//       Initailize()
//
//      }
//   // func Initailize(){
//        private func Initailize(){
//        Bundle.main.loadNibNamed(nib, owner: self, options: nil)
//                      addSubview(contentView)
//                      contentView.frame = self.bounds
//                      contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//                 }

    
    @IBAction func btnMessageTapped(_ sender: UIButton) {
        delegate?.ButtonTapped(tag: sender.tag)
        print("pop up tapped")


    }
    
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        delegate?.ButtonTapped(tag: sender.tag)
        
    }
   
}


    

