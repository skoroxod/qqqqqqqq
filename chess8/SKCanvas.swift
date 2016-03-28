//
//  SKCanvas.swift
//  chess8
//
//  Created by Aleksandr Skorokhodov on 24.03.16.
//  Copyright © 2016 Aleksandr Skorokhodov. All rights reserved.
//

import UIKit

class SKCanvas: UIView {


    var labels: Array<UILabel> = Array();

    func newX(x : CGFloat) -> CGFloat {
        return CGFloat(x + self.cellSize());
    }

    func newY(y : CGFloat) -> CGFloat {
        return CGFloat(self.bounds.size.height - cellSize() - y )
    }

    func cellSize() -> CGFloat {

        let s = self.bounds.size.width > self.bounds.size.height ? self.bounds.size.height : self.bounds.size.width
        return CGFloat(Int(s / 10))
    }


    func drawCell(ctx: CGContext, col: Int, row: Int ) throws -> Void {
        let c = try ChessboardCell(column: col , row: row)
        NSLog("cell: \(c)")

        let x = CGFloat(col - 1) * cellSize()
        let y = CGFloat(row - 1) * cellSize()
        let rectangle = CGRectMake( x, y, cellSize(), cellSize());
        NSLog("cell rect: \(rectangle)")

        CGContextAddRect(ctx, rectangle);
        if (c.color == Colors.White) {
            CGContextSetFillColorWithColor(ctx, UIColor.blackColor().CGColor);
        } else {
            CGContextSetFillColorWithColor(ctx, UIColor.lightGrayColor().CGColor);
        }
        CGContextFillRect(ctx, rectangle);

    }


    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextTranslateCTM(ctx, CGFloat(cellSize()), -self.bounds.size.height + CGFloat(cellSize()));

        let rectangle = CGRectMake( 0, 0, 8*cellSize(), 8*cellSize());
        CGContextAddRect(ctx, rectangle);
        let color = UIColor(colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)
        CGContextSetFillColorWithColor(ctx,color.CGColor);
        CGContextFillRect(ctx, rectangle);

        do {
            for col in 1...8 {
                for row in 1...8 {
                    try self.drawCell(ctx!, col: col, row: row)
                }
            }
        } catch {
            NSLog("error")
        }
    }

    func redrawQueens(queens: Set<ChessboardCell>) -> Void {

        for l in self.labels {
            l.removeFromSuperview()
        }
        self.labels.removeAll()
        for cell in queens {
            let label = UILabel(frame: CGRectMake(0, 0, 40, 20))

            let cX = newX(CGFloat(cell.column - 1) * cellSize() + cellSize()/2);
            let cY = newY(CGFloat(cell.row - 1) * cellSize() + cellSize()/2)
            label.center = CGPointMake(cX, cY)
            label.textColor = UIColor.cyanColor();
            label.highlighted = true
            label.textAlignment = NSTextAlignment.Center
            label.text = "Q"
            self.addSubview(label)
            self.labels.append(label)
        }
    }
    
}

