//
//  NSMutableURLRequest+MultiPart.h
//  Pods
//
//  Created by Jonathan Siao on 07/02/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableURLRequest (MultiPart)

-(NSMutableURLRequest*) getFormRequestData:(UIImage*) image filename:(NSString*) filename json:(NSDictionary*)dictionary andURL:(NSURL*) url;

@end
