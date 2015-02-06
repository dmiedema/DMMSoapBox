# DMMSoapBox

[![Build Status](https://travis-ci.org/dmiedema/DMMSoapBox.svg)](https://travis-ci.org/dmiedema/DMMSoapBox)

[![Version](https://img.shields.io/cocoapods/v/DMMSoapBox.svg?style=flat)](http://cocoadocs.org/docsets/DMMSoapBox)
[![License](https://img.shields.io/cocoapods/l/DMMSoapBox.svg?style=flat)](http://cocoadocs.org/docsets/DMMSoapBox)
[![Platform](https://img.shields.io/cocoapods/p/DMMSoapBox.svg?style=flat)](http://cocoadocs.org/docsets/DMMSoapBox)

### What?

A Soapbox to announce whatever you want from. 
Based off [panic's idea](https://www.panic.com/blog/the-2014-panic-report/) for 
being able to announce stuff one time.

### Why?

Sometimes you just need to announce something. For example:
- New app
- Big update that is a new app in the store (prompt > prompt2, tweetbot > tweetbot3)
- Reminding your users you love them

## Usage

### Downloader

Either register a url for the soapbox to check

```objc
[DMMSoapBoxDownloader registerURLForSoapboxCheck:[NSURL urlWithString:@"https://soapb.ox/check.plist"]]
```

And check for an announcement when you want to in your application

```objc
[DMMSoapBoxDownloader checkForAnnoucementsWithCompletion:^(NSDictionary *defaults, NSError *error){
  // We've downloaded stuff
  // Present the soapbox if we want. (we probably want to)
}];
```

**OR** just check a URL.

```objc
[DMMSoapBoxDownloader downloadAnnoucementsFromURL:[NSURL urlWithString:@"https://soapb.ox/check.plist"] complete:^(NSDictionary *defaults, NSError *error) {
  if (defaults && !error) {
    NSDictionary *presenterOptions = DMMDefaultsToOptionsDictionary(defaults);
    NSURL *url = [NSURL urlWithString:presenterOptions[kDMMSoapBoxLatestAnnouncementURLKey]];

    DMMSoapBoxPresenterViewController *soapbox = [DMMSoapBoxPresenterViewController presentationControllerWithURL:url options:presenterOptions];

    [self presentViewController:soapbox animated:YES completion:nil];
  }
}];
```

### Server

The soapbox requires a server to give it any announcements it needs to show.

Currently the soapbox relies on [GroundControl](https://github.com/mattt/GroundControl) to download the plist

To run the demo server run

(You may need to run `cd server && bundle install`)

`$ ruby server/config.ru`

#### Plist

This requires a pretty specifically formatted plist file. If *some* of the keys don't match up,
it tries its best to find just *a key* that contains either `ID` & `URL`

The keys available to specify in the plist are listed in `DMMUserDefaults.h`

`soapbox_announcement_id` : the ID of the announcement. If not specified a key containing `ID` will be used in place of this

`soapbox_announcement_url` : url of the announcement, assumed to be relative to `kDMMSoapBoxDefaultsBaseURL`

`soapbox_accept_url` : url to open if the accept button is selected. Can be relative or absolute

`soapbox_accept_title` : title to show on the accept button.

`soapbox_show_accept_button` : boolean to set if accept button should be shown or not

`soapbox_accept_color` : hex string color to use for accept button

`soapbox_dismiss_color` : hex string color to use instead of `[UIColor darkGrayColor]`

## License

    The MIT License (MIT)

    Copyright (c) 2015 Daniel Miedema

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
