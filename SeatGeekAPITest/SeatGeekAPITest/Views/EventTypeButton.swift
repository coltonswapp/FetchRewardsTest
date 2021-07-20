//
//  EventTypeButton.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/19/21.
//

import UIKit

class EventTypeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    init(titleText: String) {
        super.init(frame: .zero)
        setTitle(titleText, for: .normal)
        configure()
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 10 + 10, height: 45)
    }
    
    func configure() {
        layer.cornerRadius = 6
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
