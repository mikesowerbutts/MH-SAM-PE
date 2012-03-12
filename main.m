//
//  main.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    @try{
        NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
        int retVal = UIApplicationMain(argc, argv, nil, nil);
        [pool release];
        return retVal;
    }
    @catch(NSException *ex){
        NSLog(@"Error Reason: %@", ex.reason);
        NSLog(@"Error Description: %@", ex.description);
    }
}
