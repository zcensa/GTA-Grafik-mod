/* 

 * NaturalVision Evolved by Razed
 * ENBSeries             by Boris Vorontsov
 * Modifications         by icelaglace 
 * CAS shader            by AMD and based on SLSNe port for ReShade
 * SMAA shader           by Jorge Jimenez, Jose I. Echevarria, Belen Masia, Fernando Navarro, Diego Gutierrez, ported to ENB by Kingeric1992
 * Copyright (c) 2020 Advanced Micro Devices, Inc. All rights reserved. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 ! Please ask permissions if you want to re-use the shader    !
 ! Credit people properly, thank you, even if it's on the web !

 -- You know who you are. I wouldn't have to type this if you didn't.

 */
bool    space0             
<
    string UIName=" ";
> = {false};

bool    text0             
<
    string UIName="|| Sharpening :";
> = {false};

float   ESharpAmount
<
    string UIName="  ---> Amount";
    string UIWidget="spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {1.0};

bool    CASEnable             
<
    string UIName="  ---> Click here to enable AMD CAS";
> = {false};

bool    space1             
<
    string UIName="  ";
> = {false};

bool    text1             
<
    string UIName="|| Misc. Effects :";
> = {false};

bool    MiscEffectEnable             
<
    string UIName="  ---> Click here to enable Misc. Effects";
> = {false};

float   PPGrain
<
    string UIName="  ---> Film Grain Intensity";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {0.0};

float   PPLetterbox
<
    string UIName="  ---> Letterboxing Crop Value";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {0.0};

float   GreenScreenDistance
<
    string UIName="  ---> Green Screen : Distance";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=10000.0;
> = {1000.0};

float   GreenScreenRadial
<
    string UIName="  ---> Green Screen : Radial Size";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {0.1};

bool    GreenScreenMask             
<
    string UIName="  ---> Green Screen : Mask Mode";
> = {false};

bool    GreenScreenCustom             
<
    string UIName="  ---> Green Screen : Enable Custom Color";
> = {false};


float3  GreenScreenColor <
    string UIName="  ---> Green Screen : Custom Color";
    string UIWidget="Color";
> = {0.0, 0.0, 1.0};

float   DepthMaskDistance
<
    string UIName="  ---> Depth Mask : Distance";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=10000.0;
> = {1000.0};

float   DepthMaskSize
<
    string UIName="  ---> Depth Mask : Size";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {0.1};

bool    space2            
<
    string UIName="   ";
> = {false};

bool    text2             
<
    string UIName="|| LUT :";
> = {false};

bool    LUTEnable             
<
    string UIName="  ---> Click here to enable 3D LUT";
> = {false};

bool    LUTFlip             
<
    string UIName="  ---> Click here to Flip in Y Axis the LUT";
> = {false};

bool    space3            
<
    string UIName="    ";
> = {false};

bool    text3             
<
    string UIName="|| NVE Official Color Grading :";
> = {false};

int   PPPreset
<
    string UIName="  ---> Preset Selector";
> = {0};

bool    space4            
<
    string UIName="     ";
> = {false};

bool    text4             
<
    string UIName="|| Color Grading Customizer :";
> = {false};

bool    text4_2            
<
    string UIName="!! -Preset Selector- must be 0 first";
> = {false};

float   PPGamma
<
    string UIName="  ---> Gamma";
    string UIWidget="Spinner";
    float UIMin=0.2;//not zero!!!
    float UIMax=5.0;
> = {1.0};

float   PPBrightness
<
    string UIName="  ---> Brightness";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float   PPContrast
<
    string UIName="  ---> Contrast";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float   PPSaturation
<
    string UIName="  ---> Saturation";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float   PPBleach
<
    string UIName="  ---> Bleach Bypass";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {0.0};

bool    spacep           
<
    string UIName="       ";
> = {false};


float   PPTempStrength
<
    string UIName="  ---> Color Temperature Blend";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {1.0};

float   PPTemperature
<
    string UIName="  ---> Color Temperature in Kelvin";
    string UIWidget="Spinner";
    float UIMin=1000.0;
    float UIMax=40000.0;
> = {6500.0};

bool    space5            
<
    string UIName="      ";
> = {false};

float   PPInBlack
<
    string UIName="  ---> Levels : Min Input";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {0.0};

float   PPInWhite
<
    string UIName="  ---> Levels : Max Input";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {1.0};

