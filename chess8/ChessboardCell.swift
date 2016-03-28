//
//  ChessboardCell.swift
//  chess8
//
//  Created by Aleksandr Skorokhodov on 28.03.16.
//  Copyright © 2016 Aleksandr Skorokhodov. All rights reserved.
//

import Foundation

enum Colors{
    case Black
    case White
}

enum ChessError: ErrorType {
    case WrongCellIndex(msg: String)
    case NotEmptyCell
    case Another
}

// клетка на шахматной доске
class ChessboardCell : CustomStringConvertible, Hashable, Comparable {

    // колонка (там где буква)
    var column: Int
    // ряд (там где цифра)
    var row: Int
    // цвет
    var color: Colors

    var description: String  {
        get {
            let codeOfA = 97
            let charColumn = Character(UnicodeScalar(self.column + codeOfA - 1))
            return String("\(charColumn)\(self.row)")
        }
    }

    // конструктор
    init(column: Int, row: Int) throws {
        self.column = column
        self.row = row
        self.color = Colors.Black

        if !( 1...8 ~= self.column ) {
            throw ChessError.WrongCellIndex(msg: "wrong column \(self.column)");
        }
        if !( 1...8 ~= self.row ) {
            throw ChessError.WrongCellIndex(msg: "wrong row \(self.row)");
        }
        self._findColor()
    }

    // определяет цвет ячейки
    func _findColor() {
        self.color = ((self.column + self.row) % 2 == 0) ? Colors.Black : Colors.White
    }

    // Возвращает список ячеек которые бьет ферзь стоящий на этой клетке
    func hitedCells() throws -> Set<ChessboardCell>  {
        var ret = Set<ChessboardCell>()
        for ind in 1...8 {
            var cell = try ChessboardCell(column: ind, row: self.row )
            ret.insert(cell)
            cell = try ChessboardCell(column: self.column, row: ind)
            ret.insert(cell)

            let upDiagonalInd: Int = self.row - self.column + ind
            if ( 1...8 ~= upDiagonalInd ) {
                cell = try ChessboardCell(column: ind, row:  upDiagonalInd)
                ret.insert(cell)
            }
            let downDiagonalInd: Int = self.row + self.column - ind
            if ( 1...8 ~= downDiagonalInd ) {
                cell = try ChessboardCell(column: ind, row: downDiagonalInd)
                ret.insert(cell)
            }
        }
        return ret
    }

    var hashValue : Int {
        get {
            return "\(self.column)\(self.row)".hashValue
        }
    }

}
// вообще не понятно почему так, hashValue метод класса а == < нет
func ==(lhs: ChessboardCell, rhs: ChessboardCell) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
func <(left: ChessboardCell, right: ChessboardCell) -> Bool {
    if left.column == right.column {
        return left.row <= right.row
    } else {
        return left.column < right.column
    }
}

