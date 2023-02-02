//
//  Extensions.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach{ self.addSubview($0)}
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        layer.cornerRadius = radius

        var cornerMask: CACornerMask = []
        if corners.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if corners.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if corners.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if corners.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        if corners.contains(.allCorners) {
            cornerMask = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner,
            ]
        }
        layer.maskedCorners = cornerMask

        if #available(iOS 13, *) {
            layer.cornerCurve = .continuous
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach{ self.addArrangedSubview($0)}
    }
}


extension DateFormatter {
    static let weekdayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"

        return formatter
    }()

    static let onlyDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"

        return formatter
    }()
}
