/* 

 * NaturalVision Evolved by Razed
 * ENBSeries 		     by Boris Vorontsov
 * Modifications		 by icelaglace
 * Using gradient noise  by Jorge Jimenez

 ! Please ask permissions if you want to re-use the shader    !
 ! Please ask permissions if you want to port it to Reshade   !
 ! Credit people properly, thank you, even if it's on the web !

 -- You know who you are. I wouldn't have to type this if you didn't.

 */

bool	vigbool <
	string UIName="Vignetting : Enable";
	string UIWidget="Toggle";
> = true;

bool	horivigbool <
	string UIName="Vignetting : Horizontal Mode";
	string UIWidget="Toggle";
> = false;

bool	flipvigbool <
	string UIName="Vignetting : Flip Axis";
	string UIWidget="Toggle";
> = false;

bool	shadowbool <
	string UIName="Color Shading";
	string UIWidget="Toggle";
> = true;

bool	ditherbool <
	string UIName="Dithering";
	string UIWidget="Toggle";
> = true;

bool	rainbool <
	string UIName = "Rain Drops : Enable";
	string UIWidget = "Slider";
> = true;

float	_RainRefraction <
	string UIName="Rain Drops : Refraction Amount";
	string UIWidget="Slider";
> = {0.25};

float	_RainSmoothness <
	string UIName="Rain Drops : Smoothness";
	string UIWidget="Slider";
> = {0.25};

float	_RainFrequency <
	string UIName="Rain Drops : Frequency";
	string UIWidget="Slider";
> = {2.0f};

float	_RainLifeTime <
	string UIName="Rain Drops : Life Time";
	string UIWidget="Slider";
> = {2.0f};

float	_RainDistortion <
	string UIName="Rain Drops : Distortion";
	string UIWidget="Slider";
> = {0.0f};

int	_RainSize <
	string UIName="Rain Drops : Size";
	string UIWidget="Slider";
> = {10.0f};

float	_RainSpeed <
	string UIName="Rain Drops : Drop Speed";
	string UIWidget="Slider";
> = {10.0f};

float	_RainFallSpeed <
	string UIName = "Rain Drops : Fall Speed";
	string UIWidget = "Slider";
> = { 5.0f };

float	_RainIntensity <
	string UIName="Rain Drops : Color";
	string UIWidget="Slider";
> = {0.9f};

float	_RainCenterIntensity <
	string UIName="Rain Drops : Edge Intensity";
	string UIWidget="Slider";
> = {2.0f};

float	_RainCenterSharpness <
	string UIName="Rain Drops : Edge Sharpness";
	string UIWidget="Slider";
> = {1.0f};


//+++++++++++++++++++++++++++++
//external enb parameters, do not modify
//+++++++++++++++++++++++++++++
//x = generic timer in range 0..1, period of 16777216 ms (4.6 hours), y = average fps, w = frame time elapsed (in seconds)
float4	Timer;
//x = Width, y = 1/Width, z = aspect, w = 1/aspect, aspect is Width/Height
float4	ScreenSize;
//changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float	AdaptiveQuality;
//x = current weather index, y = outgoing weather index, z = weather transition, w = time of the day in 24 standart hours. Weather index is value from weather ini file, for example WEATHER002 means index==2, but index==0 means that weather not captured.
float4	Weather;
//x = dawn, y = sunrise, z = day, w = sunset. Interpolators range from 0..1
float4	TimeOfDay1;
//x = dusk, y = night. Interpolators range from 0..1
float4	TimeOfDay2;
//changes in range 0..1, 0 means that night time, 1 - day time
float	ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float	EInteriorFactor;

