//
//  Theme.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import UIKit

protocol Themeable {

    var primaryButtonColor: UIColor { get }

    var primaryButtonDisabledColor: UIColor { get }

    var disabledButtonColor: UIColor { get }

    var darkButtonColor: UIColor { get }

    var primaryButtonTextColor: UIColor { get }

    var primaryButtonDisabledTextColor: UIColor { get }

    var secondaryButtonColor: UIColor { get }

    var secondaryButtonTextColor: UIColor { get }

    var dottedButtonColor: UIColor { get }

    var dottedButtonTextColor: UIColor { get }

    var primaryTextColor: UIColor { get }

    var primaryTextColorV2: UIColor { get }

    var primaryTextColorV3: UIColor { get }

    var primaryTextColorV4: UIColor { get }

    var primaryOnboardingTextColor: UIColor { get }

    var primaryBackgroundColor: UIColor { get }

    var secondaryBackgroundColor: UIColor { get }

    var secondaryBackgroundColorV2: UIColor { get }

    var thirdBackgroundColor: UIColor { get }

    var lightBackgroundColor: UIColor { get }

    var darkBackgroundColor: UIColor { get }

    var primaryOnboardingBackgroundColor: UIColor { get }

    var secondaryOnboardingBackgroundColor: UIColor { get }

    var secondaryTextColor: UIColor { get }

    var tertiaryTextColor: UIColor { get }

    var darkTextColor: UIColor { get }

    var lightTextColor: UIColor { get }

    var darkGreyTextColor: UIColor { get }

    var lightGreyTextColor: UIColor { get }

    var placeholderTextColor: UIColor { get }

    var bluePlaceholderTextColor: UIColor { get }

    var greenTextColor: UIColor { get }

    var footnoteTextColor: UIColor { get }

    var errorColor: UIColor { get }

    var dividerColor: UIColor { get }

    var primaryBorderColor: UIColor { get }

    var lightGreyBorderColor: UIColor { get }

    var bannerBackgroundColor: UIColor { get }

    var navigationBarDividerColor: UIColor { get }

    var tabbarBackgroundColor: UIColor { get }

    var tabbarSelectedIconColor: UIColor { get }

    var tabbarUnselectedIconColor: UIColor { get }

    var tabbarDividerColor: UIColor { get }

    var navigationBarBackgroundColor: UIColor { get }

    var navigationBarTintColor: UIColor { get }

    var navigationBarTextColor: UIColor { get }

    var infoBackgroundColor: UIColor { get }

    var infoBorderColor: UIColor { get }

    var premiumCardPrimaryColor: UIColor { get }

    var premiumCardSecondaryColor: UIColor { get }

    var shadow: UIColor { get }

    var pieChartHoleColor: UIColor { get }

    var dropDownDarkColor: UIColor { get }

    var statusBarStyle: UIStatusBarStyle { get }

    var exchangeCardBorderColor: UIColor { get }

    var bookedTransactionStatusColor: UIColor { get }

    var deliveredTransactionStatusColor: UIColor { get }

    var notDeliveredTransactionStatusColor: UIColor { get }

    var inProcessTransactionStatusColor: UIColor { get }

    var subdetailTextColor: UIColor { get }

    var deepInfoTextColor: UIColor { get }

    var preferencesColor: UIColor { get }

    var disabledOptionColor: UIColor { get }

    var selectedSegmentTextColor: UIColor { get }

    var unselectedSegmentTextColor: UIColor { get }

    var selectedTabPageIndicatorColor: UIColor { get }

    var unselectedTabPageIndicatorColor: UIColor { get }

    var segmentBackgroundColor: UIColor { get }

    var toggleTintColor: UIColor { get }

    var classicCardTextColor: UIColor { get }

    var platinumCardTextColor: UIColor { get }

    var primaryExpandableBottomSheetCapsuleColor: UIColor { get }

    var secondaryExpandableBottomSheetCapsuleColor: UIColor { get }

    var earnBenefitsBackgroundColor: UIColor { get }

    var searchBarBackgroundColor: UIColor { get }

    var flexiPendingAmountsBarBackgroundColor: UIColor { get }

    var iconPrimaryBackgroundColor: UIColor { get }

    var iconSecondaryBackgroundColor: UIColor { get }

    var iconThirdBackgroundColor: UIColor { get }

    var iconPrimaryColor: UIColor { get }

    var iconSecondaryColor: UIColor { get }

    var iconThirdColor: UIColor { get }

    var iconFourthColor: UIColor { get }

    var iconGreyColor: UIColor { get }

    var tagTextColorV1: UIColor { get }
}

extension Themeable {

    var primaryButtonColor: UIColor {
        UIColor(resource: .primaryButton)
    }