float   PPOutBlack
<
    string UIName="  ---> Levels : Min Output";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {0.0};

float   PPOutWhite
<
    string UIName="  ---> Levels : Max Output";
    string UIWidget="Spinner";
    float UIMin=0.0;
    float UIMax=1.0;
> = {1.0};

bool    space6            
<
    string UIName="         ";
> = {false};

bool    text6            
<
    string UIName="!! Grey color (127,127,127) is neutral/disabled!";
> = {false};

float3  PPColorBalanceShadows <
    string UIName="  ---> Shadows Tint";
    string UIWidget="Color";
> = {0.5, 0.5, 0.5};

float3  PPColorBalanceHighlights <
    string UIName="  ---> Highlights Tint";
    string UIWidget="Color";
> = {0.5, 0.5, 0.5};

bool    space7          
<
    string UIName="        ";
> = {false};

float3  PPChannelMixerR <
    string UIName="  ---> Channel Mixer : Red";
    string UIWidget="Color";
> = {1.0, 0.0, 0.0};

float3  PPChannelMixerG <
    string UIName="  ---> Channel Mixer : Green";
    string UIWidget="Color";
> = {0.0, 1.0, 0.0};

float3  PPChannelMixerB <
    string UIName="  ---> Channel Mixer : Blue";
    string UIWidget="Color";
> = {0.0, 0.0, 1.0};

bool    space8        
<
    string UIName="        ";
> = {false};

Texture2D noisetex 
< 
    string UIName = "LUT";
    string ResourceName = "lut.png";
>;

//+++++++++++++++++++++++++++++
//external enb parameters, do not modify
//+++++++++++++++++++++++++++++
//x = generic timer in range 0..1, period of 16777216 ms (4.6 hours), y = average fps, w = frame time elapsed (in seconds)
float4  Timer;
//x = Width, y = 1/Width, z = aspect, w = 1/aspect, aspect is Width/Height
float4  ScreenSize;
//changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float   AdaptiveQuality;
//x = current weather index, y = outgoing weather index, z = weather transition, w = time of the day in 24 standart hours. Weather index is value from weather ini file, for example WEATHER002 means index==2, but index==0 means that weather not captured.
float4  Weather;
//x = dawn, y = sunrise, z = day, w = sunset. Interpolators range from 0..1
float4  TimeOfDay1;
//x = dusk, y = night. Interpolators range from 0..1
float4  TimeOfDay2;
//changes in range 0..1, 0 means that night time, 1 - day time
float   ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float   EInteriorFactor;

//+++++++++++++++++++++++++++++
//external enb debugging parameters for shader programmers, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables. Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4  tempF1; //0,1,2,3
float4  tempF2; //5,6,7,8
float4  tempF3; //9,0
// xy = cursor position in range 0..1 of screen;
// z = is shader editor window active;
// w = mouse buttons with values 0..7 as follows:
//    0 = none
//    1 = left
//    2 = right
//    3 = left+right
//    4 = middle
//    5 = left+middle
//    6 = right+middle
//    7 = left+right+middle (or rather cat is sitting on your mouse)
float4  tempInfo1;
// xy = cursor position of previous left mouse button click
// zw = cursor position of previous right mouse button click
float4  tempInfo2;


//+++++++++++++++++++++++++++++
//mod parameters, do not modify
//+++++++++++++++++++++++++++++
Texture2D           TextureOriginal; //color R10B10G10A2 32 bit ldr format
Texture2D           TextureColor; //color which is output of previous technique (except when drawed to temporary render target), R10B10G10A2 32 bit ldr format
Texture2D           TextureDepth; //scene depth R32F 32 bit hdr format

//temporary textures which can be set as render target for techniques via annotations like <string RenderTarget="RenderTargetRGBA32";>
Texture2D           RenderTargetRGBA32; //R8G8B8A8 32 bit ldr format
Texture2D           RenderTargetRGBA64; //R16B16G16A16 64 bit ldr format
Texture2D           RenderTargetRGBA64F; //R16B16G16A16F 64 bit hdr format
Texture2D           RenderTargetR16F; //R16F 16 bit hdr format with red channel only
Texture2D           RenderTargetR32F; //R32F 32 bit hdr format with red channel only
Texture2D           RenderTargetRGB32F; //32 bit hdr format without alpha

#include "NVE_ColorConfig.fx"
#include "enbsmaa.fx" 

