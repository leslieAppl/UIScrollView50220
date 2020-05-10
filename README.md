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

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth = mainScroll.frame.size.width
            let getPage = round(mainScroll.contentOffset.x/pageWidth)
            let currentPage = Int(getPage)
            page = currentPage
            pageCounter.currentPage = page
        }


## reset the page size when rotating the screen
- Catch page value before calling UIScrollViewDelegate.scrollViewDidScroll() method. Because, rotating the screen led to change to size of scroll view. Mean while automatically to trigger the scrollViewDidScroll() method to distract the value of page property
- reversing scrollWidth and scrollHeight
- Removeing subviews from scroll view

        let subViews = mainScroll.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }

- Organizing the content area in pages

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

- Scroll to page after resizing the page

        let x = scrollWidth*CGFloat(page)
        let offset = CGPoint(x: x, y: 0)
        mainScroll.setContentOffset(offset, animated: true)


## zoom each page individually
- Scroll Views may be created inside other Scroll Views

## Adapting the content area to a new orientation