    var primaryButtonDisabledColor: UIColor {
        UIColor(resource: .primaryButtonDisabled)
    }

    var secondaryButtonColor: UIColor {
        UIColor(resource: .secondaryButton)
    }

    var dottedButtonColor: UIColor {
        UIColor(resource: .dottedButton)
    }

    var dottedButtonTextColor: UIColor {
        UIColor(resource: .dottedButtonText)
    }

    var disabledButtonColor: UIColor {
        UIColor(resource: .disabledButton)
    }

    var darkButtonColor: UIColor {
        UIColor(resource: .darkButton)
    }

    var primaryButtonTextColor: UIColor {
        UIColor(resource: .primaryButtonText)
    }

    var primaryButtonDisabledTextColor: UIColor {
        UIColor(resource: .primaryButtonDisabledText)
    }

    var secondaryButtonTextColor: UIColor {
        UIColor(resource: .secondaryButtonText)
    }

    var primaryTextColor: UIColor {
        UIColor(resource: .primaryText)
    }

    var primaryTextColorV2: UIColor {
        UIColor(resource: .primaryTextColorV2)
    }

    var primaryTextColorV3: UIColor {
        UIColor(resource: .primaryTextColorV3)
    }

    var primaryTextColorV4: UIColor {
        UIColor(resource: .primaryTextColorV4)
    }

    var primaryOnboardingTextColor: UIColor {
        UIColor(resource: .primaryOnboardingText)
    }

    var secondaryTextColor: UIColor {
        UIColor(resource: .secondaryText)
    }

    var tertiaryTextColor: UIColor {
        UIColor(resource: .tertiaryText)
    }

    var darkTextColor: UIColor {
        UIColor(resource: .darkText)
    }

    var lightTextColor: UIColor {
        UIColor(resource: .lightText)
    }

    var coolDarkGreyTextColor: UIColor {
        UIColor(resource: .coolDarkGreyText)
    }

    var darkGreyTextColor: UIColor {
        UIColor(resource: .darkGreyText)
    }

    var darkSlateGreyTextColor: UIColor {
        UIColor(resource: .darkSlateGreyText)
    }

    var darkSlateBlueGreyTextColor: UIColor {
        UIColor(resource: .darkSlateBlueGreyText)
    }

    var lightGreyTextColor: UIColor {
        UIColor(resource: .lightGreyText)
    }

    var placeholderTextColor: UIColor {
        UIColor(resource: .placeholderText)
    }

    var bluePlaceholderTextColor: UIColor {
        UIColor(resource: .bluePlaceholderText)
    }

    var greenTextColor: UIColor {
        UIColor(resource: .greenText)
    }

    var footnoteTextColor: UIColor {
        UIColor(resource: .footnoteText)
    }

    var primaryBackgroundColor: UIColor {
        UIColor(resource: .primaryBackground)
    }

    var secondaryBackgroundColor: UIColor {
        UIColor(resource: .secondaryBackground)
    }

    var secondaryBackgroundColorV2: UIColor {
        .neutralColorBackgroundV2
    }

    var thirdBackgroundColor: UIColor {
        UIColor(resource: .thirdBackground)
    }

    var lightBackgroundColor: UIColor {
        .neutralColorWhite
    }

    var darkBackgroundColor: UIColor {
        .neutralColorBlack
    }

    var errorColor: UIColor {
        UIColor(resource: .error)
    }

    var confirmColor: UIColor {
        UIColor(resource: .confirm)
    }

    var dividerColor: UIColor {
        UIColor(resource: .divider)
    }

    var lightGreyBorderColor: UIColor {
        UIColor(resource: .lightGreyBorder)
    }

    var primaryBorderColor: UIColor {
        UIColor(resource: .primaryBorder)
    }

    var secondaryBorderColor: UIColor {
        UIColor(resource: .secondaryBorder)
    }

    var infoBackgroundColor: UIColor {
        UIColor(resource: .infoBackground)
    }

    var infoBorderColor: UIColor {
        UIColor(resource: .infoBorder)
    }

    var premiumCardPrimaryColor: UIColor {
        .gradientColorPlatinumDark
    }

    var premiumCardSecondaryColor: UIColor {
        .gradientColorPlatinumLight
    }

    var shadow: UIColor {
        UIColor(resource: .shadow)
    }

    var exchangeCardBorderColor: UIColor {
        .coreColorPrimary40
    }

    var bannerBackgroundColor: UIColor {
        .coreColorPrimary100
    }

    var pieChartHoleColor: UIColor {
        .white
    }

    var dropDownDarkColor: UIColor {
        UIColor(resource: .dropDownDark)
    }

    var bookedTransactionStatusColor: UIColor {
        UIColor(resource: .bookedTransactionStatus)
    }

