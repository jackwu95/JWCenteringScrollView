//
//  JWCenteringScrollView.m
//  Clashogram
//
//  Created by Jack Wu on 2014-11-05.
//  Copyright (c) 2014 Extreme Innovations. All rights reserved.
//

#import "JWCenteringScrollView.h"

@implementation JWCenteringScrollView {
  NSLayoutConstraint * topConstraint;
  NSLayoutConstraint * leftConstraint;
  NSLayoutConstraint * rightConstraint;
  NSLayoutConstraint * botConstraint;
  
  NSLayoutConstraint * widthConstraint;
  NSLayoutConstraint * heightConstraint;
  
  CGRect previousFrame;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.delegate = self;
  self.decelerationRate = UIScrollViewDecelerationRateFast;
  self.alwaysBounceHorizontal = YES;
  self.alwaysBounceVertical = YES;
  _subviewSize = CGSizeZero;
  
  self.subviewContainer = [[UIView alloc] initWithFrame:self.bounds];
  [self addSubview:self.subviewContainer];
  self.subviewContainer.translatesAutoresizingMaskIntoConstraints = NO;
  
  topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.subviewContainer attribute:NSLayoutAttributeTop multiplier:1 constant:0];
  leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.subviewContainer attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
  rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.subviewContainer attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
  botConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.subviewContainer attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
  
  [self addConstraints:@[topConstraint,leftConstraint,rightConstraint,botConstraint]];
  
  widthConstraint = [NSLayoutConstraint constraintWithItem:self.subviewContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.bounds.size.width];
  heightConstraint = [NSLayoutConstraint constraintWithItem:self.subviewContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.bounds.size.height];
  
  [self.subviewContainer addConstraints:@[widthConstraint,heightConstraint]];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!CGSizeEqualToSize(previousFrame.size, self.frame.size)) {
    [self updateConstraints];
    [self updateZoom];
    previousFrame = self.frame;
  }
}

- (void)updateConstraints {
  [super updateConstraints];
  
  float viewWidth = self.bounds.size.width;
  float viewHeight = self.bounds.size.height;
  
  // center image if it is smaller than screen
  float hPadding = (viewWidth - self.zoomScale * _subviewSize.width) / 2;
  if (hPadding < 0) hPadding = 0;
  
  float vPadding = (viewHeight - self.zoomScale * _subviewSize.height) / 2;
  if (vPadding < 0) vPadding = 0;
  
  leftConstraint.constant = -hPadding;
  rightConstraint.constant = -hPadding;
  
  topConstraint.constant = -vPadding;
  botConstraint.constant = -vPadding;
  
  [self layoutIfNeeded];
}

- (void)setSubviewSize:(CGSize)subviewSize {
  _subviewSize = subviewSize;
  widthConstraint.constant = subviewSize.width;
  heightConstraint.constant = subviewSize.height;
  self.contentSize = subviewSize;
  [self setNeedsUpdateConstraints];
  [self updateConstraintsIfNeeded];
  [self updateZoom];
}

- (void)updateZoom {
  if (CGSizeEqualToSize(CGSizeZero, _subviewSize)) {
    return;
  }
  float minZoom = MIN(self.bounds.size.width / _subviewSize.width,
                      self.bounds.size.height / _subviewSize.height);
  
  self.minimumZoomScale = minZoom;
  self.maximumZoomScale = minZoom * 4;

  self.zoomScale = minZoom;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.subviewContainer;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
  [self setNeedsUpdateConstraints];
  [self updateConstraintsIfNeeded];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [[NSNotificationCenter defaultCenter] postNotificationName:kCenteringScrollViewDidScrollNotification object:self];
}

@end
