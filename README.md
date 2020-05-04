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
- Catch page value before calling UIScrollViewDelegate.scrollViewDidScroll() method. Because, rotating the screen led to change to size of scroll view. Mean while automatically to trigger the scrollViewDidScroll() method to distract the value of page property
- reversing scrollWidth and scrollHeight
- Removeing subviews from scroll view
- Organizing the content area in pages
- Scroll to page after resizing the page

## Remove subViews from scroll view
    let subViews = self.scrollView.subviews
    for subview in subViews{
        subview.removeFromSuperview()
    }

## Scroll to page after resizing the page
var frame = mainScroll.frame
frame.origin.x = scrollWidth*CGFloat(page)
mainScroll.scrollRectToVisible(frame, animated: true)

## zoom each page individually
- Scroll Views may be created inside other Scroll Views


