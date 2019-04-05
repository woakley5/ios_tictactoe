//
//  GameCell.swift
//  TicTacToe
//
//  Created by Will Oakley on 4/4/19.
//  Copyright © 2019 Will Oakley. All rights reserved.
//

import UIKit

class GameCell: UIView {
    
    var iconLabel: UILabel!
    var currentState: Player!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initInterface()
    }
    
    func initInterface() {
        currentState = .empty
        iconLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont.init(name: "ArialRoundedMTBold", size: 46)
        addSubview(iconLabel)
    }
    
    
    func updateState(_ state: Player) {
        currentState = state
        switch state {
        case .x:
            iconLabel.text = "X"
        case .o:
            iconLabel.text = "O"
        case .empty:
            iconLabel.text = ""
        }
    }
    
    func displayWin() {
        self.backgroundColor = Constants.winColor
    }
    
    func reset() {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            self.center = self.center
        }) { (complete) in
            self.backgroundColor = .white
            self.updateState(.empty)
            UIView.animate(withDuration: 0.25, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.center = self.center
            })
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.frame = CGRect(x: self.frame.minX - 5, y: self.frame.minY - 5, width: self.frame.width + 10, height: self.frame.height + 10)
        }) { (complete) in
            UIView.animate(withDuration: 0.1, animations: {
                self.frame = CGRect(x: self.frame.minX + 5, y: self.frame.minY + 5, width: self.frame.width - 10, height: self.frame.height - 10)
            })
        }
    }
    

}
