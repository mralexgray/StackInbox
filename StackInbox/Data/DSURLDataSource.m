//
//  DSUrlDataSoource.m
//  DSFavIcon
//
//  Created by Fabio Pelosin on 17/09/12.
//  Copyright (c) 2012 Discontinuity s.r.l. All rights reserved.
//

#import "DSURLDataSource.h"

@implementation DSURLDataSource

// Top 250 websites from Alexa
- (NSArray*)testDomains {
    static NSArray *_domains = nil;
	return _domains = _domains ?: @[ @"manhunt.net", @"adam4adam.com", @"grindr.com", @"facebook.com", @"google.com", @"youtube.com", @"yahoo.com", @"baidu.com", @"wikipedia.org", @"live.com", @"qq.com", @"twitter.com", @"amazon.com", @"blogspot.com", @"google.co.in", @"taobao.com", @"linkedin.com", @"yahoo.co.jp", @"msn.com", @"sina.com.cn", @"google.com.hk", @"google.de", @"bing.com", @"yandex.ru", @"babylon.com", @"wordpress.com", @"ebay.com", @"google.co.uk", @"google.co.jp", @"google.fr", @"163.com", @"soso.com", @"vk.com", @"weibo.com", @"microsoft.com", @"mail.ru", @"googleusercontent.com", @"google.com.br", @"tumblr.com", @"ask.com", @"craigslist.org", @"pinterest.com", @"paypal.com", @"xhamster.com", @"google.es", @"sohu.com", @"apple.com", @"google.it", @"bbc.co.uk", @"avg.com", @"xvideos.com", @"google.ru", @"blogger.com", @"fc2.com", @"livejasmin.com", @"imdb.com", @"tudou.com", @"adobe.com", @"t.co", @"google.com.mx", @"go.com", @"flickr.com", @"conduit.com", @"youku.com", @"google.ca", @"odnoklassniki.ru", @"ifeng.com", @"tmall.com", @"hao123.com", @"aol.com", @"mywebsearch.com", @"pornhub.com", @"zedo.com", @"ebay.de", @"blogspot.in", @"google.co.id", @"cnn.com", @"thepiratebay.se", @"sogou.com", @"rakuten.co.jp", @"about.com", @"amazon.de", @"alibaba.com", @"google.com.au", @"google.com.tr", @"espn.go.com", @"redtube.com", @"huffingtonpost.com", @"ebay.co.uk", @"360buy.com", @"mediafire.com", @"chinaz.com", @"google.pl", @"adf.ly", @"uol.com.br", @"stackoverflow.com", @"netflix.com", @"ameblo.jp", @"youporn.com", @"dailymotion.com", @"amazon.co.jp", @"imgur.com", @"instagram.com", @"godaddy.com", @"wordpress.org", @"doubleclick.com", @"4shared.com", @"alipay.com", @"360.cn", @"globo.com", @"livedoor.com", @"amazon.co.uk", @"bp.blogspot.com", @"xnxx.com", @"cnet.com", @"searchnu.com", @"weather.com", @"torrentz.eu", @"search-results.com", @"google.com.sa", @"wigetmedia.com", @"google.nl", @"livejournal.com", @"nytimes.com", @"adcash.com", @"incredibar.com", @"tube8.com", @"dailymail.co.uk", @"neobux.com", @"ehow.com", @"badoo.com", @"google.com.ar", @"douban.com", @"cnzz.com", @"renren.com", @"tianya.cn", @"vimeo.com", @"bankofamerica.com", @"reddit.com", @"warriorforum.com", @"spiegel.de", @"deviantart.com", @"aweber.com", @"dropbox.com", @"indiatimes.com", @"pconline.com.cn", @"kat.ph", @"blogfa.com", @"google.com.pk", @"mozilla.org", @"secureserver.net", @"chase.com", @"google.co.th", @"google.com.eg", @"goo.ne.jp", @"booking.com", @"56.com", @"stumbleupon.com", @"google.co.za", @"google.cn", @"softonic.com", @"london2012.org", @"walmart.com", @"answers.com", @"sourceforge.net", @"comcast.net", @"addthis.com", @"foxnews.com", @"photobucket.com", @"wikimedia.org", @"zeekrewards.com", @"onet.pl", @"clicksor.com", @"amazonaws.com", @"pengyou.com", @"wellsfargo.com", @"wikia.com", @"liveinternet.ru", @"depositfiles.com", @"yesky.com", @"outbrain.com", @"google.co.ve", @"bild.de", @"etsy.com", @"xunlei.com", @"allegro.pl", @"statcounter.com", @"guardian.co.uk", @"skype.com", @"adultfriendfinder.com", @"fbcdn.net", @"leboncoin.fr", @"58.com", @"mgid.com", @"reference.com", @"squidoo.com", @"myspace.com", @"fiverr.com", @"iqiyi.com", @"letv.com", @"funmoods.com", @"google.com.co", @"google.com.my", @"optmd.com", @"youjizz.com", @"naver.com", @"rediff.com", @"filestube.com", @"domaintools.com", @"slideshare.net", @"themeforest.net", @"download.com", @"zol.com.cn", @"ucoz.ru", @"google.be", @"free.fr", @"rapidshare.com", @"salesforce.com", @"archive.org", @"nicovideo.jp", @"google.com.vn", @"google.gr", @"soundcloud.com", @"people.com.cn", @"orange.fr", @"scribd.com", @"nbcnews.com", @"yieldmanager.com", @"it168.com", @"xinhuanet.com", @"cam4.com", @"w3schools.com", @"4399.com", @"isohunt.com", @"iminent.com", @"tagged.com", @"files.wordpress.com", @"hootsuite.com", @"espncricinfo.com", @"yelp.com", @"wp.pl", @"hardsextube.com", @"ameba.jp", @"google.com.tw", @"imageshack.us", @"tripadvisor.com", @"4dsply.com", @"web.de", @"rambler.ru", @"google.at", @"google.se", @"gmx.net", @"pof.com"];
}
//    NSMutableArray *result = [listFromAlexa mutableCopy];
//    [result replaceObjectAtIndex:[result indexOfObject:@"360buy.com"] withObject:@"www.360buy.com"]; //Redirects with javascript
//    [result replaceObjectAtIndex:[result indexOfObject:@"amazonaws.com"] withObject:@"aws.amazon.com"];
//    return result;



// URL Absolute string
+ (NSArray*)domainsToSkip {
    return @[
    @"http://googleusercontent.com", @"http://go.com", @"http://bp.blogspot.com", @"http://secureserver.net", @"http://wikia.com", @"http://optmd.com", @"http://people.com.cn", @"http://yieldmanager.com", @"http://zedo.com", @"http://adf.ly",                   // 1px size
    @"http://adcash.com",               // 1px size
    @"http://adultfriendfinder.com",    // 1px size
    @"http://rapidshare.com",           // Creates the link tag with Javascritp
    @"http://thepiratebay.se",          // Blocked in Italy
    @"http://kat.ph",                   // Blocked in Italy
    @"http://london2012.org"            // Offline ?
    ];
}

@end
