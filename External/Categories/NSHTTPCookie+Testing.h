@interface NSHTTPCookie (IGPropertyTesting)

- (BOOL)isExpired;
- (BOOL)isForHost:(NSS *)host;
- (BOOL)isForPath:(NSS *)path;
- (BOOL)isForRequest:(NSURLRequest *)request;

- (BOOL)isEqual:(id)object;

@end
