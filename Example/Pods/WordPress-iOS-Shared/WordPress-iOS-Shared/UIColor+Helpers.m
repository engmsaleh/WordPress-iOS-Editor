#import "UIColor+Helpers.h"
#import "NSString+HTML.h"

@implementation UIColor (Helpers)

// [UIColor UIColorFromRGBAColorWithRed:10 green:20 blue:30 alpha:0.8]
+ (UIColor *)UIColorFromRGBAColorWithRed: (CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    return [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha:a];
}

// [UIColor UIColorFromRGBColorWithRed:10 green:20 blue:30]
+ (UIColor *)UIColorFromRGBColorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b {
    return [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: 0.5];
}

// [UIColor UIColorFromHex:0xc5c5c5 alpha:0.8];
+ (UIColor *)UIColorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0
                          green:((float)((rgb & 0xFF00) >> 8))/255.0
                           blue:((float)(rgb & 0xFF))/255.0
                          alpha:alpha];
}

// [UIColor UIColorFromHex:0xc5c5c5];
+ (UIColor *)UIColorFromHex:(NSUInteger)rgb {
    return [UIColor UIColorFromHex:rgb alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hex {
    if ([hex length]!=6 && [hex length]!=3)
    {
        return nil;
    }
    
    NSUInteger digits = [hex length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    CGFloat red = [[hex substringWithRange:NSMakeRange(0, digits)] integerValueFromHex]/maxValue;
    CGFloat green = [[hex substringWithRange:NSMakeRange(digits, digits)] integerValueFromHex]/maxValue;
    CGFloat blue = [[hex substringWithRange:NSMakeRange(2*digits, digits)] integerValueFromHex]/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (NSString *)hexString
{
    // Taken from http://stackoverflow.com/questions/8689424/uicolor-to-hexadecimal-web-color
    
    NSString *webColor = nil;
    
    // This method only works for RGB colors
    if (CGColorGetNumberOfComponents(self.CGColor) == 4)
    {
        // Get the red, green and blue components
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        
        // These components range from 0.0 till 1.0 and need to be converted to 0 till 255
        CGFloat red = roundf(components[0] * 255.0);
        CGFloat green = roundf(components[1] * 255.0);
        CGFloat blue = roundf(components[2] * 255.0);
        
        // Convert with %02x (use 02 to always get two chars)
        webColor = [NSString stringWithFormat:@"%02lx%02lx%02lx", (long)red, (long)green, (long)blue];
    }
    
    return webColor;
}

@end
