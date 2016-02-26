//
//  NSMutableURLRequest+MultiPart.m
//  Pods
//
//  Created by Jonathan Siao on 07/02/2016.
//
//

#import "NSMutableURLRequest+MultiPart.h"

@implementation NSMutableURLRequest (MultiPart)

-(NSMutableURLRequest*) getFormRequestData:(UIImage*) image filename:(NSString*) filename json:(NSDictionary*)dictionary andURL:(NSURL*) url{
    NSMutableData *httpBody = [NSMutableData data];
    
    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
    
    if(dictionary){
        [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
    }
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"file\"; filename=\"%@\"\r\n",filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[NSData dataWithData:imageData]];
    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self setHTTPBody:httpBody];
    [self setHTTPMethod:@"POST"];
    [self addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [self setURL:url];
    
    return self;
}

@end
