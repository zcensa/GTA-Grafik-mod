/* 

 * NaturalVision Evolved           by Razed
 * ENBSeries & original flare code by Boris Vorontsov
 * Lens flare & anamorphic code    by icelaglace 
 * Downscaled offsets              from COD:AW paper

 ! Please ask permissions if you want to re-use the shader    !
 ! Credit people properly, thank you, even if it's on the web !

 -- You know who you are. I wouldn't have to type this if you didn't.

 */

float  LensBlurSize
<
    string UIName = "Lens Blur Size";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {2.0};

float  LensPower
<
    string UIName = "Lens Intensity";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float  LensScale
<
    string UIName = "Lens Scale";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};


float  AnamorphicBlurSize
<
    string UIName = "Anamorphic Blur Size";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {2.0};

float  AnamorphicStretch
<
    string UIName = "Anamorphic Stretch";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float  AnamorphicIntensity
<
    string UIName = "Anamorphic Intensity";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float3   AnamorphicColor
<
    string UIName="Anamorphic Color";
    string UIWidget="color";
> = {1,1,1};

bool    AnamorphicHorizontal        
<
    string UIName="Click to enable Horizontal Anamorphic";
> = {false};

float  DirtAmount
<
    string UIName = "Dirt Texture Amount";
    string UIWidget = "spinner";
    float UIMin=0.0;
    float UIMax=10.0;
> = {1.0};

float3   Lens1A
<
    string UIName="Flare 1 : Shape control";
    string UIWidget="vector";
> = {10,1,1};

float3   Lens1C
<
    string UIName="Flare 1 : Color control";
    string UIWidget="color";
> = {1,0.3,1};


float3   Lens2A
<
    string UIName="Flare 2 : Shape control";
    string UIWidget="vector";
> = {100,1,2};

float3   Lens2C
<
    string UIName="Flare 2 : Color control";
    string UIWidget="color";
> = {1,1,0.3};

float3   Lens3A
<
    string UIName="Flare 3 : Shape control";
    string UIWidget="vector";
> = {1,1,1};

float3   Lens3C
<
    string UIName="Flare 3 : Color control";
    string UIWidget="color";
> = {1,1,1};


float3   Lens4A
<
    string UIName="Flare 4 : Shape control";
    string UIWidget="vector";
> = {100,10,1};

float3   Lens4C
<
    string UIName="Flare 4 : Color control";
    string UIWidget="color";
> = {1,1,1};


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
Texture2D           TextureDownsampled; //color R16B16G16A16 64 bit or R11G11B10 32 bit hdr format. 1024*1024 size
Texture2D           TextureColor; //color which is output of previous technique (except when drawed to temporary render target), R16B16G16A16 64 bit hdr format. screen size

Texture2D           TextureOriginal; //color R16B16G16A16 64 bit or R11G11B10 32 bit hdr format, screen size. PLEASE AVOID USING IT BECAUSE OF ALIASING ARTIFACTS, UNLESS YOU FIX THEM
Texture2D           TextureDepth; //scene depth R32F 32 bit hdr format, screen size. PLEASE AVOID USING IT BECAUSE OF ALIASING ARTIFACTS, UNLESS YOU FIX THEM
Texture2D           TextureAperture; //this frame aperture 1*1 R32F hdr red channel only. computed in PS_Aperture of enbdepthoffield.fx
Texture2D           TextureDirt <string ResourceName = "NVE_Texture.png";>; 

//temporary textures which can be set as render target for techniques via annotations like <string RenderTarget="RenderTargetRGBA32";>
Texture2D           RenderTarget1024; //R16B16G16A16F 64 bit hdr format, 1024*1024 size
Texture2D           RenderTarget512; //R16B16G16A16F 64 bit hdr format, 512*512 size
Texture2D           RenderTarget256; //R16B16G16A16F 64 bit hdr format, 256*256 size
Texture2D           RenderTarget128; //R16B16G16A16F 64 bit hdr format, 128*128 size
Texture2D           RenderTarget64; //R16B16G16A16F 64 bit hdr format, 64*64 size
Texture2D           RenderTarget32; //R16B16G16A16F 64 bit hdr format, 32*32 size
Texture2D           RenderTarget16; //R16B16G16A16F 64 bit hdr format, 16*16 size
Texture2D           RenderTargetRGBA32; //R8G8B8A8 32 bit ldr format, screen size
Texture2D           RenderTargetRGBA64F; //R16B16G16A16F 64 bit hdr format, screen size

