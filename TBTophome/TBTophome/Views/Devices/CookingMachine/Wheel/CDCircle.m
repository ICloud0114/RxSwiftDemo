/*
 Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kRotationDegrees 90
#import "CDCircle.h"
#import <QuartzCore/QuartzCore.h>
#import "CDCircleGestureRecognizer.h"
#import "CDCircleThumb.h"
#import "CDCircleOverlayView.h"
@implementation CDCircle {
    BOOL layoutFinish;
}
@synthesize circle, recognizer, path, numberOfSegments, separatorStyle, overlayView, separatorColor, ringWidth, circleColor, thumbs, overlay;
@synthesize delegate, dataSource;
@synthesize inertiaeffect;
//Need to add property "NSInteger numberOfThumbs" and add this property to initializer definition, and property "CGFloat ringWidth equal to circle radius - path radius. 

//Circle radius is equal to rect / 2 , path radius is equal to rect1/2.

-(id) initWithFrame:(CGRect)frame numberOfSegments: (NSInteger) nSegments ringWidth:(CGFloat)width {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.inertiaeffect = YES;
        self.recognizer = [[CDCircleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.recognizer];
        self.opaque = NO;
        self.numberOfSegments = nSegments;
        self.separatorStyle = CDCircleThumbsSeparatorBasic;
        self.ringWidth = width;
        self.circleColor = [UIColor whiteColor];
        self.circleBorderColor = [UIColor blackColor];
        self.circlrMargin = 5;
        
        //计算内圆的rect
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(frame) - (2*ringWidth), CGRectGetWidth(frame) - (2*ringWidth));
        
        self.thumbs = [NSMutableArray array];
        for (int i = 0; i < self.numberOfSegments; i++) {
            
            CDCircleThumb * thumb = [[CDCircleThumb alloc] initWithShortCircleRadius:rect1.size.height/2 longRadius:frame.size.height/2 - self.circlrMargin numberOfSegments:self.numberOfSegments];
            thumb.separatorStyle = self.separatorStyle;
            [self.thumbs addObject:thumb];
        }
            }
    return self;
}


-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    layoutFinish = YES;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState (ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    
    [self.circleColor setFill];
    [self.circleBorderColor setStroke];
    circle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 0.5, 0.5)];
    circle.lineWidth = 0.5;
    [circle closePath];
    [circle fill];
    [circle stroke];
    
    
    CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(rect) - (2*ringWidth), CGRectGetWidth(rect) - (2*ringWidth));
    rect1.origin.x = rect.size.width / 2  - rect1.size.width / 2;
    rect1.origin.y = rect.size.height / 2  - rect1.size.height / 2;
    
    
    path = [UIBezierPath bezierPathWithOvalInRect:rect1];
    [self.circleColor setFill];
    [path fill];
    CGContextRestoreGState(ctx);
    
    
    //Drawing Thumbs
    CGFloat fNumberOfSegments = self.numberOfSegments;
    CGFloat perSectionDegrees = 360.f / fNumberOfSegments;
    CGFloat totalRotation = 360.f / fNumberOfSegments;
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    
    
    
    
    CGFloat deltaAngle = 0.0;
    
    for (int i = 0; i < self.numberOfSegments; i++) {
        

        CDCircleThumb * thumb = [self.thumbs objectAtIndex:i];
        thumb.tag = i;
        id icon = [self.dataSource circle:self iconForThumbAtRow:thumb.tag];
        if ([icon isKindOfClass:[NSString class]]) {
            thumb.iconView.title = icon;
        } else {
            thumb.iconView.imageView = icon;
        }
//        thumb.iconView.image = [self.dataSource circle:self iconForThumbAtRow:thumb.tag];

        CGFloat longRadius = rect.size.height / 2.0 - self.circlrMargin;
        CGFloat radius = rect1.size.height/2 + ((longRadius - rect1.size.height/2)/2) - thumb.yydifference;
        CGFloat x = centerPoint.x + (radius * cos(degreesToRadians(perSectionDegrees)));
        CGFloat yi = centerPoint.y + (radius * sin(degreesToRadians(perSectionDegrees)));
        

        
        [thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians((perSectionDegrees + kRotationDegrees)))];
        if (i==0) {
            deltaAngle= degreesToRadians(360 - kRotationDegrees) + atan2(thumb.transform.a, thumb.transform.b);
            [thumb.iconView setIsSelected:YES];
            self.recognizer.currentThumb = thumb;
        }
        
        //set position of the thumb
        thumb.layer.position = CGPointMake(x, yi);
        
        
        perSectionDegrees += totalRotation;
        
         [self addSubview:thumb];
        thumb.iconView.transform = CGAffineTransformMakeRotation(degreesToRadians(-i * (360.0 / numberOfSegments)));
    }
    
    [self setTransform:CGAffineTransformRotate(self.transform,deltaAngle)];
    [self moveToSegmentIndex:self.currentSegmentIndex];
 }

-(void) tapped: (CDCircleGestureRecognizer *) arecognizer{
    if (arecognizer.ended == NO) {
    CGPoint point = [arecognizer locationInView:self];
    if ([path containsPoint:point] == NO) {
        
    [self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];
    }
    }
}

- (void)moveToSegmentIndex:(NSInteger)index {
    if (!layoutFinish) {
        return;
    }
    CDCircleThumb * thumb = [self.thumbs objectAtIndex:index];
    if (thumb == recognizer.currentThumb) { return; }
    [thumb.iconView setIsSelected:YES];
    [recognizer.currentThumb.iconView setIsSelected:NO];
    recognizer.currentThumb = thumb;
//    
//    for (int i = 0; i < self.numberOfSegments; i++) {
//        CDCircleThumb * thumb = [self.thumbs objectAtIndex:i];
//        if (index == i) {
//            [thumb.iconView setIsSelected:YES];
//            recognizer.currentThumb = thumb;
//        } else {
//            [thumb.iconView setIsSelected:NO];
//        }
//    }
}

- (void)setCurrentSegmentIndex:(NSInteger)currentSegmentIndex {
    _currentSegmentIndex = currentSegmentIndex;
    [self moveToSegmentIndex:_currentSegmentIndex];
}

@end
