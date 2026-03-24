# Impression-Level Ad Revenue

Impression-Level Ad Revenue (ILAR) lets you estimate ad revenue on the client side at the impression level, enabling decisions such as whether to show an ad based on expected value.

This document is based on:

- [Google Mobile Ads SDK Android Documentation](https://developers.google.com/admob/android/impression-level-ad-revenue)

## Prerequisites
- Complete the [Get started guide](../README.md)

## Overview

When an ad is successfully loaded, you can get notified with estimated revenue data via the `on_ad_paid` callback. The callback receives an `AdValue` object containing:

| Property | Type | Description |
|---|---|---|
| `value_micros` | `int` | Estimated revenue in micro-units of the currency |
| `currency_code` | `String` | ISO 4217 currency code (e.g. `"USD"`) |
| `precision_type` | `int` | Precision of the revenue estimate (see below) |

### Precision Types

| Value | Name | Description |
|---|---|---|
| `0` | `UNKNOWN` | An unknown precision type |
| `1` | `ESTIMATED` | Estimated from aggregated campaign data |
| `2` | `PUBLISHER_PROVIDED` | The publisher has provided the CPM |
| `3` | `PRECISE` | Mediation or bidding ad event with exact value |

## Supported Ad Formats

`on_ad_paid` is available for all ad formats:

- App Open
- Banner (`AdView`)
- Interstitial
- Rewarded
- Rewarded Interstitial
- Native Overlay

## Usage

Set the `on_ad_paid` callback **before** loading the ad. Below are examples for each format.

### Interstitial

=== "GDScript"

    ```gdscript
    var _interstitial_ad: InterstitialAd

    func _load_interstitial() -> void:
        var ad_unit_id := "ca-app-pub-3940256099942544/1033173712" if OS.get_name() == "Android" \
            else "ca-app-pub-3940256099942544/4411468910"
        InterstitialAdLoader.new().load(ad_unit_id, AdRequest.new(), func(interstitial_ad: InterstitialAd, _error):
            _interstitial_ad = interstitial_ad
            _interstitial_ad.on_ad_paid = func(ad_value: AdValue) -> void:
                print("Interstitial paid: %d %s (precision: %d)" % [
                    ad_value.value_micros, ad_value.currency_code, ad_value.precision_type
                ])
        )
    ```

=== "C#"

    ```csharp linenums="1"
    using PoingStudios.AdMob.Api;
    using PoingStudios.AdMob.Api.Core;

    private InterstitialAd _interstitialAd;

    private void LoadInterstitial()
    {
        string adUnitId = OS.GetName() == "Android"
            ? "ca-app-pub-3940256099942544/1033173712"
            : "ca-app-pub-3940256099942544/4411468910";

        InterstitialAdLoader.Load(adUnitId, new AdRequest(), (interstitialAd, error) =>
        {
            _interstitialAd = interstitialAd;
            _interstitialAd.OnAdPaid += HandleAdPaidEvent;
        });
    }

    private void HandleAdPaidEvent(AdValue adValue)
    {
        GD.Print($"Interstitial paid: {adValue.ValueMicros} {adValue.CurrencyCode} (precision: {adValue.PrecisionType})");
    }
    ```

### Rewarded

=== "GDScript"

    ```gdscript
    var _rewarded_ad: RewardedAd

    func _load_rewarded() -> void:
        var ad_unit_id := "ca-app-pub-3940256099942544/5224354917" if OS.get_name() == "Android" \
            else "ca-app-pub-3940256099942544/1712485313"
        RewardedAdLoader.new().load(ad_unit_id, AdRequest.new(), func(rewarded_ad: RewardedAd, _error):
            _rewarded_ad = rewarded_ad
            _rewarded_ad.on_ad_paid = func(ad_value: AdValue) -> void:
                print("Rewarded paid: %d %s" % [ad_value.value_micros, ad_value.currency_code])
        )
    ```

=== "C#"

    ```csharp linenums="1"
    private RewardedAd _rewardedAd;

    private void LoadRewarded()
    {
        string adUnitId = OS.GetName() == "Android"
            ? "ca-app-pub-3940256099942544/5224354917"
            : "ca-app-pub-3940256099942544/1712485313";

        RewardedAdLoader.Load(adUnitId, new AdRequest(), (rewardedAd, error) =>
        {
            _rewardedAd = rewardedAd;
            _rewardedAd.OnAdPaid += adValue =>
                GD.Print($"Rewarded paid: {adValue.ValueMicros} {adValue.CurrencyCode}");
        });
    }
    ```

### Rewarded Interstitial

=== "GDScript"

    ```gdscript
    var _rewarded_interstitial_ad: RewardedInterstitialAd

    func _load_rewarded_interstitial() -> void:
        var ad_unit_id := "ca-app-pub-3940256099942544/5354046379" if OS.get_name() == "Android" \
            else "ca-app-pub-3940256099942544/6978759866"
        RewardedInterstitialAdLoader.new().load(ad_unit_id, AdRequest.new(), func(ad: RewardedInterstitialAd, _error):
            _rewarded_interstitial_ad = ad
            _rewarded_interstitial_ad.on_ad_paid = func(ad_value: AdValue) -> void:
                print("RewardedInterstitial paid: %d %s" % [ad_value.value_micros, ad_value.currency_code])
        )
    ```

=== "C#"

    ```csharp linenums="1"
    private RewardedInterstitialAd _rewardedInterstitialAd;

    private void LoadRewardedInterstitial()
    {
        string adUnitId = OS.GetName() == "Android"
            ? "ca-app-pub-3940256099942544/5354046379"
            : "ca-app-pub-3940256099942544/6978759866";

        RewardedInterstitialAdLoader.Load(adUnitId, new AdRequest(), (ad, error) =>
        {
            _rewardedInterstitialAd = ad;
            _rewardedInterstitialAd.OnAdPaid += adValue =>
                GD.Print($"RewardedInterstitial paid: {adValue.ValueMicros} {adValue.CurrencyCode}");
        });
    }
    ```

### Banner (AdView)

=== "GDScript"

    ```gdscript
    var _ad_view: AdView

    func _load_banner() -> void:
        var ad_unit_id := "ca-app-pub-3940256099942544/6300978111" if OS.get_name() == "Android" \
            else "ca-app-pub-3940256099942544/2934735716"
        _ad_view = AdView.new(ad_unit_id, AdSize.BANNER, AdPosition.new(AdPosition.Values.BOTTOM))
        _ad_view.on_ad_paid = func(ad_value: AdValue) -> void:
            print("Banner paid: %d %s" % [ad_value.value_micros, ad_value.currency_code])
        _ad_view.load_ad(AdRequest.new())
    ```

=== "C#"

    ```csharp linenums="1"
    private AdView _adView;

    private void LoadBanner()
    {
        string adUnitId = OS.GetName() == "Android"
            ? "ca-app-pub-3940256099942544/6300978111"
            : "ca-app-pub-3940256099942544/2934735716";

        _adView = new AdView(adUnitId, AdSize.Banner, new AdPosition(AdPosition.Values.Bottom));
        _adView.OnAdPaid += adValue =>
            GD.Print($"Banner paid: {adValue.ValueMicros} {adValue.CurrencyCode}");
        _adView.LoadAd(new AdRequest());
    }
    ```

### App Open

=== "GDScript"

    ```gdscript
    func _on_app_open_ad_loaded(app_open_ad: AppOpenAd) -> void:
        app_open_ad.on_ad_paid = func(ad_value: AdValue) -> void:
            print("AppOpen paid: %d %s" % [ad_value.value_micros, ad_value.currency_code])
    ```

=== "C#"

    ```csharp linenums="1"
    private void OnAppOpenAdLoaded(AppOpenAd appOpenAd, LoadAdError error)
    {
        appOpenAd.OnAdPaid += adValue =>
            GD.Print($"AppOpen paid: {adValue.ValueMicros} {adValue.CurrencyCode}");
    }
    ```

### Native Overlay

=== "GDScript"

    ```gdscript
    var _native_ad: NativeOverlayAd

    func _load_native() -> void:
        var ad_unit_id := "ca-app-pub-3940256099942544/2247696110" if OS.get_name() == "Android" \
            else "ca-app-pub-3940256099942544/3986624511"
        _native_ad = NativeOverlayAd.new()
        _native_ad.on_ad_paid = func(ad_value: AdValue) -> void:
            print("Native paid: %d %s" % [ad_value.value_micros, ad_value.currency_code])
        _native_ad.load(ad_unit_id, AdRequest.new())
    ```

=== "C#"

    ```csharp linenums="1"
    private void LoadNative()
    {
        string adUnitId = OS.GetName() == "Android"
            ? "ca-app-pub-3940256099942544/2247696110"
            : "ca-app-pub-3940256099942544/3986624511";

        NativeOverlayAd.Load(adUnitId, new AdRequest(), new NativeAdOptions(), (nativeAd, error) =>
        {
            nativeAd.OnAdPaid += adValue =>
                GD.Print($"Native paid: {adValue.ValueMicros} {adValue.CurrencyCode}");
        });
    }
    ```

## AdValue Reference

| GDScript | C# | Type | Description |
|---|---|---|---|
| `ad_value.value_micros` | `adValue.ValueMicros` | `int` / `long` | Revenue in micros (divide by 1,000,000 for actual value) |
| `ad_value.currency_code` | `adValue.CurrencyCode` | `String` | ISO 4217 currency code |
| `ad_value.precision_type` | `adValue.PrecisionType` | `int` | Accuracy of the estimate |
