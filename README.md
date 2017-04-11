This is my collection of code snippets, extensions, my custom controls, or great controls from great developers. 

## Controls
### knComposerView

A text composer with record and select photo button. Usually used in chat app. 
	
	Photo here 
	
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

	Photo here
	
	
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

	Photo here

### knLoadingView 

Simple loading indicator in any views you want. Support some loading types: 
	- Center: An UIActivityIndicatorView in the center of your container view. 
	- Footer: A banner at the bottom of your container view. 

Easy to use with `knLoading.loading.showLoading(_ type: LoadingType, inView view: UIView, margin: UIEdgeInsets = UIEdgeInsets.zero)` and `knLoading.loading.hideLoadingView()`

### knPageViewController 
Sample is here https://github.com/nguyentruongky/KPageViewController

### knRippleAnimationView 

	Photo here 
Used to indicate a location on the map. 

### knShimmerView 

	Photo here 
	
	let newView = knShimmerView(frame: CGRect(x: 0, y: 30, width: 300, height: 100))
    newView.font = UIFont.boldSystemFont(ofSize: 32)
    view.addSubview(newView)
    newView.text = "Hello there"

### knTagView 

A center-aligned tag collection. 

	Photo here 
	
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

	Photo here
	
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

	Photo here 

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