SamplerState        Sampler0
{
    Filter = MIN_MAG_MIP_POINT;
    AddressU = Clamp;
    AddressV = Clamp;
};
SamplerState        Sampler1
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

//+++++++++++++++++++++++++++++
//
//+++++++++++++++++++++++++++++
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

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

VS_OUTPUT_POST  VS_Quad(VS_INPUT_POST IN)
{
    VS_OUTPUT_POST  OUT;
    float4  pos;
    pos.xyz=IN.pos.xyz;
    pos.w=1.0;
    OUT.pos=pos;
    OUT.txcoord0.xy=IN.txcoord.xy;
    return OUT;
}

// "Next Generation Post processing in Call of Duty: Advanced Warfare" - 2014
static float2 blurOffsets[9] =
{
    float2(-1.0f,  1.0f),
    float2( 0.0f,  1.0f),
    float2( 1.0f,  1.0f),
    float2(-1.0f,  0.0f),
    float2( 0.0f,  0.0f),
    float2( 1.0f,  0.0f),
    float2(-1.0f, -1.0f),
    float2( 0.0f, -1.0f),
    float2( 1.0f, -1.0f)
};

static float blurWeights[9] =
{
    0.0625f,
    0.1250f,
    0.0625f,
    0.1250f,
    0.2500f,
    0.1250f,
    0.0625f,
    0.1250f,
    0.0625f
};

static float blurAnamorphic[6] =
{
    -5.0f,
    -3.0f,
    -1.0f,
     1.0f,
     3.0f,
     5.0f
};

float4  PS_Downscale(VS_OUTPUT_POST IN, uniform Texture2D tex, uniform float pixelsize) : SV_Target
{
    float3 color = 0.0f;

    for (int i = 0; i < 9; i++)
    {
        color += tex.Sample(Sampler1, IN.txcoord0.xy + blurOffsets[i] * (LensBlurSize / pixelsize)) * blurWeights[i];
    }

    return float4(color, 1.0f);
}

float4  PS_Downscale2(VS_OUTPUT_POST IN, uniform Texture2D tex, uniform float pixelsize) : SV_Target
{
    float3 color = 0.0f;

    for (int i = 0; i < 9; i++)
    {
        color += tex.Sample(Sampler1, IN.txcoord0.xy + blurOffsets[i] * (AnamorphicBlurSize / pixelsize)) * blurWeights[i];
    }

    return float4(color, 1.0f);
}


float4 PS_AnamorphicCreate(VS_OUTPUT_POST IN, uniform Texture2D tex, uniform float texsize, uniform float blursize) : SV_Target
{
    float3 color = 0.0f;

    for (int i = 0; i < 6; i++)
    {
        if (AnamorphicHorizontal) color.xyz += tex.Sample(Sampler1, float2(IN.txcoord0.x + (blurAnamorphic[i] * ((1.0 / texsize) * blursize * AnamorphicStretch)), IN.txcoord0.y));
        else                      color.xyz += tex.Sample(Sampler1, float2(IN.txcoord0.x, IN.txcoord0.y + (blurAnamorphic[i] * ((1.0 / texsize) * blursize * AnamorphicStretch))));
    }

    color.xyz /= 6.0f;
    
    return float4(color.xyz, 1);
}

float4  PS_DrawSkyrimLens(VS_OUTPUT_POST IN) : SV_Target
{
    float4 res = 0.0f;
    float2 coord;

    const float3 offset[4]=
    {
        Lens1A,
        Lens2A,
        Lens3A,
        Lens4A
    };
    
    const float3 factors[4]=
    {
        Lens1C,
        Lens2C,
        Lens3C,
        Lens4C
    };

    for (int i = 0; i < 4; i++)
    {
        float2 distfact= (IN.txcoord0.xy-0.5f);
        coord.xy  = offset[i].x * distfact;
        coord.xy *= pow(LensScale * length(float2(distfact.x*ScreenSize.z,distfact.y)), offset[i].y);
        coord.xy *= offset[i].z;
        coord.xy  = 0.5f - coord.xy;

        float3 templens = RenderTarget128.Sample(Sampler1, coord.xy).xyz;
               templens = templens*factors[i];

        distfact = (coord.xy - 0.5f) * 2.0f;
        templens *= saturate(1.0f - dot(distfact, distfact));

        res.xyz  += templens;
    }
   
    res.xyz *= 0.25f * LensPower;

    return res;
}