SamplerState        Sampler0
{
    Filter = MIN_MAG_MIP_POINT;//MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};
SamplerState        Sampler1
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

struct VS_INPUT_POST
{
    float3 pos      : POSITION;
    float2 txcoord  : TEXCOORD0;
};
struct VS_OUTPUT_POST
{
    float4 pos      : SV_POSITION;
    float2 txcoord0 : TEXCOORD0;
};



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST  VS_PostProcess(VS_INPUT_POST IN)
{
    VS_OUTPUT_POST  OUT;
    float4  pos;
    pos.xyz=IN.pos.xyz;
    pos.w=1.0;
    OUT.pos=pos;
    OUT.txcoord0.xy=IN.txcoord.xy;
    return OUT;
}

float3 kelvin2rgb(float temp)
{
    float3x3 m = (temp <= 6500.0) ? float3x3(float3(0.0, -2902.1955373783176, -8257.7997278925690),
                                             float3(0.0, 1669.5803561666639, 2575.2827530017594),
                                             float3(1.0, 1.3302673723350029, 1.8993753891711275)) :
                                    float3x3(float3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
                                             float3(-2666.3474220535695, -2173.1012343082230, 2575.2827530017594),
                                             float3(0.55995389139931482, 0.70381203140554553, 1.8993753891711275));
    return saturate(float3(m[0] / (clamp(temp, 1000.0, 40000.0) + m[1]) + m[2]));
}

float Min3(float x, float y, float z)
{
    return min(x, min(y, z));
}

float Max3(float x, float y, float z)
{
    return max(x, max(y, z));
}

float4  PS_Sharpening(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
    float4  res;
    float4  color;
    float4  centercolor;
    float2  pixeloffset=ScreenSize.x;
    pixeloffset.y /= ScreenSize.z;
    color=TextureColor.Sample(Sampler0, IN.txcoord0.xy);

    if (CASEnable)
    {
        // fetch a 3x3 neighborhood around the pixel 'e',
        //  a b c
        //  d(e)f
        //  g h i
        float pixelX = 1.0 / pixeloffset.x;
        float pixelY = 1.0 / pixeloffset.y;
        
        float3 a = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(-pixelX, -pixelY)).rgb;
        float3 b = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(0.0, -pixelY)).rgb;
        float3 c = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(pixelX, -pixelY)).rgb;
        float3 d = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(-pixelX, 0.0)).rgb;
        float3 e = TextureColor.Sample(Sampler1, IN.txcoord0.xy).rgb;
        float3 f = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(pixelX, 0.0)).rgb;
        float3 g = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(-pixelX, pixelY)).rgb;
        float3 h = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(0.0, pixelY)).rgb;
        float3 i = TextureColor.Sample(Sampler1, IN.txcoord0.xy + float2(pixelX, pixelY)).rgb;
    
        // Soft min and max.
        //  a b c             b
        //  d e f * 0.5  +  d e f * 0.5
        //  g h i             h
        // These are 2.0x bigger (factored out the extra multiply).
        float mnR = Min3( Min3(d.r, e.r, f.r), b.r, h.r);
        float mnG = Min3( Min3(d.g, e.g, f.g), b.g, h.g);
        float mnB = Min3( Min3(d.b, e.b, f.b), b.b, h.b);
        
        float mnR2 = Min3( Min3(mnR, a.r, c.r), g.r, i.r);
        float mnG2 = Min3( Min3(mnG, a.g, c.g), g.g, i.g);
        float mnB2 = Min3( Min3(mnB, a.b, c.b), g.b, i.b);
        mnR = mnR + mnR2;
        mnG = mnG + mnG2;
        mnB = mnB + mnB2;
        
        float mxR = Max3( Max3(d.r, e.r, f.r), b.r, h.r);
        float mxG = Max3( Max3(d.g, e.g, f.g), b.g, h.g);
        float mxB = Max3( Max3(d.b, e.b, f.b), b.b, h.b);
        
        float mxR2 = Max3( Max3(mxR, a.r, c.r), g.r, i.r);
        float mxG2 = Max3( Max3(mxG, a.g, c.g), g.g, i.g);
        float mxB2 = Max3( Max3(mxB, a.b, c.b), g.b, i.b);
        mxR = mxR + mxR2;
        mxG = mxG + mxG2;
        mxB = mxB + mxB2;
        
        // Smooth minimum distance to signal limit divided by smooth max.
        float rcpMR = rcp(mxR);
        float rcpMG = rcp(mxG);
        float rcpMB = rcp(mxB);
    
        float ampR = saturate(min(mnR, 2.0 - mxR) * rcpMR);
        float ampG = saturate(min(mnG, 2.0 - mxG) * rcpMG);
        float ampB = saturate(min(mnB, 2.0 - mxB) * rcpMB);
        
        // Shaping amount of sharpening.
        ampR = sqrt(ampR);
        ampG = sqrt(ampG);
        ampB = sqrt(ampB);
        
       // Filter shape.
       //  0 w 0
       //  w 1 w
       //  0 w 0  
       float peak = -rcp(lerp(8.0, 5.0, ESharpAmount));
       
       float wR = ampR * peak;
       float wG = ampG * peak;
       float wB = ampB * peak;
       
       float rcpWeightR = rcp(1.0 + 4.0 * wR);
       float rcpWeightG = rcp(1.0 + 4.0 * wG);
       float rcpWeightB = rcp(1.0 + 4.0 * wB);
       
       color.xyz = float3(saturate((b.r*wR+d.r*wR+f.r*wR+h.r*wR+e.r)*rcpWeightR),
                          saturate((b.g*wG+d.g*wG+f.g*wG+h.g*wG+e.g)*rcpWeightG),
                          saturate((b.b*wB+d.b*wB+f.b*wB+h.b*wB+e.b)*rcpWeightB));
    }
    else
    {
        float2 offset = 1.0f / pixeloffset;
        float3 A = TextureColor.Sample(Sampler1, IN.txcoord0 + float2(-offset.x, -offset.y)).xyz;
        float3 B = TextureColor.Sample(Sampler1, IN.txcoord0 + float2( offset.x, -offset.y)).xyz;
        float3 C = TextureColor.Sample(Sampler1, IN.txcoord0 + float2(-offset.x,  offset.y)).xyz;
        float3 D = TextureColor.Sample(Sampler1, IN.txcoord0 + float2( offset.x,  offset.y)).xyz;
        float3 E = (A + B + C + D) * 0.25f;
        
        color.xyz += (color.xyz - E.xyz) * ESharpAmount;
    }
    return float4(color.xyz,1.0);
}

