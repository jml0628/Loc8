//
//  JTCalendarMenuMonthView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMenuMonthView.h"

@interface JTCalendarMenuMonthView(){
    UILabel *textLabel;
}

@end

@implementation JTCalendarMenuMonthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    {
        textLabel = [UILabel new];
        
        [self addSubview:textLabel];
        
        textLabel.textAlignment = NSTextAlignmentLeft;
        
    }
}

- (void)setMonthIndex:(NSInteger)monthIndex
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
    }

    while(monthIndex <= 0){
        monthIndex += 12;
    }
    
    textLabel.text = [[dateFormatter standaloneMonthSymbols][monthIndex - 1] uppercaseString];
}

- (void)layoutSubviews
{
    textLabel.frame = CGRectMake(50, 0, self.frame.size.width, self.frame.size.height);
    textLabel.textColor = [UIColor colorWithRed:(176.0/255.0) green:(176.0/255.0) blue:(176.0/255.0) alpha:1];
    textLabel.font =  [UIFont fontWithName:@"Proxima Nova Light" size:16.0f];

    // No need to call [super layoutSubviews]
}

- (void)reloadAppearance
{
//    textLabel.textColor = self.calendarManager.calendarAppearance.menuMonthTextColor;
//    textLabel.font = self.calendarManager.calendarAppearance.menuMonthTextFont;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
