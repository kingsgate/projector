//
//  MediaSwitchTableViewCell.m
//  Projector
//
//  Created by Peter Fokos on 10/13/14.
//

#import "MediaSwitchTableViewCell.h"

#define CELL_HEIGHT 50

@implementation MediaSwitchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeDefaults];
    }
    return self;
}

- (void)initializeDefaults {
    [super initializeDefaults];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor mediaSelectedCellBackgroundColor];
    self.clipsToBounds = YES;
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor mediaSelectedCellSelectedColor];
    self.selectedBackgroundView = selectedView;
}

#pragma mark - Layout
#pragma mark -

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    [self.contentView removeConstraints:self.constraints];
    
    [super updateConstraints];
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *metrics = @{@"buffer": @(9)};
    
    NSDictionary *views = @{
                            @"title": self.titleLabel,
                            @"sub_title": self.subTitleLabel,
                            @"switch": self.mediaSwitch,
                            };
    
    for (NSString *format in @[
                               @"H:|-buffer-[title]-[switch]-buffer-|",
                               ]) {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [array addObjectsFromArray:constraints];
    }
    [self.contentView addConstraints:array];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.mediaSwitch
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0.0]];
    

    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.subTitleLabel
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.subTitleLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    CGFloat titleYAdj = 0.0;
    CGFloat subTitileYAdj = 0.0;
    
    if ([self.subTitleLabel.text length] > 0) {
        titleYAdj = -8.0;
        subTitileYAdj = 8.0;
    }
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:titleYAdj]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.subTitleLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:subTitileYAdj]];
    
    
    [self.contentView updateConstraintsIfNeeded];
}

+ (CGFloat)heightForCell {
    return CELL_HEIGHT;
}


#pragma mark - Lazy loaders
#pragma mark -

- (PCOLabel *)titleLabel {
    if (!_titleLabel) {
        PCOLabel *label = [PCOLabel newAutoLayoutView];
        label.font = [UIFont defaultFontOfSize_14];
        label.textColor = [UIColor mediaSelectedCellTitleColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.backgroundColor = [UIColor clearColor];
        _titleLabel = label;
        [self.contentView addSubview:label];
    }
    return _titleLabel;
}

- (PCOLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        PCOLabel *label = [PCOLabel newAutoLayoutView];
        label.font = [UIFont defaultFontOfSize:13];
        label.textColor = [UIColor mediaSelectedCellSubTitleColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.backgroundColor = [UIColor clearColor];
        _subTitleLabel = label;
        [self.contentView addSubview:label];
    }
    return _subTitleLabel;
}

- (PROSwitch *)mediaSwitch {
    if (!_mediaSwitch) {
        PROSwitch *aSwitch = [PROSwitch newAutoLayoutView];
        _mediaSwitch = aSwitch;
        [self.contentView addSubview:aSwitch];
    }
    return _mediaSwitch;
}

@end

NSString *const kMediaSwitchTableviewCellIdentifier = @"kMediaSwitchTableviewCellIdentifier";


