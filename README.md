# DeanDevTools

DeanDevTools 封装了iOS快速开发工具

DeanDevTools/FPS 屏幕帧频数

DeanDevTools/CallStack 卡断打印函数调用栈信息

DeanDevTools/ClangTrace 二进制插座缓存程序启动的符号表,加快程序启动速度

整个库集成:
pod 'DeanDevTools'

调试工具组件集：<屏幕帧频数>
pod 'DeanDevTools/FPS'
FLEX定制化集成:
pod 'DeanDevTools/CallStack' < 卡断打印函数调用栈信息>

性能数据采集上报:<二进制插座缓存程序启动的符号表,加快程序启动速度>
pod 'DeanDevTools/ClangTrace'

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DeanDevTools is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DeanDevTools'
```

## Author

muxinjian, muxinjian@huatu.com

## License

DeanDevTools is available under the MIT license. See the LICENSE file for more info.
