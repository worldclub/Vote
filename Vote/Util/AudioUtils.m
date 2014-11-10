//
//  AudioUtils.m
//  BlindDate
//
//  Created by apple on 14-9-3.
//
//

#import "AudioUtils.h"

@implementation AudioUtils

static CGFloat             sampleRate                      = 11025.0;
static AVAudioQuality      quality                         = AVAudioQualityMin;

+(AudioUtils*)sharedInstance
{
    static AudioUtils*         sharedInstance                  = nil;
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AudioUtils alloc] init];
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                                 sizeof (audioRouteOverride),
                                 &audioRouteOverride);
        //Activate the session
        [session setActive:YES error: &sessionError];

    });
    
    return sharedInstance;
}


-(void)clearRecord:(NSString*)voicePath
{
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:voicePath])
    {
        [fileManager removeItemAtPath:voicePath error:nil];
    }
}

-(void)record:(NSURL*)recordFile
{

    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: sampleRate],                   AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatLinearPCM],          AVFormatIDKey,
                              [NSNumber numberWithInt: 2],                              AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: quality],                        AVEncoderAudioQualityKey,
                              nil];
    
    
    NSError* error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:recordFile settings:settings error:&error];
    if (error)
    {
        printf("%s",[[error description] UTF8String]);
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:@"your device doesn't support your setting"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    [_recorder prepareToRecord];
    _recorder.meteringEnabled = YES;
    [_recorder record];
    
}

-(void)play:(NSString*)voicePath
{
    playCompleteBlock = nil;
    
    if (isPlaying) {
        return;
    }
    
    if (_player == nil)
    {
        
        NSError *playerError;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:voicePath]
                                                            error:&playerError];
        _player.meteringEnabled = YES;
        if (_player == nil)
        {
            printf("ERror creating player: %s \n", [[playerError description] UTF8String]);
        }
    }
    _player.delegate = nil;
    [_player play];
    isPlaying = YES;
}

-(void)play:(NSData*)voiceData withCompleteBlock:(PlayCompleteBlock)completeBlock
{
    playCompleteBlock = completeBlock;
    
    if (isPlaying) {
        return;
    }
    
    if (_player == nil)
    {
        
        NSError *playerError;
        _player = [[AVAudioPlayer alloc] initWithData:voiceData error:&playerError];
        _player.meteringEnabled = YES;
        if (_player == nil)
        {
            printf("ERror creating player: %s \n", [[playerError description] UTF8String]);
        }
        _player.delegate = self;
    }
    [_player play];
    isPlaying = YES;
}


-(void)stopPlay
{
    if(_player != nil)
    {
        [_player stop];
        _player = nil;
    }
    isPlaying = NO;
}

-(void)stopRecord
{
    if(_recorder != nil)
    {
        [_recorder stop];
        _recorder = nil;
    }
}

-(BOOL)isPlaying
{
    return isPlaying;
}

-(void)convertRecord:(NSString*)sourcePath toMp3:(NSString*)mp3Path
{
    if([[NSFileManager defaultManager] fileExistsAtPath:mp3Path])
    {
        return;
    }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([sourcePath cStringUsingEncoding:1], "rb");  //source
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3Path cStringUsingEncoding:1], "wb");  //output
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, sampleRate);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
            {
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            }
            else
            {
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            }
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        printf("%s \n",[[exception description] UTF8String]);
    }
    @finally {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 1), ^{
//            
//        });
        printf("convert to mp3 done!");
    }
}

//获取record的声音分贝
-(CGFloat)recordDecibels
{
    [_recorder updateMeters];
    
    float   level;                // The linear 0.0 .. 1.0 value we need.
    
    float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    
    float   decibels = [_recorder averagePowerForChannel:0] + [_recorder averagePowerForChannel:1];
    
    if (decibels < minDecibels)
    {
        
        level = 0.0f;
    }
    else if (decibels >= 0.0f)
    {
        
        level = 1.0f;
    }
    else
    {
        
        float   root            = 2.0f;
        
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        
        float   amp             = powf(10.0f, 0.05f * decibels);
        
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
        
    }
    
    return  level * 120;
}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    isPlaying = NO;
    
    if(playCompleteBlock != nil)
    {
        playCompleteBlock();
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

@end