//+++++++++++++++++++++++++++++
//external enb debugging parameters for shader programmers, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables. Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
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
float4	tempInfo1;
// xy = cursor position of previous left mouse button click
// zw = cursor position of previous right mouse button click
float4	tempInfo2;
#if 0
#include "NVEDebug.fx"
#endif
//+++++++++++++++++++++++++++++
//game and mod parameters, do not modify
//+++++++++++++++++++++++++++++
//x - bloom amount; y - lens amount
float4				ENBParams01; //enb parameters
Texture2D           TextureNoise <string ResourceName = "ns.png";>; 
Texture2D			TextureColor; //hdr color
Texture2D			TextureBloom; //vanilla or enb bloom
Texture2D			TextureLens; //enb lens fx
Texture2D			TextureDepth; //scene depth
Texture2D			TextureAdaptation; //vanilla or enb adaptation
Texture2D			TextureAperture; //this frame aperture 1*1 R32F hdr red channel only. computed in depth of field shader file

SamplerState		Sampler0
{
	Filter = MIN_MAG_MIP_POINT;//MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};

SamplerState		Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};

SamplerState		Sampler2
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Mirror;
	AddressV = Mirror;
};
//+++++++++++++++++++++++++++++
//
//+++++++++++++++++++++++++++++
struct VS_INPUT_POST
{
	float3 pos		: POSITION;
	float2 txcoord	: TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos		: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
};

