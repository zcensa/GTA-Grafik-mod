#define Red_Green_Blue float3

void ColorCorrection(int ppfx_preset                        ,
                    inout float  Levels_Input_Black         ,
                    inout float  Levels_Input_White         ,
                    inout float  Levels_Output_Black        ,
                    inout float  Levels_Output_White        ,
                    inout float3 Color_Balance_Shadows      ,
                    inout float3 Color_Balance_Highlights   ,
                    inout float3 ChannelMixer_Red           ,
                    inout float3 ChannelMixer_Green         ,
                    inout float3 ChannelMixer_Blue          ,
                    inout float  Color_Temperature_Strength ,
                    inout float  Color_Temperature_Kelvin   ,
                    inout float  Gamma                      ,
                    inout float  Brightness                 ,
                    inout float  Contrast                   ,
                    inout float  Saturation                 ,
                    inout float  Bleach_Bypass              )
{
    switch (ppfx_preset)
    {
    case 1:
        // Neutral base
        Levels_Input_Black        = 0;
        Levels_Input_White        = 1;
        Levels_Output_Black       = 0;
        Levels_Output_White       = 1;
        Color_Balance_Shadows     = Red_Green_Blue(0.5,0.5,0.5);
        Color_Balance_Highlights  = Red_Green_Blue(0.5,0.5,0.5);
        ChannelMixer_Red          = Red_Green_Blue(1,0,0);
        ChannelMixer_Green        = Red_Green_Blue(0,1,0);
        ChannelMixer_Blue         = Red_Green_Blue(0,0,1);
        Color_Temperature_Strength= 1;
        Color_Temperature_Kelvin  = 6500;
        Gamma                     = 1;
        Brightness                = 1;
        Contrast                  = 1;
        Saturation                = 1;
        Bleach_Bypass             = 0;
        break;
    case 2:
        // icelaglace : B&W Contrast
        Levels_Input_Black        = 0.05;
        Levels_Input_White        = 0.9;
        Levels_Output_Black       = 0;
        Levels_Output_White       = 0.95;
        Color_Balance_Shadows     = Red_Green_Blue(0.5,0.5,0.5);
        Color_Balance_Highlights  = Red_Green_Blue(0.5,0.5,0.5);
        ChannelMixer_Red          = Red_Green_Blue(1,0,0);
        ChannelMixer_Green        = Red_Green_Blue(0,1,0);
        ChannelMixer_Blue         = Red_Green_Blue(0,0,1);
        Color_Temperature_Strength= 1;
        Color_Temperature_Kelvin  = 7500;
        Gamma                     = 0.7;
        Brightness                = 1;
        Contrast                  = 0.9;
        Saturation                = 0;
        Bleach_Bypass             = 1;
        break;
    case 3:
        Levels_Input_Black        = 0;
        Levels_Input_White        = 0;
        Levels_Output_Black       = 0;
        Levels_Output_White       = 1;
        Color_Balance_Shadows     = Red_Green_Blue(0.5,0.5,0.5);
        Color_Balance_Highlights  = Red_Green_Blue(0.5,0.5,0.5);
        ChannelMixer_Red          = Red_Green_Blue(1,0,0);
        ChannelMixer_Green        = Red_Green_Blue(0,1,0);
        ChannelMixer_Blue         = Red_Green_Blue(0,0,1);
        Color_Temperature_Strength= 1;
        Color_Temperature_Kelvin  = 6500;
        Gamma                     = 1;
        Brightness                = 1;
        Contrast                  = 1;
        Saturation                = 1;
        Bleach_Bypass             = 0;
        break;
    default:
        break;
    }
    
}