float4 PS_PresentAnamorphic(VS_OUTPUT_POST IN) : SV_Target
{
    float2 coord  = IN.txcoord0.xy;
    float3 color  = RenderTarget256.Sample(Sampler1, coord) / 16.0f;
           color *= AnamorphicIntensity;
           color *= AnamorphicColor;

    coord.y /= ScreenSize.z * 0.75f;

    float dirt = TextureDirt.Sample(Sampler1, coord.xy).y;
    color.xyz += saturate((dirt * color) * DirtAmount);

    return float4(color, 1.0f);
}

float4 PS_PresentLens(VS_OUTPUT_POST IN) : SV_Target
{
    float2 coord  = IN.txcoord0.xy;
    float3 color  = TextureColor.Sample(Sampler1, coord);

    coord.y /= ScreenSize.z * 0.75f;

    float dirt = TextureDirt.Sample(Sampler1, coord.xy).y;
    color.xyz += saturate((dirt * color) * DirtAmount);

    return float4(color, 1.0f);
}

float4 PS_PresentBoth(VS_OUTPUT_POST IN) : SV_Target
{
    float2 coord  = IN.txcoord0.xy;
    float3 lens   = TextureColor.Sample(Sampler1, coord).xyz;
    float3 color  = RenderTarget256.Sample(Sampler1, coord).xyz / 16.0f;
           color *= AnamorphicIntensity;
           color *= AnamorphicColor;

    color += lens;

    coord.y /= ScreenSize.z * 0.75f;

    float dirt = TextureDirt.Sample(Sampler1, coord.xy).y;
    color.xyz += saturate((dirt * color) * DirtAmount);

    return float4(color, 1.0f);
}


technique11 SkyrimLens <string UIName="Lens Flare"; string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale(TextureDownsampled,512)));
    }
}

technique11 SkyrimLens1 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale(RenderTarget512, 256.0)));
    }
}

technique11 SkyrimLens2 <string RenderTarget="RenderTarget128";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale(RenderTarget256, 128.0)));
    }
}

technique11 SkyrimLens3
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_DrawSkyrimLens()));
    }
}

technique11 SkyrimLens4
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_PresentLens()));
    }
}


technique11 Anamorphic <string UIName="Anamorphic Flare"; string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale2(TextureDownsampled, 512)));
    }
}

technique11 Anamorphic1 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget512, 256,2)));
    }
}

technique11 Anamorphic2 <string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget256, 512,3)));
    }
}

technique11 Anamorphic3 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget512, 256,4)));
    }
}

technique11 Anamorphic4 <string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget256, 512,5)));
    }
}

technique11 Anamorphic5 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget512, 256,6)));
    }
}

technique11 Anamorphic6
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_PresentAnamorphic()));
    }
}

//

technique11 BothLens <string UIName="Lens + Anamorphic"; string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale(TextureDownsampled,512)));
    }
}

technique11 BothLens1 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale(RenderTarget512, 256.0)));
    }
}

technique11 BothLens2 <string RenderTarget="RenderTarget128";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale(RenderTarget256, 128.0)));
    }
}


technique11 BothLens3 <string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_Downscale2(TextureDownsampled, 512)));
    }
}

technique11 BothLens4 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget512, 256,2)));
    }
}

technique11 BothLens5 <string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget256, 512,3)));
    }
}

technique11 BothLens6 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget512, 256,4)));
    }
}

technique11 BothLens7 <string RenderTarget="RenderTarget512";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget256, 512,5)));
    }
}

technique11 BothLens8 <string RenderTarget="RenderTarget256";>
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_AnamorphicCreate(RenderTarget512, 256,6)));
    }
}

technique11 BothLens9
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_DrawSkyrimLens()));
    }
}

technique11 BothLens10
{
    pass p0
    {
        SetVertexShader(CompileShader(vs_5_0, VS_Quad()));
        SetPixelShader(CompileShader(ps_5_0, PS_PresentBoth()));
    }
}
