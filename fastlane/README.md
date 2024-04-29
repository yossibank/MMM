fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

環境変数

テスト実行

### ios make_development_certificates

```sh
[bundle exec] fastlane ios make_development_certificates
```

開発者用証明書作成・更新

### ios make_adhoc_certificates

```sh
[bundle exec] fastlane ios make_adhoc_certificates
```

検証用証明書作成・更新

### ios make_appstore_certificates

```sh
[bundle exec] fastlane ios make_appstore_certificates
```

本番用証明書作成・更新

### ios retrieve_development_certificates

```sh
[bundle exec] fastlane ios retrieve_development_certificates
```

開発者用証明書取得

### ios setting_adhoc_code_signing

```sh
[bundle exec] fastlane ios setting_adhoc_code_signing
```

検証用 Code Signing 設定

### ios setting_appstore_code_signing

```sh
[bundle exec] fastlane ios setting_appstore_code_signing
```

本番用 Code Signing 設定

### ios output_adhoc_ipa

```sh
[bundle exec] fastlane ios output_adhoc_ipa
```

検証用 ipa 出力

### ios output_appstore_ipa

```sh
[bundle exec] fastlane ios output_appstore_ipa
```

本番用 ipa 出力

### ios upload_adhoc_deploygate

```sh
[bundle exec] fastlane ios upload_adhoc_deploygate
```

検証用アプリを Deploygate へアップロード

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
