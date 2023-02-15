import UIKit

public extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach{
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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

    func addShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 16
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

extension Date {
    var dayAndMonthStringComponents: (String, String) {
        (DateFormatter.weekdayDateFormatter.string(from: self), DateFormatter.onlyDayDateFormatter.string(from: self))
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let newImage else { return self }

        return newImage
    }
}
