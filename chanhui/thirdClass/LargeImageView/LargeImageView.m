//
//  LargeImageView.m
//  lisong
//
//  Created by 李松 on 15/10/16.
//  Copyright © 2015年 lisong. All rights reserved.
//

#import "LargeImageView.h"
//#import "MBProgressHUD.h"
#import "LCProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIView+XBExtension.h"
#import "SDWebImageManager.h"

#define KeyWindow [UIApplication sharedApplication].keyWindow

@interface LargeImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView       *backView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIImageView  *animImageView;

@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) UIImage *image;

@end

@implementation LargeImageView

- (instancetype)initWithView:(UIView *)view image:(UIImage *)image imageUrl:(NSString *)url{
    
    if (self = [super initWithFrame:KeyWindow.bounds]) {
        
        self.startFrame = [KeyWindow convertRect:view.frame fromView:view.superview];
        
        self.backView.alpha = 0;
        [self addSubview:self.backView];
        
        [self addSubview:self.scrollView];
        
        [self.scrollView addSubview:self.imageView];
        
        [self addSubview:self.animImageView];
        
        if (image) {
            self.image = image;
            self.imageView.image = image;
            [self configUIWithImage:image];
        }else {
            
            if (![[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:url]]) {
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//                hud.mode = MBProgressHUDModeIndeterminate;
//                hud.color = [UIColor clearColor];
//                [hud show:YES];
                [LCProgressHUD showLoading:nil];
                
            }
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                [MBProgressHUD hideAllHUDsForView:self animated:YES];
                [LCProgressHUD hide];
                if (!error) {
                    self.image = image;
                    [self configUIWithImage:image];

                    self.imageView.alpha = 0;
                    [UIView animateWithDuration:0.2 animations:^{
                        self.imageView.alpha = 1;
                    }];
                }
            }];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)configUIWithImage:(UIImage *)image {
    CGRect rect = CGRectZero;
    CGFloat ratio = image.size.width / image.size.height;
    if (image.size.width / image.size.height > self.width / self.height) {
        rect.size.width = self.width;
        rect.size.height = rect.size.width / ratio;
    }else {
        rect.size.height = self.height;
        rect.size.width = rect.size.height * ratio;
    }
    
    self.imageView.frame = rect;
    self.imageView.center = self.scrollView.center;
    self.scrollView.contentSize = self.imageView.frame.size;
}

- (void)show {
    [KeyWindow addSubview:self];
    
    self.animImageView.image = self.image;

    CGRect frame = self.imageView.frame;
    self.imageView.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 1;
        self.animImageView.frame = frame;
    } completion:^(BOOL finished) {
        self.imageView.hidden = NO;
        self.animImageView.hidden = YES;
    }];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerContent];
    if (scrollView.zoomScale <= 1) {
        scrollView.bouncesZoom = NO;
    }else {
        scrollView.bouncesZoom = YES;
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (scrollView.zoomScale < 1) {
        [self handleTap:nil];
    }
}

- (void)centerContent {
    CGFloat top = 0, left = 0;
    if (self.scrollView.contentSize.width < self.scrollView.bounds.size.width) {
        left = (self.scrollView.bounds.size.width - self.scrollView.contentSize.width) * 0.5f;
    }
    
    if (self.scrollView.contentSize.height < self.scrollView.bounds.size.height) {
        top = (self.scrollView.bounds.size.height - self.scrollView.contentSize.height) * 0.5f;
    }
    
    self.scrollView.contentInset = UIEdgeInsetsMake(top, left, top, left);
    self.imageView.center = CGPointMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2);
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (self.imageView.width > self.width || self.imageView.height > self.height) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
            self.imageView.center = self.scrollView.center;
            self.scrollView.contentSize = self.imageView.frame.size;
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }else {
        [UIView animateWithDuration:0.4 animations:^{
            self.backView.alpha = 0;
            self.imageView.alpha = 0;
            self.scrollView.frame = self.startFrame;
            self.imageView.frame = self.scrollView.bounds;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - Getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.bounces = YES;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 3;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIImageView *)animImageView {
    if (!_animImageView) {
        _animImageView = [[UIImageView alloc] initWithFrame:self.startFrame];
    }
    return _animImageView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
    }
    return _backView;
}

@end
