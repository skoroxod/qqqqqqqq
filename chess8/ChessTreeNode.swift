//
//  ChessTreeNode.swift
//  chess8
//
//  Created by Aleksandr Skorokhodov on 28.03.16.
//  Copyright © 2016 Aleksandr Skorokhodov. All rights reserved.
//

import Foundation

public class ChessTreeNode: CustomStringConvertible {

    // ячейка на шахматной доске в которую будет добавлен ферзь
    var node: ChessboardCell?
    // список пустых ячеек на шахматной доске для данного узла
    var emptyCells: Set<ChessboardCell> = Set()

    var level: Int = 0

    // ссылка на родительский узел
    var parent: ChessTreeNode?
    // список потомков данного узла
    var childrens: [ChessTreeNode] = []

    public var description: String  {
        get {
            var ret: String = "Tree node:\n"
            if (self.node != nil) {
                ret += (self.node?.description)!
            } else  {
                ret += "nil"
            }
            ret += " level: "
            ret += "\(self.level)"
            return ret
        }
    }

    // конструктор для root узла
    init(emptyCells: Set<ChessboardCell>) {
        self.node = nil
        self.parent = nil
        self.level = 0
        self.emptyCells = emptyCells
    }

    // Конструктор для нижних узлов
    init(node: ChessboardCell, parent: ChessTreeNode) throws {
        self.node = node
        self.parent = parent
        self.level = self.parent!.level + 1
        try self.calculateChildrens()
    }

    // internal mathod 
    // вычисляет пустые ячейки на доске и сохраняет их в emptyCells
    func calculateChildrens() throws {
        if(self.parent != nil) {
            let hitedCells = try self.node?.hitedCells()
            self.emptyCells = self.parent!.emptyCells.subtract(hitedCells!)
        }
    }

    // берет пустую ячейку из списка emptyCells ставит на  нее ферзя и добавляет 
    // себе в потомки узел с этим полем
    // TODO сюда надо передавать метод который возвращает элемент из Set
    func processEmptyCell() throws -> ChessTreeNode {

        let randomIndex = Int(arc4random_uniform(UInt32(self.emptyCells.count)))
        let cell = Array(self.emptyCells)[randomIndex]

        let newSubTree = try ChessTreeNode(node: cell, parent: self)
        self.childrens.append(newSubTree)
        self.emptyCells.remove(cell)
        return newSubTree
    }

    // Возвращает путь от данной ячейки до корня дерева
    func getPath() -> Set<ChessboardCell>{
        var ret: Set<ChessboardCell> = Set()
        if self.node != nil {
            ret.insert(self.node!)
        }
        if self.parent != nil {
            ret.unionInPlace(self.parent!.getPath())
        }
        return ret
    }
}
