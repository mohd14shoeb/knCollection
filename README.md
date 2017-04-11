This is my collection of code snippets, extensions, my custom controls, or great controls from great developers. 

## Controls
### knComposerView

A text composer with record and select photo button. Usually used in chat app. 
	
  ![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/ComposerView.png)
	
Resources required: This view needs some photos named "camera", "micro", "send", and "three_dot_vertical". 

Add some below code into your controller to always show ComposerView above of the keyboard and automatically show/hide keyboard. Please remember, this way only works with `UITableViewController/UICollectionViewController`. 

	lazy var composerView: knComposerView? = { [weak self] in
        let view = knComposerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56))
        view.delegate = self
        return view
        
    }() /* composerView */
    
    override var inputAccessoryView: UIView? {
        get {
            return composerView
        }
        set { // try to release composerView 
            composerView?.removeFromSuperview()
            composerView = nil
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }


### knDateDialog 
A simple date picker. Just set delegate and show it in where you want. 

  ![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/DateDialog.png)
	
	fxDateDialog.center.show(in: containerView)

A great DatePickerDialog from Squimer (https://github.com/squimer/DatePickerDialog-iOS-Swift). I used it before I write a new one with my custom UI. 

Or a DatePicker from bottom of the screen https://github.com/MarioIannotta/MIDatePicker

### GradientView 

Awesome lib from Sam Soffes (https://github.com/squimer/DatePickerDialog-iOS-Swift)

### KMPlaceholderTextView
Popular placeholder for UITextView. Try it from (https://github.com/MoZhouqi/KMPlaceholderTextView)

### knAnalogClockView

Render an analog clock. Have a look at https://github.com/nguyentruongky/TimeLearner

Learn from this project https://github.com/DuncanMC/ClockAnimation in Objective-C. Thanks, Duncan. 

### knAnimationScrollView

Sample is ready at https://github.com/nguyentruongky/EffectScrollView

### knUIBarButtonWithNumber

I learnt it from an Objective-C project 2 years ago in a notification bar button. Sample projects here https://github.com/nguyentruongky/UIBarButtonWithNumber

### knButton 
A button with an UIActivityIndicatorView at the center when click. Can be used while waiting for an complete action such as login, uploading or posting... 
Exactly same behavior to UIButton. But please use `animate()` when click and `stopAnimating()` when the action completed. 

### CodeView
Used for enter an OTP code, or passcode. Try sample at https://github.com/nguyentruongky/ActiveCode

### knDotLoadingIndicator
Zoom in and out 3 dots for loading indicator. Will support more effect in near future. 

### knDraggableViewCollection
Tinder-like effect. 

### knGistTextField

Custom TextField with a fixed label on the top, an underline, and an error message at the bottom. 

![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/GistTextField.png)

### knLoadingView 

Simple loading indicator in any views you want. Support some loading types: 
	- Center: An UIActivityIndicatorView in the center of your container view. 
	- Footer: A banner at the bottom of your container view. 

Easy to use with `knLoading.loading.showLoading(_ type: LoadingType, inView view: UIView, margin: UIEdgeInsets = UIEdgeInsets.zero)` and `knLoading.loading.hideLoadingView()`

### knPageViewController 
Sample is here https://github.com/nguyentruongky/KPageViewController

### knRippleAnimationView 

![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/RippleAnimation.gif)

Used to indicate a location on the map. 

### knShimmerView 

![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/ShimmerAnimation.gif)
	
	let newView = knShimmerView(frame: CGRect(x: 0, y: 30, width: 300, height: 100))
    newView.font = UIFont.boldSystemFont(ofSize: 32)
    view.addSubview(newView)
    newView.text = "Hello there"

### knTagView 

A center-aligned tag collection. 

![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/TagView.gif)
	
    let tag = knTagView()
    tag.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tag)
    // set auto layout

    tag.tags = [
        knTag(text: "iOS"),
        knTag(text: "Swift"),
        knTag(text: "UIKit"),
        knTag(text: "CoreAnimation"),
        knTag(text: "XCode 8.3"),
        knTag(text: "knTagView")
    ]

I use a custom collection view layout named `CenterAlignedCollectionViewFlowLayout` from Alex Koshy (found from stackoverflow) in this view, to center the collection view cell. 

### knTwoCollumnsCollectionViewLayout
Two columns layout for UICollectionView, like Pinterest. Learn more from here https://www.raywenderlich.com/107439/uicollectionview-custom-layout-tutorial-pinterest

### knUnderlineTextField

![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/UnderlineTextField.png)
	
An underline to indicate first responder textfield. 

### knPhotoSelectorWorker

Very easy to show a photo selector or take a photo. 

	knPhotoSelectorWorker(finishSelection: { [weak self] image in
		self?.imageView.image = image    
	}).execute()

Prevent having a crash, I have to add these fields to Info.plist

	<key>NSCameraUsageDescription</key>
	<string>We need to access to your camera</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>We need to access to your photo library</string>

An extension to find the topViewController is needed here 

	extension UIApplication {
	    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
	        if let nav = base as? UINavigationController {
	            return topViewController(nav.visibleViewController)
	        }
	        if let tab = base as? UITabBarController {
	            if let selected = tab.selectedViewController {
	                return topViewController(selected)
	            }
	        }
	        if let presented = base?.presentedViewController {
	            return topViewController(presented)
	        }
	        return base
	    }
	}

### knRecordView

  ![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/RecordView.gif)

### RSKCollectionViewRetractableFirstItemLayout
Awesome layout for collection view from Ruslan Skorb. Read his instruction here https://github.com/ruslanskorb/RSKCollectionViewRetractableFirstItemLayout

### PageControls
An excellent library from Kyle Zaragoza. https://github.com/popwarsweet/PageControls

### CardCollectionView 
From Kyle Zaragoza, too. https://github.com/popwarsweet/CardCollectionView

### StreamingProgressBar
From Kyle Zaragoza, too. https://github.com/popwarsweet/StreamingProgressBar

### TKTransitionSubmitButton
Awesome transition from Takuya Okamoto: https://github.com/entotsu/TKSubmitTransition

### knUploadWorker 
Easy post multipart supporter. 

	knUploadWorker(api: "your_api", uploadData: Your_file_data).execute()

Config token, other params, callbacks, file name in initializer. 

### knValidationWorker

Validation collection for email, password (6 or more characters), Singapore phone number, car plate number, car VIN number, year

	knValidationWorker(your_call_back).validateEmail("nguyentruongky33@gmail.com")
    knValidationWorker(your_call_back).validatePassword("123456")

## Extensions 

### Int 
Random an Integer in range 

	public extension UInt32 {
    
	    // prevent overflow with Int and Int32
	    public static func random(lower: UInt32 = min, upper: UInt32 = max / 2) -> Int {
	        return Int(arc4random_uniform(upper - lower - 10) + lower)
	    }
	}



### Date
Some different ways to init a Date, convert Date to String with format, convert String to Date, get Date components
	
	print(Date().toString("dd/MM/yyyy")) // 12/04/2017
    print(Date().dayOfTheWeek()) // Wednesday
    print(Date(dateString: "03/03/1990 15:00", format: "dd/MM/yyyy hh:mm")) // 1990-03-03 08:00:00 +0000: (GMT+0)

### String 
Bold or italic a string in a string, format paragraph line spacing, strikethrough text, estimate frame for text, split string, check email valid,... 

	print("nguyentruongky".isValidEmail()) // false
	print("iOS, development, with XCode 8".splitString(",")) 
		// ["iOS", " development", " with XCode 8"]
	print("This is knCollection".estimateFrameForText(withFont: .boldSystemFont(ofSize: 15), estimateSize: CGSize(width: 100, height: 100))) 
		// (0.0, 0.0, 89.40673828125, 35.80078125)

Reference some more functions from Andrew Mayne

### UIApplication 

Find top View Controller 


	extension UIApplication {
	    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
	        if let nav = base as? UINavigationController {
	            return topViewController(nav.visibleViewController)
	        }
	        if let tab = base as? UITabBarController {
	            if let selected = tab.selectedViewController {
	                return topViewController(selected)
	            }
	        }
	        if let presented = base?.presentedViewController {
	            return topViewController(presented)
	        }
	        return base
	    }
	}

### UIButton

Animate button: `button.animate(atPosition: CGPoint.zero)`

![](https://github.com/nguyentruongky/knCollection/blob/develop/knCollection/Demo/AnimateButton.gif)


### UIColor 

Create color from RGB, from just one value, from hex String 

### UIBarButton 

	extension UIBarButtonItem {
	    func changeTitleColor(_ color: UIColor = UIColor.blue, font: UIFont = UIFont.systemFont(ofSize: 14)) {
	        let deleteCardFormat = [
	            NSForegroundColorAttributeName: color,
	            NSFontAttributeName: font]
	        setTitleTextAttributes(deleteCardFormat, for: UIControlState())
	    }
	}

### UILabel 

	extension UILabel{
	    func createSpaceBetweenLines(_ alignText: NSTextAlignment = NSTextAlignment.left, spacing: CGFloat = 7) {
	        let paragraphStyle = NSMutableParagraphStyle()
	        paragraphStyle.lineSpacing = spacing
	        paragraphStyle.maximumLineHeight = 40
	        paragraphStyle.alignment = .left
	        
	        let ats = [NSParagraphStyleAttributeName:paragraphStyle]
	        attributedText = NSAttributedString(string: self.text!, attributes:ats)
	        textAlignment = alignText
	    }
	}
	
### UIImage and UIImageView 

Add blur effect, save image to disk, scale, resize, crop image, change color, create image from solid color

### UINavigationController 

Show hide navigation bar on scrolling, fill navigation bar with solid color or gradient, change title font. 

### UIScrollView 

	extension UIScrollView {
	    
	    func animateHeaderView(staticView: UIView, animatedView: UIView) {
	        
	        var headerTransform = CATransform3DIdentity
	        let yOffset = contentOffset.y
	        staticView.isHidden = yOffset < 0
	        animatedView.isHidden = yOffset > 0
	        if yOffset < 0 {
	            let headerScaleFactor:CGFloat = -(yOffset) / animatedView.bounds.height
	            let headerSizevariation = ((animatedView.bounds.height * (1.0 + headerScaleFactor)) - animatedView.bounds.height)/2.0
	            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
	            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
	            animatedView.layer.transform = headerTransform
	        }
	    }
	    
	}
	
### UISearchBar 

Set text color, set textfield background

### UITableView
Only works in Storyboard

	extension UITableView {
	    
	    func resizeTableHeaderView(toSize size: CGSize) {
	        
	        guard let headerView = tableHeaderView else { return }
	        headerView.frame.size = headerView.systemLayoutSizeFitting(size)
	        tableHeaderView? = headerView
	    }
	    
	}


### UITextField
Set left view, right view, show hide password, change placeholder color 

### UITextView 
	
	extension UITextView {
	    
	    func wrapText(aroundRect rect: CGRect) {
	        let path = UIBezierPath(rect: rect)
	        textContainer.exclusionPaths = [path]
	    }
	}

### UIView

Clear subviews, create border, create round corner, create image from UIView, shake animation

Set background and border with gradient (not work with Auto Layout by code).

Some auto layout functions. Read more about this lib at https://github.com/nguyentruongky/knConstraints

	func addConstraint(attribute: NSLayoutAttribute, equalTo view: UIView, toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
	        
	        let myConstraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: toAttribute, multiplier: multiplier, constant: constant)
	        return myConstraint
	    }
	    
	    func addConstraints(withFormat format: String, views: UIView...) {
	        
	        var viewsDictionary = [String: UIView]()
	        
	        for i in 0 ..< views.count {
	            let key = "v\(i)"
	            views[i].translatesAutoresizingMaskIntoConstraints = false
	            viewsDictionary[key] = views[i]
	        }
	        
	        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
	    }
	    
### UIViewController 
Add back button on presented ViewController, custom back button in NavigationController

### UITableViewController


	extension UITableViewController {
	    
	    func animateTable() {
	        
	        tableView.reloadData()
	        let cells = tableView.visibleCells
	        let tableHeight = tableView.bounds.size.height
	        for cell in cells {
	            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
	        }
	        var index = 0
	        for cell in cells {
	            UIView.animate(withDuration: 1.25, delay: 0.05 * Double(index),
	                                       usingSpringWithDamping: 0.65,
	                                       initialSpringVelocity: 0.0,
	                                       options: UIViewAnimationOptions(),
	                                       animations:
	                {
	                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
	                },
	                                       completion: nil)
	            
	            index += 1
	        }
	    }
	}
	
### UITabBarController

	extension UITabBarController {
	    
	    func setTabBar(visible: Bool) {
	        tabBar.frame.size.height = visible ? 49 : 0
	        tabBar.isHidden = !visible
	    }
	}
	
	
