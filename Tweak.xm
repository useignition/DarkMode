#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

@interface _UIBarBackground: UIView
@end

@interface _UINavigationBarContentView: UIView
@end

@interface TFNCustomTabBar: UIView
@end

@interface UISearchBarTextField: UITextField
@end

@interface UIStatusBar
- (void)setTintColor:(id)color;
+ (UIStatusBarStyle)defaultStatusBarStyle;
- (id)activeTintColor;
@end

static inline UIView* UIViewWithColor(UIColor *color) {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

%hook UILabel 

 - (void)layoutSubviews {
    %orig();
    self.textColor = [UIColor whiteColor];
 }

%end

%hook UISwitch
    - (void)layoutSubviews {
        %orig();
        [self setOnTintColor:[UIColor colorWithRed:0.45 green:0.36 blue:0.87 alpha:1.0]];
    }

%end

%hook UITableViewCellContentView

    - (void)layoutSubviews {
        %orig();
        [self setBackgroundColor:[UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0]];
    }

%end

%hook UIStatusBar
    -(void)layoutSubviews{
        %orig();
        self.tintColor = [UIColor whiteColor];
    }

    - (id)activeTintColor
    {
        return [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    }

    - (void)setTintColor:(id)arg1
    {
        %orig([self activeTintColor]);          
    }

    // + (UIStatusBarStyle)defaultStatusBarStyle {
    //     return UIStatusBarStyleLightContent;
    // }

    // - (void)_setStyle:(id) {
    //     %orig(UIStatusBarStyleLightContent);
    // }
    // - (void)_setStyle:(id) animation:(int) {
    //     return UIStatusBarStyleLightContent;
    // }
%end

%hook UIApplication
- (void)setStatusBarStyle:(int)arg1 animated:(BOOL)arg2
{
    %orig(UIStatusBarStyleLightContent,arg2);
}
- (int)statusBarStyle
{
   return 1;
}

- (void)setStatusBarStyle:(int)arg1 duration:(double)arg2
{
   %orig(UIStatusBarStyleLightContent,arg2);
}
%end

%hook UINavigationController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    %orig;
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    self.toolbar.barTintColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
    self.toolbar.barStyle = UIBarStyleBlack;
    [self.navigationBar setTitleTextAttributes:titleAttributes];

    if (@available(iOS 11.0, *)) {
        [self.navigationBar setLargeTitleTextAttributes:titleAttributes];
    }

    [self.navigationBar setBarStyle:UIBarStyleBlack];

    [self setNeedsStatusBarAppearanceUpdate];
}
%end

%hook UITableViewController
-(void) viewDidLoad {
    %orig;
    self.view.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
}

- (void)reloadData {
    %orig;
    self.view.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = [UIColor whiteColor];
        }
    }
}

%end

%hook _UIBarBackground
-(void)layoutSubviews {
    %orig;
    UIVisualEffectView* _backgroundEffectView = MSHookIvar<UIVisualEffectView *>(self, "_backgroundEffectView");
    _backgroundEffectView.hidden = NO;
    self.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
}
%end

%hook _UINavigationBarContentView
-(void)layoutSubviews {
    %orig;
    UIVisualEffectView* _backgroundEffectView = MSHookIvar<UIVisualEffectView *>(self, "_backgroundEffectView");
    _backgroundEffectView.hidden = NO;
    self.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
}
%end

%hook UITableView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
%end

%hook UITableViewCell
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0];
    self.textLabel.textColor = [UIColor whiteColor];

    UIColor *selectedColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
    [self setSelectedBackgroundView: UIViewWithColor(selectedColor)];
}
%end

// %hook UIView
// -(void)layoutSubviews {
//     %orig;
//     self.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0];
//     self.tintColor = [UIColor whiteColor];
// }
// %end

%hook UITableViewHeaderFooterView
-(void)layoutSubviews {
    %orig;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
}
%end

%hook UISearchBar
-(void)layoutSubviews {
    %orig;
    UISearchBarTextField *textField = MSHookIvar<UISearchBarTextField *>(self, "_searchField");
    textField.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.0];

    UIView *bg = MSHookIvar<UIView *>(self, "_background");
    bg.hidden = YES;
}
-(UITextField *)searchField {
    UITextField* field = %orig;
    field.textColor = [UIColor whiteColor];
    return field;
}
%end

%hook UITabBar
- (void)layoutSubviews {
    %orig;
    self.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
}
%end

// %hook NSAttributedString

// - (void)layoutSubviews {
//     %orig;
//     NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
//     self.textColor = [UIColor whiteColor];
// }

// %end

%hook TFNCustomTabBar
- (void)layoutSubviews {
    %orig;
    self.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1.0];
}
%end

%hook UITextView
-(void)layoutSubviews {
    %orig;
    self.keyboardAppearance = UIKeyboardAppearanceDark;
}
%end