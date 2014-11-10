//
//  AudioUtils.h
//  BlindDate
//
//  Created by apple on 14-9-3.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#include "lame.h"

typedef  void(^PlayCompleteBlock)();

@interface AudioUtils : NSObject<AVAudioPlayerDelegate>
{
    AVAudioPlayer * _player;
    AVAudioRecorder * _recorder;
    
    PlayCompleteBlock  playCompleteBlock;
    BOOL isPlaying;
}

+(AudioUtils*)sharedInstance;

-(void)record:(NSURL*)recordFile;
-(void)play:(NSString*)voicePath;
-(void)play:(NSData*)voiceData withCompleteBlock:(PlayCompleteBlock)completeBlock;
-(void)stopPlay;
-(void)stopRecord;
-(void) convertRecord:(NSString*)sourcePath toMp3:(NSString*)mp3Path;
-(BOOL)isPlaying;
-(CGFloat)recordDecibels;
-(void)clearRecord:(NSString*)voicePath;
@end
