//
//  Caption2.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class Caption2: UILabel {
    private func setup() {
        font = ScaledFont().font(forTextStyle: .caption2)
        adjustsFontForContentSizeCategory = true
    }
    
    /// Define custom initializers.
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setup()
    }
}

