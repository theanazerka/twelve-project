# Twelve

[Русская версия](README_RU.md)

Twelve is an unofficial Telegram client for iOS 6, based on the official Telegram for iOS source code. The project is internally named **Twelvium**, while the application itself is called **Twelve**.

The goal of the project is to keep Telegram usable on legacy Apple devices and provide an optional interface inspired by the original iOS 6 version of Telegram.

> This project is not affiliated with or endorsed by Telegram Messenger.

## Features

- Support for iOS 6.0 and later
- iPhone and iPad layouts
- Optional classic iOS 6 appearance
- Telegram chats, groups and channels
- Media, stickers and voice messages
- Compatibility fixes for the current Telegram infrastructure
- Interface and assets adapted for legacy devices

## Project status

Twelve is a work in progress. Some modern Telegram features may be unavailable or unstable because the client is based on a legacy codebase and runs on an operating system released in 2012.

Bug reports and tested fixes are welcome.

## Building

### Requirements

- macOS with a compatible version of Xcode
- iOS 6.1 SDK or another toolchain capable of targeting iOS 6
- Your own Telegram API ID and API hash
- An Apple signing identity for installation on a physical device

### Steps

1. Clone the repository, including its submodules:

   ```bash
   git clone --recursive https://github.com/theanazerka/twelve-project.git
   cd twelve-project
   ```

2. Create a local configuration file:

   ```bash
   cp config.h.example config.h
   ```

3. Add your own Telegram API credentials to `config.h`.

4. Open `Telegram.xcworkspace` in Xcode.

5. Select the `Telegraph` scheme and configure your bundle identifier and signing settings.

6. Build for an iOS device or simulator.

Do not publish `config.h`, signing certificates, provisioning profiles or other private credentials.

## IPA packaging

After Xcode produces `Telegram.app`, an unsigned IPA can be packaged with:

```bash
mkdir -p Payload
cp -R /path/to/Telegram.app Payload/
zip -r Twelve.ipa Payload
```

Signing and installation are handled separately.

## Credits

- Telegram — original Telegram for iOS source code
- Everyone who tests Twelve and reports bugs

## License

Twelve is distributed under the [GNU General Public License v2.0 or later](LICENSE), consistently with the original Telegram for iOS code.

Copyright © 2026 [theanazerka](https://github.com/theanazerka) for the original Twelve/Twelvium modifications and project assets.

Forks and redistributed copies must preserve the copyright notices, the GPL license and the attribution contained in [NOTICE](NOTICE):

> Based on Twelve by theanazerka — https://github.com/theanazerka/twelve-project

Third-party components remain subject to their respective licenses.
