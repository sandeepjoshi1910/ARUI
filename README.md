# ARUI

[![CI Status](http://img.shields.io/travis/sandeepjoshi1910/ARUI.svg?style=flat)](https://travis-ci.org/sandeepjoshi1910/ARUI)
[![Version](https://img.shields.io/cocoapods/v/ARUI.svg?style=flat)](http://cocoapods.org/pods/ARUI)
[![License](https://img.shields.io/cocoapods/l/ARUI.svg?style=flat)](http://cocoapods.org/pods/ARUI)
[![Platform](https://img.shields.io/cocoapods/p/ARUI.svg?style=flat)](http://cocoapods.org/pods/ARUI)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Swift 4 and the latest Xcode

## Example Project Images/GIFs

### Example App Demo
![Alt Text](https://github.com/sandeepjoshi1910/ARUI/blob/master/Example/ARUI/arUI.gif)

### The Xib file which is parsed to create the UI
![Alt Text](https://github.com/sandeepjoshi1910/ARUI/blob/master/Example/ARUI/Screen%20Shot%202018-01-08%20at%201.31.00%20PM.png)

### Example App Screenshot
![Alt Text](https://github.com/sandeepjoshi1910/ARUI/blob/master/Example/ARUI/IMG_0634.png)



## Installation

ARUI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ARUI'
```

## Instructions to use the Pod

• Start the project in XCode as an ARApp <br />

• Add `pod ARUI` in Podfile and run `pod install`

• Add `import ARUI` to the imports in the `ViewController.swift` of the workspace

• Now go ahead and create an `xib` or View file and build your UI. Make sure to include `UIImage` and `UILabel` only. Rest of the items will be ignored. The pod currently supports `UIImage` and `UILabel` only.<br />

• Make sure to provide an **unique** restoration identifier to each of `UIImage` and `UILabel`. The pod can associate each UI element with the image/text resource through this identifier.<br />

#### Note:
**If you have two UI elements with same restoration identifier, XCode will throw an error. So, once you have set  restoration identifer to an element, don't copy paste it as restoration id is also copied.<br />**

• Now go to the `ViewController.swift` conform to `ARUIDelegateProtocol`<br />

• Now you need to implement two delegate methods<br />

1) `func textResourceFor(restorationId: String) -> ARUITextInfo?`<br />
        This method is called by the pod for each of the `UILabel` present in the `xib` file and you need to return a `ARUITextInfo` object to put appropriate text for each `UILabel`.<br />

2) `func imageResourceFor(restorationId: String) -> UIImage?` <br />
        This method is called by the pod for each of the `UIImage` present in the `xib` file and you need to return a `UIImage` object for each `UIImage` in `xib` file corresponding to its rstoration identifier.<br />
        

#### Sample code for delegate methods(You can also find all the code in example project) - 

``` swift
func textResourceFor(restorationId: String) -> ARUITextInfo? {
        
        switch restorationId {
        case "placeName":
            let textInfo = ARUITextInfo(textString: "Colosseum", color: UIColor.blue, font: "Arial")
            return textInfo
            
        case "builtIn":
            let textInfo = ARUITextInfo(textString: "Built in: 70–80 AD", color: UIColor.black, font: "Arial")
            return textInfo
            
        case "located":
            let textInfo = ARUITextInfo(textString: "Located: city of Rome, Italy", color: UIColor.black, font: "Arial")
            return textInfo
            
        case "capacity":
            let textInfo = ARUITextInfo(textString: "Capacity: Estimated between 50,000 and 80,000 ", color: UIColor.black, font: "Arial")
            return textInfo
            
        case "builtBy":
            let textInfo = ARUITextInfo(textString: "Built by: Emperor Vespasian & Emperor Titus", color: UIColor.black, font: "Arial")
            return textInfo
            
        default:
            break
        }
        
        let textInfo = ARUITextInfo(textString: "Augmented Reality", color: UIColor.blue, font: "Menlo")
        return textInfo
    }
```

``` swift
func imageResourceFor(restorationId: String) -> UIImage? {
        var image = UIImage()
        switch restorationId {
            case "icon":
                image =  UIImage(named: "cicon")!
            case "image1":
                image =  UIImage(named: "image1")!
            case "image2":
                image =  UIImage(named: "image2")!
            case "image3":
                image =  UIImage(named: "image3")!
            case "image4":
                image =  UIImage(named: "image4")!
            default:
                break
        }
        return image
    }

```


• Now go to `viewDidLoad` method and create an instance of `ARUIHandler`. Now you need to provide five parameters to the init method.<br />
1) Name of the xib file you created<br />
       
2) Delegate as self<br />
        
3) Sceneview object - pass the sceneView object of the current class<br />
        
4) arViewWidth - The width of the AR View which will be created. You can set a ballpark number like 15 and change it accordingly based on how it looks. This has to be set in accordance with the depth value.<br />
        
5) arViewDepth - The distance in z axis(in front/back to you). Negative values pushes objects in front of you.(same as scenekit)<br />
        
• Now set a panel/background color for the UI.

• Call the method `drawARUI()` and you're done!


• A sample code below illustrates that - 

``` swift
let ARH : ARUIHandler = ARUIHandler(nibName: "ExampleUI", delegate: self, scnView: sceneView, arViewWidth: 14.0, arViewDepth: -20.0)
 ARH.panelColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 176/255.0, alpha: 0.8)
 ARH.drawARUI()
 ```
        

#### Note: 
   1) Height of the AR UI is calculated based on provided width and the dimensions of xib/View file.<br />
   
   2) You need to do some trial with `arViewWidth` and `arViewDepth` values as a really huge object might look really small if its far away.<br />
   
   3) The size of the elements in AR are calculated according to the width provided and their actual size in xib/View file relative to size of the xib/View itself.<br />
   
   4) If you have any questions, you can email me :)<br />


## Author

Sandeep Joshi, aw.snjoshi@hotmail.com

## License

ARUI is available under the MIT license. See the LICENSE file for more info.
