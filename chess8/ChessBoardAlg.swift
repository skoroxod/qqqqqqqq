//
//  ChessBoardAlg.swift
//  chess8
//
//  Created by Aleksandr Skorokhodov on 28.03.16.
//  Copyright © 2016 Aleksandr Skorokhodov. All rights reserved.
//

import Foundation

class ChessBoardAlg {

    // шахматная доска
    var board: ChessBoard;
    //  корень дерева решений
    var root: ChessTreeNode;
    // список найденных решений
    var results: Set<Set<ChessboardCell>> = Set();

    // конструктор
    init() {
            self.board = ChessBoard()
            self.root = ChessTreeNode(emptyCells: Set(self.board.getAllCells()))
    }

    // спуск вниз по дереву, до тех пор пока не попадем
    // в узел дерева у которого список emptyCells пустой
    func traverseDown(tree: ChessTreeNode) throws -> ChessTreeNode {
        var subTree = tree
        while (subTree.emptyCells.count > 0) {
            subTree = try subTree.processEmptyCell()
        }
        return subTree
    }

    // поднимаемся по дереву вверх, до первого узла
    // у которого список emptyCells не пустой
    func traverseUp(tree: ChessTreeNode) -> ChessTreeNode? {
        let parentTree = tree.parent
        if parentTree == nil {
            return nil
        }
        if (parentTree!.emptyCells.count == 0) {
            return traverseUp(parentTree!)
        } else  {
            return parentTree
        }
    }

    // нпоиск решений
    func run() throws -> Void {
        var subTree: ChessTreeNode? = root
        var cnt = 1
        while (true){
            subTree = try traverseDown(subTree!)
            if subTree!.level == 8 {
                print("Result \(cnt++): \(subTree!.getPath().sort())")
                self.results.insert(subTree!.getPath())
            }
            subTree = traverseUp(subTree!)
            if subTree == nil {
                print("Stop")
                break
            }
        }
        print("total \(self.results.count)")
    }
}
