//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//
import Foundation
import Charts
#if canImport(UIKit)
    import UIKit
#endif

// class for creating popun when clicked in chart data set
open class BalloonMarker: MarkerImage
{
    // MARK: properties
    @objc open var color: UIColor
    @objc open var arrowSize = CGSize(width: 8, height: 18)
    @objc open var font: UIFont
    @objc open var textColor: UIColor
    @objc open var insets: UIEdgeInsets
    @objc open var minimumSize = CGSize()
    
    /// labels to be displayed inside the balloon
    fileprivate var label: String?
    fileprivate var bandLabel: String?
    fileprivate var salaryLabel: String?
    fileprivate var incrementLabel: String?
    fileprivate var percentageLabel: String?
    
    /// labels customizations
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : Any]()
    
    // MARK: initializers
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .left
        _paragraphStyle?.lineSpacing = 2
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size

        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }

        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0

        var origin = point
        origin.x -= width / 2
        origin.y -= height

        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }

        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }

        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()

        context.setFillColor(color.cgColor)
        context.setShadow(offset: CGSize(width: 0, height: 0), blur: 24)

        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
            
            
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }

        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        // setting labels for each type
        setLabel(salaryLabel!, fontC: .systemFont(ofSize: 13), textColorC: .label)
        salaryLabel?.draw(in: rect, withAttributes: _drawAttributes)

        setLabel(incrementLabel!, fontC: .systemFont(ofSize: 13), textColorC: UIColor(hex: "#08BE61FF") ?? .systemGreen)
        incrementLabel?.draw(in: rect, withAttributes: _drawAttributes)

        setLabel(percentageLabel!, fontC: .systemFont(ofSize: 13), textColorC:  UIColor(hex: "#08BE61FF") ?? .systemGreen)
        percentageLabel?.draw(in: rect, withAttributes: _drawAttributes)
        
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        let val = Int(entry.x)
        //getting data according to the x value of the entry
        let popupData = SalaryData().initializeData()[val]

        // initializing temp variables
        let band = popupData.band
        let salary = popupData.salary
        let increment = popupData.increment
        let percentage = Calculations().getIncrementAccordingToChartIndex(increment: increment, salary: salary)
        
        // setting and formatting labels according to the need
        setDataLabelsFormat(band: band, salary: salary, increment: increment, percentage: percentage)
        
        setLabel(bandLabel!, fontC: .systemFont(ofSize: 14, weight: .semibold), textColorC: .label)
    }
    
    func setDataLabelsFormat(band: Double, salary: Double, increment: Double, percentage: Double){
        
        let cal = Calculations()
        
        bandLabel = "\tBand \(band)\n\n\n"
        salaryLabel = "\n\t• \(cal.convertToCurrencyFormat(intString: Int(salary))) PKR"
        incrementLabel = "\n\n\t  +PKR \(cal.convertToCurrencyFormat(intString: Int(increment)))/-\t"
        percentageLabel = "\n\n\n\t  (+\(cal.getDoublePrecision2(percentage: percentage)))%"
    }
    
    @objc open func setLabel(_ newLabel: String, fontC: UIFont, textColorC: UIColor)
    {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = fontC
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = textColorC
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        
        self.size = size
    }
}
