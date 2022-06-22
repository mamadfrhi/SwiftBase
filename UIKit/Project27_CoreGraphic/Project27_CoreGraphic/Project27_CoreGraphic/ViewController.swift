//
//  ViewController.swift
//  CoreGraphic
//
//  Created by iMamad on 12.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    private var currentDrawType = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redrawTapped(self)
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        if currentDrawType == 10 { currentDrawType = 0 }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawLadder()
        case 7:
            drawFadingSquare()
        case 8:
            drawFadingInnerSquare()
        case 9:
            drawWowEmoji()
        default:
            break
        }
    }
    
    private func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let rect = CGRect(x: 0, y: 0, width: 512, height: 512)
            let cgContext = ctx.cgContext
            
            cgContext.setFillColor(UIColor.red.cgColor)
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.setLineWidth(50)
            
            cgContext.addRect(rect)
            cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    private func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let rect = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            let cgContext = ctx.cgContext
            
            cgContext.setFillColor(UIColor.red.cgColor)
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.setLineWidth(10)
            
            cgContext.addEllipse(in: rect)
            cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    private func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    private func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let cgContext = ctx.cgContext
            
            cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = .pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                cgContext.rotate(by: amount)
                let rect = CGRect(x: -128, y: -128,
                                  width: 256, height: 256)
                cgContext.addRect(rect)
            }
            
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.strokePath()
        }
        imageView.image = image
    }
    
    private func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let cgContext = ctx.cgContext
            
            cgContext.translateBy(x: 256, y: 256)
            
            let middleRect = CGRect(origin: CGPoint(x: -5, y: -5),
                                    size: CGSize(width: 10, height: 10))
            cgContext.fill(middleRect)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                cgContext.rotate(by: .pi / 2 ) // rotate 180 degree
                let startPoint = CGPoint(x: length, y: 50)
                
                if first {
                    cgContext.move(to: startPoint)
                    first = false
                } else {
                    cgContext.addLine(to: startPoint)
                }
                
                length *= 0.99
            }
            
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.strokePath()
        }
        imageView.image = image
    }
    
    private func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { _ in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let font = UIFont.systemFont(ofSize: 36)
            
            let attrs : [NSAttributedString.Key : Any] = [
                .font : font,
                .paragraphStyle : paragraphStyle
            ]
            
            let string = "Hi, I'm a mouse that has been drawn using CG! :D"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            let rect = CGRect(x: 32, y: 32, width: 448, height: 448)
            attributedString.draw(with: rect, options: .usesLineFragmentOrigin, context: nil)
            
            let mouseImage = UIImage(named: "mouse")
            mouseImage?.draw(at: CGPoint(x: 250, y: 180))
        }
        imageView.image = image
    }
}

// Custom shapes & Challenges
extension ViewController {
    private func drawLadder() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 512))
        
        let image = renderer.image { ctx in
            let cgContext = ctx.cgContext
            
            let x = 20
            var y = 20
            let yStep = 20
            let floors = (512 / yStep) * 2
            
            cgContext.move(to: CGPoint(x: 20, y: 20))
            
            for i in 0 ..< floors-1 {
                if i.isMultiple(of: 2) {
                    cgContext.addLine(to: CGPoint(x: 440, y: y))
                } else {
                    y = y + yStep
                    cgContext.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            cgContext.setLineWidth(2)
            cgContext.setStrokeColor(UIColor.black.cgColor)
            cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    private func drawFadingSquare() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let cgContext = ctx.cgContext
            cgContext.translateBy(x: 256, y: 256)
            
            let degree = Double.pi / 50
            var length = 250.0
            
            while length > 0.1 {
                
                let rect = CGRect(x: -125, y: -125,
                                  width: length, height: length)
                cgContext.addRect(rect)
                
                length *= 0.7
                
                cgContext.rotate(by: degree)
            }
            
            
            
            cgContext.drawPath(using: .stroke)
        }
        
        imageView.image = image
    }
    
    private func drawFadingInnerSquare() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let cgContext = ctx.cgContext
            cgContext.translateBy(x: 256, y: 256)
            
            let degree = Double.pi / 50
            var length = 250.0
            var startPoint = -125.0
            let decreaser = 0.85
            
            while length > 1 {
                let rect = CGRect(x: startPoint, y: startPoint,
                                  width: length, height: length)
                cgContext.addRect(rect)
                
                length *= decreaser
                startPoint = startPoint * decreaser
                
                cgContext.rotate(by: degree)
            }
            cgContext.setLineWidth(2)
            cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    private func drawWowEmoji() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let cgContext = ctx.cgContext
            cgContext.translateBy(x: 256, y: 256)
            
            // face
            let face = CGRect(x: -128, y: -128, width: 256, height: 256)
            cgContext.addEllipse(in: face)
            
            let eyeSize = 50
            let startEye = 80
            // draw left eye
            let leftEye = CGRect(x: -startEye, y: -startEye, width: eyeSize, height: eyeSize)
            cgContext.addEllipse(in: leftEye)
            
            // draw right eye
            let rightEye = CGRect(x: (startEye - eyeSize), y: -startEye, width: eyeSize, height: eyeSize)
            cgContext.addEllipse(in: rightEye)
            
            // draw mouth
            let mouthSize = 80
            let mouth = CGRect(x: -(mouthSize/2), y: 16, width: mouthSize, height: mouthSize)
            cgContext.addEllipse(in: mouth)
            
            cgContext.setStrokeColor(UIColor.red.cgColor)
            cgContext.setLineWidth(2)
            cgContext.strokePath()
        }
        
        imageView.image = image
    }
}
    

// The base tutorial is from below
// https://www.hackingwithswift.com/read/27/overview
