//
//  Account.h


#import <Foundation/Foundation.h>

@interface WDCAccount : NSObject

@property (nonatomic, retain) NSString *userId;     //用户id
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *handPassword;
@property (nonatomic, retain) NSString *identityName;       //真实姓名
@property (nonatomic, retain) NSString *idCard;     //身份证号码

@property (nonatomic, retain) NSString *bankId;     //银行id
@property (nonatomic, retain) NSString *cardId;     //银行id
@property (nonatomic, retain) NSString *bankName;       //银行名称
@property (nonatomic, retain) NSString *bankCardNumber;     //银行卡号

@property (nonatomic, retain) NSString *inviteCode;     //邀请码

@property (nonatomic, retain) NSString *ftpPathOriginal;     //头像原图
@property (nonatomic, retain) NSString *ftpPathDispose;        //头像缩略图
@property (nonatomic, retain) NSString *deviceNo;        //deviceToken

@property (nonatomic, assign) BOOL lockStatus;
@property (nonatomic, assign) BOOL setLock;

@property (nonatomic, assign) BOOL emailValidate;//邮箱认证
@property (nonatomic, assign) BOOL mobileValidate;//手机认证
@property (nonatomic, assign) BOOL idcardValidate;//身份认证

// add by lyc
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *email;

@property (nonatomic, retain) NSString *uuid;
@property(nonatomic,strong) NSString* pas;

-(void)clear;

- (id) decode:(NSDictionary *)dataDic;
+ (WDCAccount *)sharedWDCAccount;
@end