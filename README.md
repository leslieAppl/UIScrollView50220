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

## PageControl

