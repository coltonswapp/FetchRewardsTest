//
//  HorizLine.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/20/21.
//

import UIKit

class HorizLine: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        layer.masksToBounds = true
        layer.cornerRadius = 4
    }

}
