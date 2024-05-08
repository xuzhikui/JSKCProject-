#ifndef Livedefined_h
#define Livedefined_h

#define ClassBundle [NSBundle bundleForClass: [self class]]
#define FaceDataPath [ClassBundle pathForResource:@"HSFaceData" ofType:@"bundle"]
#define FaceDataBundle [NSBundle bundleWithPath:FaceDataPath]
/**
 * 没有找到授权文件. 授权文件是 HSFaceData.bundle/lic/Mobile_Live.lic
 */
#define ERROR_LIC_NOTFOUND      1
/**
 * 授权过期了
 */
#define ERROR_LIC_EXPIRED       2
/**
 * 授权错误, 授权不匹配/授权解析失败
 */
#define ERROR_LIC_ERROR         3
/**
 * 资源文件错误, 缺少模型资源. 请将模型资源文件放在 HSFaceData.bundle/model 目录下
 */
#define ERROR_SDK_RESOURCE      4
/**
 * 需要初始化
 */
#define ERROR_NEED_INIT         5
/**
 * 重复初始化了
 */
#define ERROR_INIT_REPEAT       6

typedef enum HSFaceType {
    /**
     * 没有检测到人脸
     */
    HS_FACE_TYPE_NULL,
    /**
     * 人脸质量合格
     */
    HS_FACE_TYPE_VALID,
    /**
     * 人脸距离摄像头过近
     */
    HS_FACE_TYPE_CLOSE,
    /**
     * 人脸距离摄像头过远
     */
    HS_FACE_TYPE_FAR,
    /**
     * 人脸超出检测区域
     */
    HS_FACE_TYPE_OUTSIDE,
    /**
     * 左右偏置角度不合格
     */
    HS_FACE_TYPE_YAW,
    /**
     * 上下偏置角度不合格
     */
    HS_FACE_TYPE_PITCH,
    /**
     * 空间偏置角度不合格
     */
    HS_FACE_TYPE_ROLL,
    /**
     * 人脸比较模糊
     */
    HS_FACE_TYPE_BLUR,
    /**
     * 光线环境不合格
     */
    HS_FACE_TYPE_LIGHT,
    /**
     * 检测到戴口罩
     */
    HS_FACE_TYPE_MASK,
    /**
     * 人脸关键点有遮挡, 眼睛
     */
    HS_FACE_TYPE_EYE_OCCLUSION,
    /**
     * 人脸关键点有遮挡, 嘴巴
     */
    HS_FACE_TYPE_MOUTH_OCCLUSION,
    /**
     * 人脸关键点有遮挡, 鼻子
     */
    HS_FACE_TYPE_NOSE_OCCLUSION,
    /**
     * 人脸不连续, 换脸?
     */
    HS_FACE_TYPE_DISCONTINUOUS
    
}HSFaceType;

typedef enum Action{
    Idle,
    Still,
    Nod,
    Shake,
    Blink,
    OpenMouth
}Action;

typedef enum ActionStatus{
    Wait,
    Pass,
    Timeout
}ActionStatus;

typedef enum LiveStatus{
    None,
    Check,
    Good,
    NotSure
}LiveStatus;

typedef enum Mode{
    Debug,
    Info,
    Release
}Mode;

#endif /* Livedefined_h */