float4  PS_ColorGrading(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
    float3 _ColorBalanceShadows    = PPColorBalanceShadows;
    float3 _ColorBalanceHighlights = PPColorBalanceHighlights;
    float3 _ChannelMixerR          = PPChannelMixerR;
    float3 _ChannelMixerG          = PPChannelMixerG;
    float3 _ChannelMixerB          = PPChannelMixerB;
    float _InBlack                 = PPInBlack;
    float _InWhite                 = PPInWhite;
    float _OutBlack                = PPOutBlack;
    float _OutWhite                = PPOutWhite;
    float _TempStrength            = PPTempStrength;
    float _Temperature             = PPTemperature;
    float _Gamma                   = PPGamma;
    float _Brightness              = PPBrightness;
    float _Contrast                = PPContrast;
    float _Saturation              = PPSaturation;
    float _Bleach                  = PPBleach;

    float2 pixeloffset = IN.txcoord0.xy * ScreenSize.x;
    float3 color       = TextureColor.Sample(Sampler1,IN.txcoord0.xy).xyz;
    float3 rec709      = float3(0.2126f, 0.7152f, 0.0722f);

    ColorCorrection(PPPreset, _InBlack, _InWhite, _OutBlack, _OutWhite,
                   _ColorBalanceShadows, _ColorBalanceHighlights,
                   _ChannelMixerR, _ChannelMixerG, _ChannelMixerB,
                   _TempStrength, _Temperature, _Gamma,
                   _Brightness, _Contrast, _Saturation, _Bleach);

    if (LUTEnable) 
    {
        uint2 lutsize; noisetex.GetDimensions(lutsize.x, lutsize.y);
        float3 lutuv   = float3((color.xy * (lutsize.y - 1.0f) + 0.5f) * (1.0f / lutsize), color.z * (lutsize.y - 1.0f));
        lutuv.x       += floor(lutuv.z) * (1.0f / lutsize.y);
        if (LUTFlip)     lutuv.y = 1.0f - lutuv.y;
        color.xyz      = lerp(noisetex.SampleLevel(Sampler1, lutuv.xy, 0.0f).xyz,
                              noisetex.SampleLevel(Sampler1, float2(lutuv.x + (1.0 / lutsize.y), lutuv.y), 0.0f).xyz,
                              lutuv.z - floor(lutuv.z));
    }

    float luma  = dot(color, rec709);
    color.xyz = lerp(luma, color.xyz, _Saturation);

    color.xyz   = lerp(color.xyz, color.xyz * kelvin2rgb(_Temperature), _TempStrength);
    float luma2 = dot(color.xyz, rec709);
    color.xyz  *= (luma2 > 1e-6) ? (luma / luma2) : 1.0;

    luma         = dot(color.xyz, rec709);
    float  bluma = min(1.0f, max(0.0f, 10.0f * (luma - 0.45)));
    float3 b1    = 2.0f * color.xyz * luma; 
    float3 b2    = 1.0f - 2.0f * (1.0f - luma) * (1.0f - color.xyz);
    color.xyz    = (_Bleach * lerp(b1,b2,bluma)) + (1.0f - _Bleach) * color.xyz; 
    
    color.xyz  = max(color - _InBlack, 0.0f) / max(_InWhite - _InBlack, 1e-5);
    color.xyz  = pow(color, _Gamma);
    color.xyz *= (_OutWhite - _OutBlack) + _OutBlack;

    luma       = dot(color.xyz, rec709);
    luma      *= luma;
    color.rgb += (_ColorBalanceHighlights * 2.0f - 1.0f) * color.xyz * (luma);
    color.rgb += (_ColorBalanceShadows * 2.0f - 1.0f) * (1.0f - color.xyz) * (1.0f - luma);

    color.x = dot(color.xyz, _ChannelMixerR);
    color.y = dot(color.xyz, _ChannelMixerG);
    color.z = dot(color.xyz, _ChannelMixerB);

    color.xyz  = (color.xyz - 0.5f) * _Contrast + 0.5f;
    color.xyz *= _Brightness;

    return float4(color.xyz, 1.0f);
}

