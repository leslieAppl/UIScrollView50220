# UIScrollView

## Cauculating the minimum and maximum scales to zoom out enough to see the whole image on the screen.
    let imgWidth = imageView.frame.size.width
    let imgHeight = imageView.frame.size.height
    let scrollWidth = mainScroll.frame.size.width
    let scrollHeight = mainScroll.frame.size.height

    let minScale = min(scrollWidth/imgWidth, scrollHeight/imgHeight)
    let maxScale = max(minScale*10, 1)
    mainScroll.minimumZoomScale = minScale
    mainScroll.maximumZoomScale = maxScale

## To force the system to update the layout value when we need them
    view.setNeedsLayout()
    view.layoutIfNeeded()

## isPageEnabled property
- Organizing the content area in pages
    
## UIPageControl class
- Calculating the page

## reset the page size when rotating the screen
    extension P1 {
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            
            
            if UIDevice.current.orientation.isLandscape {
                print("isLandscape")
    //Switching width and height after rotating to landscape mode
                let scrollWidth = self.scrollHeight!
                let scrollHeight = self.scrollWidth!
                
    //Organizing the content area in pages
                var posX: CGFloat = 0
                
                for img in images {
                    
                    imageView = UIImageView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
                    imageView.image = UIImage(named: img)
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    
                    mainScroll.addSubview(imageView)
                    mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(images.count), height: scrollHeight)
                    
                    posX = posX + scrollWidth
                }
                
    //Scroll to page after resizing the page
                var frame = mainScroll.frame
                frame.origin.x = scrollWidth*CGFloat(page)
                mainScroll.scrollRectToVisible(frame, animated: true)
                
            } else {
                print("isPortrait")
                //Switching width and height after rotating to landscape mode
                let scrollWidth = self.scrollWidth!
                let scrollHeight = self.scrollHeight!
                
                //Organizing the content area in pages
                var posX: CGFloat = 0
                
                for img in images {
                    
                    imageView = UIImageView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
                    imageView.image = UIImage(named: img)
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    
                    mainScroll.addSubview(imageView)
                    mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(images.count), height: scrollHeight)
                    
                    posX = posX + scrollWidth
                }

    //Scroll to page after resizing the page
                var frame = mainScroll.frame
                frame.origin.x = scrollWidth*CGFloat(page)
                mainScroll.scrollRectToVisible(frame, animated: true)
            }
            
        }
        
    }

## Scroll to page after resizing the page
var frame = mainScroll.frame
frame.origin.x = scrollWidth*CGFloat(page)
mainScroll.scrollRectToVisible(frame, animated: true)

## zoom each page individually
- Scroll Views may be created inside other Scroll Views



