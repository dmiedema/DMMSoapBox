# DMMSoapBox

[![Build Status](https://travis-ci.org/dmiedema/DMMSoapBox.svg)](https://travis-ci.org/dmiedema/DMMSoapBox)

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

#### Plist

This requires a pretty specifically formatted plist file. If *some* of the keys don't match up,
it tries its best to find just *a key* that contains either `ID` & `URL`


