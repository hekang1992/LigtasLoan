

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    UIKIT_EXTERN NSNotificationName const WLUnitFieldDidBecomeFirstResponderNotification;
    UIKIT_EXTERN NSNotificationName const WLUnitFieldDidResignFirstResponderNotification;
#else
    UIKIT_EXTERN NSString *const WLUnitFieldDidBecomeFirstResponderNotification;
    UIKIT_EXTERN NSString *const WLUnitFieldDidResignFirstResponderNotification;
#endif


typedef NS_ENUM(NSUInteger, WLUnitFieldStyle) {
    WLUnitFieldStyleBorder,
    WLUnitFieldStyleUnderline
};

@protocol WLUnitFieldDelegate;

IB_DESIGNABLE
@interface WLUnitField : UIControl <UITextInput>

@property (nullable, nonatomic, weak) id<WLUnitFieldDelegate> delegate;

/**
 */
@property (nullable, nonatomic, copy) IBInspectable NSString *text;
@property(null_unspecified,nonatomic,copy) IBInspectable UITextContentType textContentType NS_AVAILABLE_IOS(10_0); // default is nil

#if TARGET_INTERFACE_BUILDER
/**

 */
@property (nonatomic, assign) IBInspectable NSUInteger inputUnitCount;

/**
 */
@property (nonatomic, assign) IBInspectable NSUInteger style;
#else
@property (nonatomic, assign, readonly) NSUInteger inputUnitCount;
@property (nonatomic, assign, readonly) WLUnitFieldStyle style;
#endif


/**
    ┌┈┈┈┬┈┈┈┬┈┈┈┬┈┈┈┐
    ┆ 1 ┆ 2 ┆ 3 ┆ 4 ┆       unitSpace is 0.
    └┈┈┈┴┈┈┈┴┈┈┈┴┈┈┈┘
    ┌┈┈┈┐┌┈┈┈┐┌┈┈┈┐┌┈┈┈┐
    ┆ 1 ┆┆ 2 ┆┆ 3 ┆┆ 4 ┆    unitSpace is 6
    └┈┈┈┘└┈┈┈┘└┈┈┈┘└┈┈┈┘
 */
@property (nonatomic, assign) IBInspectable NSUInteger unitSpace;

/**
 
    ╭┈┈┈╮╭┈┈┈╮╭┈┈┈╮╭┈┈┈╮
    ┆ 1 ┆┆ 2 ┆┆ 3 ┆┆ 4 ┆    unitSpace is 6, borderRadius is 4.
    ╰┈┈┈╯╰┈┈┈╯╰┈┈┈╯╰┈┈┈╯
    ╭┈┈┈┬┈┈┈┬┈┈┈┬┈┈┈╮
    ┆ 1 ┆ 2 ┆ 3 ┆ 4 ┆       unitSpace is 0, borderRadius is 4.
    ╰┈┈┈┴┈┈┈┴┈┈┈┴┈┈┈╯
 */
@property (nonatomic, assign) IBInspectable CGFloat borderRadius;

/**
 
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 
 */
@property (nonatomic, strong) IBInspectable UIFont *textFont;

/**
 
 */
@property (null_resettable, nonatomic, strong) IBInspectable UIColor *textColor;

@property (null_resettable, nonatomic, strong) IBInspectable UIColor *tintColor;

/**

 */
@property (nullable, nonatomic, strong) IBInspectable UIColor *trackTintColor;

/**
 */
@property (nullable, nonatomic, strong) IBInspectable UIColor *cursorColor;

/**
 */
@property (nonatomic, assign) IBInspectable BOOL autoResignFirstResponderWhenInputFinished;

/**
 */
@property (nonatomic, assign) IBInspectable CGSize unitSize;

- (instancetype)initWithInputUnitCount:(NSUInteger)count;
- (instancetype)initWithStyle:(WLUnitFieldStyle)style inputUnitCount:(NSUInteger)count;

@end



@protocol WLUnitFieldDelegate <UITextFieldDelegate>

@optional
- (BOOL)unitField:(WLUnitField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