    var deliveredTransactionStatusColor: UIColor {
        UIColor(resource: .deliveredTransactionStatus)
    }

    var notDeliveredTransactionStatusColor: UIColor {
        .systemColorError
    }

    var inProcessTransactionStatusColor: UIColor {
        .coreColorPrimary100
    }

    var subdetailTextColor: UIColor {
        UIColor(resource: .subdetailText)
    }

    var deepInfoTextColor: UIColor {
        UIColor(resource: .deepInfoText)
    }

    var preferencesColor: UIColor {
        .coreColorPeacock
    }

    var sectiontitleTextColor: UIColor {
        .neutralColorMidtone
    }

    var disabledOptionColor: UIColor {
        UIColor(resource: .disabledOption)
    }

    var selectedSegmentTextColor: UIColor {
        UIColor(resource: .selectedSegmentText)
    }

    var segmentBackgroundColor: UIColor {
        UIColor(resource: .segmentBackground)
    }

    var unselectedSegmentTextColor: UIColor {
        UIColor(resource: .unselectedSegmentText)
    }

    var selectedTabPageIndicatorColor: UIColor {
        UIColor(resource: .currentTabPageIndicator)
    }

    var unselectedTabPageIndicatorColor: UIColor {
        UIColor(resource: .tabPageIndicator)
    }

    var toggleTintColor: UIColor {
        UIColor(resource: .toggleTint)
    }

    var classicCardTextColor: UIColor {
        UIColor(resource: .classicCardText)
    }

    var platinumCardTextColor: UIColor {
        .white
    }

    var primaryExpandableBottomSheetCapsuleColor: UIColor {
        UIColor(resource: .primaryExpandableBottomSheetCapsule)
    }

    var secondaryExpandableBottomSheetCapsuleColor: UIColor {
        UIColor(resource: .secondaryExpandableBottomSheetCapsule)
    }

    var earnBenefitsBackgroundColor: UIColor {
        .coreColorPrimary10
    }

    var searchBarBackgroundColor: UIColor {
        UIColor(resource: .searchBarBackground)
    }

    var pfmTabHeaderTextColor: UIColor {
        .neutralColorLabelDarkGrey
    }

    var flexiPendingAmountsBarBackgroundColor: UIColor {
        UIColor(resource: .flexiPendingAmountsBarBackground)
    }

    var flexiAmountsBackgroundColor: UIColor {
        .coreColorPrimary50
    }

    var appThemeColor: UIColor {
        UIColor(resource: .appThemeAsset)
    }

    var iconPrimaryBackgroundColor: UIColor {
        UIColor(resource: .iconPrimaryBackground)
    }

    var iconSecondaryBackgroundColor: UIColor {
        UIColor(resource: .iconSecondaryBackground)
    }

    var iconThirdBackgroundColor: UIColor {
        UIColor(resource: .iconThirdBackground)
    }

    var iconPrimaryColor: UIColor {
        UIColor(resource: .primaryIcon)
    }

    var iconSecondaryColor: UIColor {
        UIColor(resource: .secondaryIcon)
    }

    var iconThirdColor: UIColor {
        UIColor(resource: .thirdIcon)
    }

    var iconFourthColor: UIColor {
        UIColor(resource: .fourthIcon)
    }

    var iconGreyColor: UIColor {
        UIColor(resource: .iconGrey)
    }

    var tagTextColorV1: UIColor {
        UIColor(resource: .tagText)
    }
}

final class LaunchTheme: Themeable {

    var navigationBarDividerColor: UIColor {
        UIColor(resource: .navigationBarDivider)
    }

    var tabbarBackgroundColor: UIColor {
        UIColor(resource: .barBackground)
    }

    var tabbarSelectedIconColor: UIColor {
        .neutralColorWhite
    }

    var tabbarUnselectedIconColor: UIColor {
        .neutralColorGrey
    }

    var tabbarDividerColor: UIColor {
        UIColor(resource: .divider)
    }

    var navigationBarTintColor: UIColor {
        UIColor(resource: .navigationBarTint)
    }

    var navigationBarTextColor: UIColor {
        UIColor(resource: .navigationBarText)
    }

    var navigationBarBackgroundColor: UIColor {
        UIColor(resource: .navigationBarBackground)
    }

    var primaryBackgroundColor: UIColor {
        UIColor(resource: .primaryBackground)
    }

    var statusBarStyle: UIStatusBarStyle {
        UITraitCollection.current.userInterfaceStyle == .dark ? .darkContent : .lightContent
    }

    var primaryOnboardingBackgroundColor: UIColor {
        UIColor(resource: .primaryOnboardingBackground)
    }

    var secondaryOnboardingBackgroundColor: UIColor {
        UIColor(resource: .secondaryOnboardingBackground)
    }
}