float4  PS_MiscEffects(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
    float3 color = TextureColor.Sample(Sampler1, IN.txcoord0.xy).xyz;

    if (MiscEffectEnable)
    {
        float2 pixeloffset = IN.txcoord0.xy * ScreenSize.x;
    
        float x      = (pixeloffset.x + 4) * (pixeloffset.y + 4) * Timer.x;
        float grain  = (fmod(
                       (fmod(x, 13.0f)  + 1.0f) *
                       (fmod(x, 123.0f) + 1.0f), 0.01f) - 0.005f) *
                       (PPGrain * 100.0f);
    
        float luma = dot(color.xyz, float3(0.2126f, 0.7152f, 0.0722f));
        grain      = 1.0f - grain;
        grain      = lerp(grain, 1.0f, saturate(luma * 2.0f));
    
        color.xyz *= grain;
        color.xyz  = (IN.txcoord0.y > PPLetterbox * 0.5        &&
                      IN.txcoord0.y < 1.0f - PPLetterbox * 0.5 )
                      ? color.xyz : 0.0;
    }

    return float4(color.xyz, 1.0f);
}

float4  PS_GreenScreen(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
    float depth  = TextureDepth.Sample(Sampler1,IN.txcoord0.xy).x;
    depth /= 10.0f - depth * 10.0f;

	float2 uv = IN.txcoord0;
	float3 bgcolor = float3(0.0f,1.0f,0.0f);
	if (GreenScreenCustom) bgcolor = GreenScreenColor;

	depth *= length(float2((uv.x - 0.5f) * GreenScreenRadial, 1.0f));
	depth *= length(float2((uv.y - 0.5f) * GreenScreenRadial / ScreenSize.z, 1.0f));
	float res = depth > GreenScreenDistance;

	if (!GreenScreenMask)
    {
        float3 color  = TextureColor.Sample(Sampler1,IN.txcoord0.xy).xyz;
               color  = lerp(color, bgcolor, saturate(res));
        return float4(color.xyz,1.0f);
    }
    else
    {
        return float4(res.xxx,1.0f);
    }
}

float4  PS_DepthMask(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
    float depth  = TextureDepth.Sample(Sampler1,IN.txcoord0.xy).x;
    float focus  = 1.0f - (1.0f / depth);
          focus *= DepthMaskDistance * DepthMaskDistance;

    float factor = abs(depth - focus);
    factor       = factor * (DepthMaskSize * 0.01f);
    factor       = 1.0f - factor;

    if (depth < focus) factor = 0.0f;
    
    return float4(factor.xxx,1);
}

