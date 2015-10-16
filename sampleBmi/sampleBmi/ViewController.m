//
//  ViewController.m
//  sampleBmi
//
//  Created by Yokoe on 10/16/15.
//  Copyright © 2015 HANAUTA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bmiTextLabel.hidden = YES ;
    resultValueLabel.hidden = YES ;
    resultTextLabel.hidden = YES ;
    
    /* テキストフィールドに入力するときのキーボードタイプを、テンキーに指定 */
    heightTextField.keyboardType = UIKeyboardTypeNumberPad ;
    weightTextField.keyboardType = UIKeyboardTypeNumberPad ;
}

/* Return キーが押された時に、ソフトウェアキーボードをしまう */
- (BOOL)textFieldCatchReturn :(UITextField *)targetTextField
{
    [targetTextField resignFirstResponder] ;
    return 1 ; // YES
}

/* 計算する ボタンが押された時に、ソフトウェアキーボードをしまう */
- (IBAction)hideKeyboardWhenPushButton:(id)sender
{
    // ファーストレスポンダになっているものをしらみつぶしに探して、ファーストレスポンダをやめさせることで
    // ソフトウェアキーボードを非表示にする
        if ([heightTextField isFirstResponder] ) {
            [heightTextField resignFirstResponder] ;
        }else{
            [weightTextField resignFirstResponder] ;
        }
}

/* 計算する ボタンが押された時におこなう動作。BMIを計算し、結果を表示する。 */
- (IBAction)computeBMI
{
    float heightCentimeter ;
    float heightMeter ;
    float weight ;
    float bmiValue ;
    
    heightCentimeter = heightTextField.text.floatValue ;
    heightMeter = heightCentimeter / 100 ;
    weight = weightTextField.text.floatValue ;
    
    bmiValue = weight / (heightMeter * heightMeter) ;
    resultValueLabel.text = [[NSString alloc] initWithFormat:@"%.2f", bmiValue] ;
    
    if(bmiValue < 17.6){
        resultTextLabel.text = @"やせすぎです。\nもっと食べましょう。" ;
    }else if(bmiValue < 19.8){
        resultTextLabel.text = @"やせ気味ですが、まあ、いい感じですね。" ;
    }else if(bmiValue < 24.2){
        resultTextLabel.text = @"健康的なBMIです。\nとはいえ、これで全ては測れません。\n適度な運動を心がけましょう。" ;
    }else if(bmiValue < 26.4){
        resultTextLabel.text = @"太り気味ですね。\n日本ではけっこうヤバイレベルですので、体を動かしましょう。" ;
    }else if(bmiValue >= 26.4){
        resultTextLabel.text = @"肥満体質です。やばいです。\n長生きするにはもっといろいろ考えたほうがいいです。\n\
場合によってはお医者さんのお世話になったほうがよいでしょう。" ;
    }else{
        resultTextLabel.text = @"ERROR" ;
    }
    
    bmiTextLabel.hidden = NO ;
    resultValueLabel.hidden = NO ;
    resultTextLabel.hidden = NO ;
    
    [self outputUsersData :heightCentimeter :weight :bmiValue] ;
    return ;
}

/* 入力されたデータを Mac 内に保存 */
- (int)outputUsersData :(float)heightCentimeter :(float)weight :(float)bmiValue
{
    NSMutableString *writingPath = [[NSMutableString alloc] initWithString:@"" ] ;
    [writingPath setString:@"~/Documents/test_Folder/bmiText.txt" ] ;
    
    BOOL fileExistFlag = [ [[NSFileManager alloc] init]
                          fileExistsAtPath:[writingPath stringByExpandingTildeInPath] ] ;
    NSMutableString *writeString = [[NSMutableString alloc] initWithString:@""] ;
    if(fileExistFlag == YES){
        NSString *existFileString = [ [NSString alloc]
                                     initWithContentsOfFile:[writingPath stringByExpandingTildeInPath]
                                     encoding:NSUTF8StringEncoding
                                     error:nil ] ;
        [writeString appendString:existFileString] ;
    }else{
        /* ファイルが見つからない場合は、フォルダを作る */
        [ [[NSFileManager alloc] init]
         createDirectoryAtPath:[[writingPath stringByExpandingTildeInPath] stringByDeletingLastPathComponent]
         withIntermediateDirectories:YES
         attributes:nil
         error:nil ] ;
    }
    
    [writeString appendFormat:@"%.2fcm, %.2fkg, %.2f\n", heightCentimeter, weight, bmiValue] ;
    
    @try
    {
        [writeString
         writeToFile:[writingPath stringByExpandingTildeInPath]
         atomically:YES
         encoding:NSUTF8StringEncoding
         error:nil] ;
        NSLog(@"%@ に、ファイルを書き込みました", [[writingPath stringByExpandingTildeInPath] stringByDeletingLastPathComponent] ) ;
    }
    @catch (NSException *exception) {
        NSLog(@"ファイルの書き込みは行えませんでした") ;
        return -1 ;
    }
    return 1 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
