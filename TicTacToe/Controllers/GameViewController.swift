//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Will Oakley on 4/4/19.
//  Copyright © 2019 Will Oakley. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var currentTurnLabel: UILabel!
    @IBOutlet weak var a1: GameCell!
    @IBOutlet weak var a2: GameCell!
    @IBOutlet weak var a3: GameCell!
    @IBOutlet weak var b1: GameCell!
    @IBOutlet weak var b2: GameCell!
    @IBOutlet weak var b3: GameCell!
    @IBOutlet weak var c1: GameCell!
    @IBOutlet weak var c2: GameCell!
    @IBOutlet weak var c3: GameCell!
    
    var cells: [GameCell]!
    var currentPlayer: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cells = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
        initalizeInterface()
        resetGame()
    }
    
    func initalizeInterface() {
        for (i, c) in cells.enumerated() {
            c.tag = i
            let touchHandler = UITapGestureRecognizer(target: self, action: #selector(tappedCell(sender:)))
            c.addGestureRecognizer(touchHandler)
        }
    }
    
    //Function called when user taps a cell. Behavior depends on currentPlayer.
    @objc func tappedCell(sender: UITapGestureRecognizer) {
        if let viewTag = sender.view?.tag {
            if currentPlayer == .x {
                cells[viewTag].updateState(.x)
            } else if currentPlayer == .o {
                cells[viewTag].updateState(.o)
            }
            checkForWin()
        }
    }
    
    //Scans game state to see if there is a winner or full board. Call win/lose function if so, otherwise switch player.
    func checkForWin() {
        //Checking for horizontal win
        for i in [0, 3, 6] {
            if cells[i].currentState == .empty {
                break
            }
            if cells[i].currentState == cells[i + 1].currentState &&
                cells[i + 1].currentState == cells[i + 2].currentState {
                print("Horizontal win")
                win(cells[i].currentState, cellIndicies: [i, i+1, i+2])
                return
            }
        }
        
        //Checking for vertical win
        for i in [0, 1, 2] {
            if cells[i].currentState == .empty {
                break
            }
            if cells[i].currentState == cells[i + 3].currentState &&
                cells[i + 3].currentState == cells[i + 6].currentState {
                print("Vertical win")
                win(cells[i].currentState, cellIndicies: [i, i+3, i+6])
                return
            }
        }
        
        //Checking for diagonal win
        for i in [0, 2] {
            if cells[i].currentState == .empty {
                break
            }
            let increment = 4 - i
            if cells[i].currentState == cells[i + increment].currentState &&
                cells[i + increment].currentState == cells[i + (increment * 2)].currentState {
                print("Diagonal Win")
                win(cells[i].currentState, cellIndicies: [i, i+increment, i+(increment*2)])
                return
            }
        }
        
        //Checking for full board
        for c in cells {
            //Game still going
            if c.currentState == .empty {
                switchPlayer()
                return
            }
        }
        
        //All cells are full with no win
        lose()
    }
    
    //Ends game, animates cells and displays winner.
    func win(_ player: Player, cellIndicies: [Int]) {
        print("Win!")
        print(cellIndicies)
        if player == .x {
            self.currentTurnLabel.text = "X wins!"
        } else if player == .o {
            self.currentTurnLabel.text = "O wins!"
        }
        for (i, c) in cellIndicies.enumerated() {
            let delay = Double(i) * 0.05
            Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { (t) in
                self.cells[c].backgroundColor = Constants.winColor
                self.cells[c].animate()
            }
        }
        playAgainButton.alpha = 1.0
    }
    
    //Ends game, animates cells and asks user to reset.
    func lose() {
        for c in cells {
            c.animate()
            c.backgroundColor = Constants.gameOverColor
        }
        self.currentTurnLabel.text = "Game Over 😢"
        print("Game Over")
        playAgainButton.alpha = 1.0
    }
    
    //Switches current player after turn and updates UI label.
    func switchPlayer() {
        if currentPlayer == .x {
            currentPlayer = .o
            currentTurnLabel.text = "Current Turn: O"
        } else if currentPlayer == .o {
            currentPlayer = .x
            currentTurnLabel.text = "Current Turn: X"
        }
    }
    
    //Resets game to blank board.
    @objc func resetGame() {
        for c in cells {
            c.reset()
        }
        playAgainButton.alpha = 0.0
        currentPlayer = .x
        currentTurnLabel.text = "Current Turn: X"
    }

    //Called when play again button is tapped.
    @IBAction func tappedPlayAgain(_ sender: Any) {
        resetGame()
    }
}
