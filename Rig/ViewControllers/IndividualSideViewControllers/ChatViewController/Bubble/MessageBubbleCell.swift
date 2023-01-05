//
//  MessageBubbleCell.swift
//  ECDashboard
//
//  Created by Ale on 12/4/20.
//

import UIKit

class MessageBubbleCell: UITableViewCell {
    let bubbleView: ChatBubbleView = {
        let v = ChatBubbleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var leadingOrTrailingConstraint = NSLayoutConstraint()
    var leadingOrTrailingConstraintForTime = NSLayoutConstraint()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        // add the bubble view
        contentView.addSubview(bubbleView)

        // constrain top / bottom with 12-pts padding
        // constrain width to lessThanOrEqualTo 2/3rds (66%) of the width of the cell
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22.0),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.66),
        ])
        
//        NSLayoutConstraint.activate([
//            bubbleView.selectedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3.0),
//            bubbleView.selectedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
//            bubbleView.selectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
//            bubbleView.selectedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
//        ])
    }
    
    func setData(_ message: String) {
//        guard let user = Singleton.shared.currentUser?.data?.user else { return }
        // set the label text
//        bubbleView.chatLabel.text = message.message
//        bubbleView.timeLabel.text = message.updatedAt.toDate(withFormat: DateFormats.serviceDate)?.timeAgoDisplay()
        // tell the bubble view whether it's an incoming or outgoing message
//        bubbleView.incoming = !(user.id == message.fromID)//!(user.id == message.fromID)

        // left- or right-align the bubble view, based on incoming or outgoing
        leadingOrTrailingConstraint.isActive = false
        leadingOrTrailingConstraintForTime.isActive = false;
        
        if bubbleView.incoming {
            leadingOrTrailingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0)
            
//            leadingOrTrailingConstraintForTime = bubbleView.timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0)
        
            
        } else {
            leadingOrTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
           
//            leadingOrTrailingConstraintForTime = bubbleView.timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0)
            
        }
        leadingOrTrailingConstraint.isActive = true
        leadingOrTrailingConstraintForTime.isActive = true
        
//        bubbleView.selectedView.backgroundColor = message.isSelected ? ColorConstants.rowHighlightColor : .clear
//        bubbleView.selectedView.isHidden = !message.isSelected
    }
}