technique11 SMAA <string RenderTarget= SMAA_STRING(SMAA_EDGE_TEX); string UIName="SMAA";>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }

    pass EdgeDetection
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAEdgeDetection()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAEdgeDetection()));
    }
}

technique11 SMAA1 <string RenderTarget=SMAA_STRING(SMAA_BLEND_TEX);>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }
    
    pass BlendingWeightCalculation
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAABlendingWeightCalculation()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAABlendingWeightCalculation()));
    }
}

technique11 SMAA2
{
    pass NeighborhoodBlending
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAANeighborhoodBlending()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAANeighborhoodBlending()));
    }
}

technique11 SMAA3
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_MiscEffects()));
    }
}

technique11 CAS <string UIName="Sharpen";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_Sharpening()));
    }
}

technique11 CASSMAA <string RenderTarget= SMAA_STRING(SMAA_EDGE_TEX); string UIName="Sharpen + SMAA";>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }

    pass EdgeDetection
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAEdgeDetection()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAEdgeDetection()));
    }
}

technique11 CASSMAA1 <string RenderTarget=SMAA_STRING(SMAA_BLEND_TEX);>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }
    
    pass BlendingWeightCalculation
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAABlendingWeightCalculation()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAABlendingWeightCalculation()));
    }
}

technique11 CASSMAA2
{
    pass NeighborhoodBlending
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAANeighborhoodBlending()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAANeighborhoodBlending()));
    }
}


technique11 CASSMAA3
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_Sharpening()));
    }
}

technique11 CASSMAA4
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_MiscEffects()));
    }
}

technique11 LUT <string UIName="Color Grading";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_ColorGrading()));
    }
}

technique11 LUT1
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_MiscEffects()));
    }
}

technique11 LUTSMAA <string RenderTarget= SMAA_STRING(SMAA_EDGE_TEX); string UIName="Color Grading + SMAA";>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }

    pass EdgeDetection
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAEdgeDetection()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAEdgeDetection()));
    }
}

technique11 LUTSMAA1 <string RenderTarget=SMAA_STRING(SMAA_BLEND_TEX);>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }
    
    pass BlendingWeightCalculation
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAABlendingWeightCalculation()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAABlendingWeightCalculation()));
    }
}

technique11 LUTSMAA2
{
    pass NeighborhoodBlending
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAANeighborhoodBlending()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAANeighborhoodBlending()));
    }
}


technique11 LUTSMAA3
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_ColorGrading()));
    }
}

technique11 LUTSMAA4
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_MiscEffects()));
    }
}

technique11 LUTCAS <string UIName="Color Grading + Sharpen";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_Sharpening()));
    }
}

technique11 LUTCAS1
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_ColorGrading()));
    }
}

technique11 LUTCAS2
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_MiscEffects()));
    }
}

technique11 LUTCASSMAA <string RenderTarget= SMAA_STRING(SMAA_EDGE_TEX); string UIName="Color Grading + Sharpen + SMAA";>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }

    pass EdgeDetection
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAEdgeDetection()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAEdgeDetection()));
    }
}

technique11 LUTCASSMAA1 <string RenderTarget=SMAA_STRING(SMAA_BLEND_TEX);>
{
    pass Clear
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAAClear()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAAClear()));
    }
    
    pass BlendingWeightCalculation
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAABlendingWeightCalculation()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAABlendingWeightCalculation()));
    }
}

technique11 LUTCASSMAA2
{
    pass NeighborhoodBlending
    {
        SetVertexShader(CompileShader(vs_5_0, VS_SMAANeighborhoodBlending()));
        SetPixelShader(CompileShader(ps_5_0, PS_SMAANeighborhoodBlending()));
    }
}

technique11 LUTCASSMAA3
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_Sharpening()));
    }
}

technique11 LUTCASSMAA4
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_ColorGrading()));
    }
}

technique11 LUTCASSMAA5
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_MiscEffects()));
    }
}

technique11 GREENSCREEN <string UIName="Green Screen";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_GreenScreen()));
    }
}

technique11 DEPTHMASK <string UIName="Depth Mask";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_PostProcess()));
        SetPixelShader(CompileShader(ps_5_0, PS_DepthMask()));
    }
}


