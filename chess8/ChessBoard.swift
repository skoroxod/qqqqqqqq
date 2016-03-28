//
//  ChessBoard.swift
//  chess8
//
//  Created by Aleksandr Skorokhodov on 28.03.16.
//  Copyright © 2016 Aleksandr Skorokhodov. All rights reserved.
//

import Foundation
// Класс "шахматная доска"
class ChessBoard : CustomStringConvertible {

    // Ячейки
    var cells: [ChessboardCell] = []

    var description: String  {
        get {
            var ret: String = "Chess Board:\n"
            var cnt: Int = 0
            for cell in self.cells {
                ret += cell.description
                if ++cnt % 8 == 0 {
                    ret += "\n"
                } else {
                    ret += " "
                }
            }
            return ret
        }
    }

    init() {
        do {
        for c in 1...8 {
            for r in 1...8 {
                cells.append(try ChessboardCell(column: c,row: r))
            }
        }
        } catch {
            NSLog("error")
        }
    }

    func getAllCells() -> [ChessboardCell] {
        return self.cells
    }
}