//+++++++++++++++++++++++++++++
//GTA 5 parameters
//+++++++++++++++++++++++++++++
cbuffer postfx_cbuffer : register(b5)
{
	float4 dofProj : packoffset(c0);
	float4 dofShear : packoffset(c1);
	float4 dofDist : packoffset(c2);
	float4 hiDofParams : packoffset(c3);
	float4 hiDofMiscParams : packoffset(c4);
	float4 PostFXAdaptiveDofEnvBlurParams : packoffset(c5);
	float4 PostFXAdaptiveDofCustomPlanesParams : packoffset(c6);
	float4 BloomParams : packoffset(c7);
	float4 Filmic0 : packoffset(c8);
	float4 Filmic1 : packoffset(c9);
	float4 BrightTonemapParams0 : packoffset(c10);
	float4 BrightTonemapParams1 : packoffset(c11);
	float4 DarkTonemapParams0 : packoffset(c12);
	float4 DarkTonemapParams1 : packoffset(c13);
	float2 TonemapParams : packoffset(c14);
	float4 NoiseParams : packoffset(c15);
	float4 DirectionalMotionBlurParams : packoffset(c16);
	float4 DirectionalMotionBlurIterParams : packoffset(c17);
	float4 MBPrevViewProjMatrixX : packoffset(c18);
	float4 MBPrevViewProjMatrixY : packoffset(c19);
	float4 MBPrevViewProjMatrixW : packoffset(c20);
	float3 MBPerspectiveShearParams0 : packoffset(c21);
	float3 MBPerspectiveShearParams1 : packoffset(c22);
	float3 MBPerspectiveShearParams2 : packoffset(c23);
	float lowLum : packoffset(c23.w);
	float highLum : packoffset(c24);
	float topLum : packoffset(c24.y);
	float scalerLum : packoffset(c24.z);
	float offsetLum : packoffset(c24.w);
	float offsetLowLum : packoffset(c25);
	float offsetHighLum : packoffset(c25.y);
	float noiseLum : packoffset(c25.z);
	float noiseLowLum : packoffset(c25.w);
	float noiseHighLum : packoffset(c26);
	float bloomLum : packoffset(c26.y);
	float4 colorLum : packoffset(c27);
	float4 colorLowLum : packoffset(c28);
	float4 colorHighLum : packoffset(c29);
	float4 HeatHazeParams : packoffset(c30);
	float4 HeatHazeTex1Params : packoffset(c31);
	float4 HeatHazeTex2Params : packoffset(c32);
	float4 HeatHazeOffsetParams : packoffset(c33);
	float4 LensArtefactsParams0 : packoffset(c34);
	float4 LensArtefactsParams1 : packoffset(c35);
	float4 LensArtefactsParams2 : packoffset(c36);
	float4 LensArtefactsParams3 : packoffset(c37);
	float4 LensArtefactsParams4 : packoffset(c38);
	float4 LensArtefactsParams5 : packoffset(c39);
	float4 LightStreaksColorShift0 : packoffset(c40);
	float4 LightStreaksBlurColWeights : packoffset(c41);
	float4 LightStreaksBlurDir : packoffset(c42);
	float4 globalFreeAimDir : packoffset(c43);
	float4 globalFogRayParam : packoffset(c44);
	float4 globalFogRayFadeParam : packoffset(c45);
	float4 lightrayParams : packoffset(c46);
	float4 lightrayParams2 : packoffset(c47);
	float4 seeThroughParams : packoffset(c48);
	float4 seeThroughColorNear : packoffset(c49);
	float4 seeThroughColorFar : packoffset(c50);
	float4 seeThroughColorVisibleBase : packoffset(c51);
	float4 seeThroughColorVisibleWarm : packoffset(c52);
	float4 seeThroughColorVisibleHot : packoffset(c53);
	float4 debugParams0 : packoffset(c54);
	float4 debugParams1 : packoffset(c55);
	float PLAYER_MASK : packoffset(c56);
	float4 VignettingParams : packoffset(c57);
	float4 VignettingColor : packoffset(c58);
	float4 GradientFilterColTop : packoffset(c59);
	float4 GradientFilterColBottom : packoffset(c60);
	float4 GradientFilterColMiddle : packoffset(c61);
	float4 DamageOverlayMisc : packoffset(c62);
	float4 ScanlineFilterParams : packoffset(c63);
	float ScreenBlurFade : packoffset(c64);
	float4 ColorCorrectHighLum : packoffset(c65);
	float4 ColorShiftLowLum : packoffset(c66);
	float Desaturate : packoffset(c67);
	float Gamma : packoffset(c67.y);
	float4 LensDistortionParams : packoffset(c68);
	float4 DistortionParams : packoffset(c69);
	float4 BlurVignettingParams : packoffset(c70);
	float4 BloomTexelSize : packoffset(c71);
	float4 TexelSize : packoffset(c72);
	float4 GBufferTexture0Param : packoffset(c73);
	float2 rcpFrame : packoffset(c74);
	float4 sslrParams : packoffset(c75);
	float3 sslrCenter : packoffset(c76);
	float4 ExposureParams0 : packoffset(c77);
	float4 ExposureParams1 : packoffset(c78);
	float4 ExposureParams2 : packoffset(c79);
	float4 ExposureParams3 : packoffset(c80);
	float4 LuminanceDownsampleOOSrcDstSize : packoffset(c81);
	float4 QuadPosition : packoffset(c82);
	float4 QuadTexCoords : packoffset(c83);
	float4 QuadScale : packoffset(c84);
	float4 BokehBrightnessParams : packoffset(c85);
	float4 BokehParams1 : packoffset(c86);
	float4 BokehParams2 : packoffset(c87);
	float2 DOFTargetSize : packoffset(c88);
	float2 RenderTargetSize : packoffset(c88.z);
	float BokehGlobalAlpha : packoffset(c89);
	float BokehAlphaCutoff : packoffset(c89.y);
	bool BokehEnableVar : packoffset(c89.z);
	float BokehSortLevel : packoffset(c89.w);
	float BokehSortLevelMask : packoffset(c90);
	float BokehSortTransposeMatWidth : packoffset(c90.y);
	float BokehSortTransposeMatHeight : packoffset(c90.z);
	float currentDOFTechnique : packoffset(c90.w);
	float4 fpvMotionBlurWeights : packoffset(c91);
	float3 fpvMotionBlurVelocity : packoffset(c92);
	float fpvMotionBlurSize : packoffset(c92.w);
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST	VS_Draw(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST	OUT;
	float4	pos;
	pos.xyz=IN.pos.xyz;
	pos.w=1.0;
	OUT.pos=pos;
	OUT.txcoord0.xy=IN.txcoord.xy;
	return OUT;
}

float4	PS_Draw(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	// Should display red as in : you enabled something wrong.
	return float4(1.0,0.0,0.0,1.0);
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Vanilla post process. Do not modify
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
float4	PS_DrawOriginal(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4	r0, r1, r2, r3, r4, r5, r6, t0, t1;
	float4	res;
	r0 = TextureColor.Sample(Sampler1, IN.txcoord0.xy);
	r1.xy = _RainSize;
	r1.zw = r1.xy * IN.txcoord0.xy;	
	r1.w = (r1.w / ScreenSize.z) - (Timer.x * 1000.0 * _RainFallSpeed);
	r5.x = length(IN.txcoord0 - 0.5) * _RainCenterIntensity;
	r5.x = pow(r5.x, _RainCenterSharpness);
	r6.xy = round(r1.zw - 0.25) / r1.xy; 
	r4 = TextureNoise.Sample(Sampler2, r6.xy);
	r6.xy = (TextureNoise.Sample(Sampler2, IN.txcoord0.xy).yz - 1) * _RainDistortion;
	r6.zw = r1.zw * 6.295 + r6.xy;
    r1.xy = sin(r6.zw) - frac(Timer.x * (1000 * _RainSpeed) * (r4.z + 0.1) + r4.y) * _RainLifeTime;
    r4.w = smoothstep(0.751 + _RainSmoothness, 0.75, (r1.x + r1.y) * r5.x - (r4.x * _RainFrequency));
	r1.xyz = TextureColor.Sample(Sampler2, IN.txcoord0 + cos(r6.zw) * _RainRefraction) * _RainIntensity;
	r0.xyz = GradientFilterColBottom.x >= 2.0 && rainbool ? lerp(r0.xyz, r1.xyz, saturate(1.0 - r4.w)) : r0.xyz;
	r4 = TextureLens.Sample(Sampler1, IN.txcoord0.xy);
	r0.xyz = r0.xyz + r4.xyz;
	r4 = TextureBloom.Sample(Sampler1, IN.txcoord0.xy);
	r4.xyz = r4.xyz - r0.xyz;
	r4.xyz = max(r4, 0.0);
	r0.xyz = r0.xyz + r4.xyz * ENBParams01.x;
	r6.w = saturate(1.0 - dot(r0,0.333));
    r6.w = pow(r6.w,12.60);
    r6.xyz = saturate(float3(0.6,0.2,1.1) * (BokehParams1.y * 1000.0));
    r6.xyz = r6.xyz * r6.w;
	r6.w = GradientFilterColMiddle.x;
	r5 = TextureAdaptation.Sample(Sampler0, IN.txcoord0.xy);
	r1.xy = IN.txcoord0.xy - 0.5;
	r0.w = dot(r1.xy, r1.xy);
	r0.w = 1.00 - r0.w;
	r0.w = log2(r0.w);
	r0.w = VignettingParams.y * r0.w;
	r0.w = exp2(r0.w);
	r0.w = saturate(VignettingParams.x + r0.w);
	r0.w = saturate(VignettingParams.z * r0.w);
	r5.w = horivigbool ? IN.txcoord0.x : IN.txcoord0.y;
	r5.w = flipvigbool ? 1.0 - r5.w : r5.w;
	r1.xyz = float3(1.0, 1.0, 1.0) - VignettingColor.xyz;
	r4.w = dot(r5.w + 0.1, 0.65) / 0.4225;
	r4.w = smoothstep(0, ScanlineFilterParams.y, r4.w);
	r4.w = vigbool ? r4.w * r0.w : r0.w;
	r1.xyz = r4.w * r1.xyz + VignettingColor.xyz;
	r0.xyz = r1.xyz * r0.xyz;
	r0.xyz = min(float3(65504.0, 65504.0, 65504.0), r0.xyz);
	t0 = DarkTonemapParams0; t1 = DarkTonemapParams1;
	r0.w = saturate(r5.y * TonemapParams.x + TonemapParams.y);
	if (r6.w >= 1.1) {
	t0 = float4(6.0, 0.97, 0.468, 2.82);
	t1 = float4( 0.02, 0.1, 5.0, 0.0);}
	else if (r6.w >= 2.1) {
	t0 = float4(7.4, 1.2, 14.8, 12.2);
	t1 = float4( -12.0, 0.22, 5.0, 0.0);}
	else if (r6.w >= 3.1) {
	t0 = float4(2.8, 1.75, 14.8, 12.2);
	t1 = float4( -11.0, 0.07, 5.0, 0.0); }
	else if (r6.w >= 4.1) {
	t0 = float4(70.0, 5.28, 1.6, 2.2);
	t1 = float4( 5.0, 0.95, 5.0, 0.0); }
	else if (r6.w >= 5.1) {
	t0 = float4(384.0, 1.68, 2.68, 3.2);
	t1 = float4( 1.0, 1.4, 5.0, 0.0); }
	r1.xyzw = t0.xyzw - BrightTonemapParams0.xyzw;
	r1.xyzw = r0.w * r1.xyzw + BrightTonemapParams0.xyzw;
	r2.xyz = t1.zxy - BrightTonemapParams1.zxy;
	r2.xyz = r0.w * r2.xyz + BrightTonemapParams1.zxy;
	r3.xy = r2.yz * r1.w;
	r0.w = r1.z * r1.y;
	r1.z = r1.x * r2.x + r0.w;
	r1.z = r2.x * r1.z + r3.x;
	r1.w = r1.x * r2.x + r1.y;
	r1.w = r2.x * r1.w + r3.y;
	r1.z = r1.z / r1.w;
	r1.w = r2.y / r2.z;
	r1.z = r1.z - r1.w;
	r1.z = 1.0 / r1.z;
	r0.xyz = r5.x * r0.xyz;
    r2.xy = ScreenSize.x;
    r2.y = r2.y / ScreenSize.z;
    r2.xy = IN.txcoord0 * r2.xy;
    r2.z = frac(52.9829189 * frac(dot(r2.xy, float2(0.06711056,0.00583715))));
	r0.xyz = sqrt(r0.xyz);
	r0.xyz = ditherbool ? r0.xyz + float3(r2.z, 1.0 - r2.z, r2.z) / 255.0f : r0.xyz;
	r0.xyz = r0.xyz * r0.xyz;
    r0.xyz = shadowbool ? r0.xyz + saturate(r6.xyz) : r0.xyz;
    r0.xyz *= (1.0f + r0.xyz / (4.0f)) / (1.0f + r0.xyz);
	r0.xyz = max(float3(0.0, 0.0, 0.0), r0.xyz);
	r2.xyz = r1.xxx * r0.xyz + r0.w;
	r2.xyz = r0.xyz * r2.xyz + r3.x;
	r3.xzw = r1.xxx * r0.xyz + r1.y;
	r0.xyz = r0.xyz * r3.xzw + r3.y;
	r0.xyz = r2.xyz / r0.xyz;
	r0.xyz = r0.xyz - r1.w;
	r0.xyz = saturate(r0.xyz * r1.z);
	r0.w = dot(r0.xyz, float3(0.2125, 0.7154, 0.0721));
	r0.xyz = r0.xyz - r0.w;
	r0.xyz = Desaturate * r0.xyz + r0.w;
	r1.x = saturate(r0.w / ColorShiftLowLum.w);
	r1.yzw = -ColorShiftLowLum.xyz + ColorCorrectHighLum.xyz;
	r1.xyz = r1.xxx * r1.yzw + ColorShiftLowLum.xyz;
	r2.xyz = r1.xyz * r0.xyz;
	r1.w = 1.0 - ColorCorrectHighLum.w;
	r0.w = -r1.w + r0.w;
	r1.w = 1.0 - r1.w;
	r1.w = max(0.01, r1.w);
	r0.w = saturate(r0.w / r1.w);
	r0.xyz = -r0.xyz * r1.xyz + r0.xyz;
	r0.xyz = saturate(r0.w * r0.xyz + r2.xyz);
	r0.xyz = log2(r0.xyz);
	r0.xyz = Gamma * r0.xyz;
	r0.xyz = exp2(r0.xyz);
	r0.xyz = (r0.xyz - 0.5) * 1.06 + 0.5;
    r0.xyz = r0.xyz * 0.94;
	res.xyz = r0.xyz;
	res.w=1.0;
	return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//techniques
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
technique11 Draw <string UIName="ENBSeries";>
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_Draw()));
	}
}



technique11 ORIGINALPOSTPROCESS <string UIName="Vanilla";> //do not modify this technique
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_DrawOriginal()));
	}
}


