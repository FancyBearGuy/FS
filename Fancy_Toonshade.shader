//https://github.com/FancyBearGuy
Shader "Various/Fancy_Toonshader" {
    Properties {
        [Enum(OFF,0,FRONT,1,BACK,2)] _CullMode("Culling Mode", int) = 2  //OFF/FRONT/BACK
        _MainTex ("MainMap", 2D) = "white" {}
        _BaseColor ("Main Colour", Color) = (1,1,1,1)
        [HideInInspector] _Color ("Color", Color) = (1,1,1,1)
        [MaterialToggle] _Is_LightColor_Base ("Light Colour Base", Float ) = 1
        _1st_ShadeMap ("1st_ShadeTXT", 2D) = "white" {}
        [MaterialToggle] _Use_BaseAs1st ("Use BaseMap as 1st_ShadeMap", Float ) = 0
        _1st_ShadeColor ("First Shade Colour", Color) = (1,1,1,1)
        [MaterialToggle] _Is_LightColor_1st_Shade ("Is_LightColor_1st_Shade", Float ) = 1
        _2nd_ShadeMap ("2nd_ShadeTXT", 2D) = "white" {}
        [MaterialToggle] _Use_1stAs2nd ("Use 1st_ShadeMap as 2nd_ShadeMap", Float ) = 0
        _2nd_ShadeColor ("Second Shade Colour", Color) = (1,1,1,1)
        [MaterialToggle] _Is_LightColor_2nd_Shade ("Is_LightColor_2nd_Shade", Float ) = 1
        _NormalMap ("Normal Map", 2D) = "bump" {}
        [MaterialToggle] _Is_NormalMapToBase ("Normalmap to Base", Float ) = 0
        [MaterialToggle] _Set_SystemShadowsToBase ("Set_SystemShadowsToBase", Float ) = 1
        _Tweak_SystemShadowsLevel ("Tweak_SystemShadowsLevel", Range(-0.5, 0.5)) = 0
        _BaseColor_Step ("Base Colour Step", Range(0, 1)) = 0.5
        _BaseShade_Feather ("Base Feather", Range(0.0001, 1)) = 0.0001
        _ShadeColor_Step ("Shade Colour Step", Range(0, 1)) = 0
        _1st2nd_Shades_Feather ("Second Shade Feather", Range(0.0001, 1)) = 0.0001
        _StepOffset ("Step_Offset (ForwardAdd Only)", Range(-0.5, 0.5)) = 0
        [MaterialToggle] _Is_Filter_HiCutPointLightColor ("PointLights HiCut_Filter (ForwardAdd Only)", Float ) = 1
        _Set_1st_ShadePosition ("Set_1st_ShadePosition", 2D) = "white" {}
        _Set_2nd_ShadePosition ("Set_2nd_ShadePosition", 2D) = "white" {}
        _HighColor ("HighColor", Color) = (0,0,0,1)
        _HighColor_Tex ("HighColor_Tex", 2D) = "white" {}
        [MaterialToggle] _Is_LightColor_HighColor ("Is_LightColor_HighColor", Float ) = 1
        [MaterialToggle] _Is_NormalMapToHighColor ("Is_NormalMapToHighColor", Float ) = 0
        _HighColor_Power ("HighColor_Power", Range(0, 1)) = 0
        [MaterialToggle] _Is_SpecularToHighColor ("Is_SpecularToHighColor", Float ) = 0
        [MaterialToggle] _Is_BlendAddToHiColor ("Is_BlendAddToHiColor", Float ) = 0
        [MaterialToggle] _Is_UseTweakHighColorOnShadow ("Is_UseTweakHighColorOnShadow", Float ) = 0
        _TweakHighColorOnShadow ("TweakHighColorOnShadow", Range(0, 1)) = 0
        _Set_HighColorMask ("Set_HighColorMask", 2D) = "white" {}
        _Tweak_HighColorMaskLevel ("Tweak_HighColorMaskLevel", Range(-1, 1)) = 0
        [MaterialToggle] _RimLight ("RimLight", Float ) = 0
        _RimLightColor ("RimLightColor", Color) = (1,1,1,1)
        [MaterialToggle] _Is_LightColor_RimLight ("Is_LightColor_RimLight", Float ) = 1
        [MaterialToggle] _Is_NormalMapToRimLight ("Is_NormalMapToRimLight", Float ) = 0
        _RimLight_Power ("RimLight_Power", Range(0, 1)) = 0.1
        _RimLight_InsideMask ("RimLight_InsideMask", Range(0.0001, 1)) = 0.0001
        [MaterialToggle] _RimLight_FeatherOff ("RimLight_FeatherOff", Float ) = 0
        [MaterialToggle] _LightDirection_MaskOn ("LightDirection_MaskOn", Float ) = 0
        _Tweak_LightDirection_MaskLevel ("Tweak_LightDirection_MaskLevel", Range(0, 0.5)) = 0
        [MaterialToggle] _Add_Antipodean_RimLight ("Add_Antipodean_RimLight", Float ) = 0
        _Ap_RimLightColor ("Ap_RimLightColor", Color) = (1,1,1,1)
        [MaterialToggle] _Is_LightColor_Ap_RimLight ("Is_LightColor_Ap_RimLight", Float ) = 1
        _Ap_RimLight_Power ("Ap_RimLight_Power", Range(0, 1)) = 0.1
        [MaterialToggle] _Ap_RimLight_FeatherOff ("Ap_RimLight_FeatherOff", Float ) = 0
        _Set_RimLightMask ("Set_RimLightMask", 2D) = "white" {}
        _Tweak_RimLightMaskLevel ("Tweak_RimLightMaskLevel", Range(-1, 1)) = 0
        _Emissive_Tex ("Emissive_Tex", 2D) = "white" {}
        [HDR]_Emissive_Color ("Emissive_Color", Color) = (0,0,0,1)
        _EmissiveBlink_Min ("EmissiveBlink_Min", Float ) = 1
        _EmissiveBlink_Max ("EmissiveBlink_Max", Float ) = 3
        _EmissiveBlink_Velocity ("EmissiveBlink_Velocity", Float ) = 4
        _EmissiveScroll_Direction ("EmissiveScroll_Direction", Vector) = (0, -10, 0, 0)
        _EmissiveScroll_Width ("EmissiveScroll_Width", Float ) = 10
        _EmissiveScroll_Velocity ("EmissiveScroll_Velocity", Float ) = 10
        _EmissiveScroll_Interval ("EmissiveScroll_Interval", Float ) = 20
        [KeywordEnum(NML,POS)] _OUTLINE("OUTLINE MODE", Float) = 0
        _Outline_Width ("Outline_Width", Float ) = 1
        _Farthest_Distance ("Farthest_Distance", Float ) = 10
        _Nearest_Distance ("Nearest_Distance", Float ) = 0.5
        _Outline_Sampler ("Outline_Sampler", 2D) = "white" {}
        _Outline_Color ("Outline_Color", Color) = (0.5,0.5,0.5,1)
        [MaterialToggle] _Is_BlendBaseColor ("Blend Base Colour", Float ) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal xboxone ps4 switch
            #pragma target 3.0
            #pragma multi_compile _IS_OUTLINE_CLIPPING_NO 
            #pragma multi_compile _OUTLINE_NML _OUTLINE_POS
            #include "Fancy_Outline.cginc"
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }

            Cull[_CullMode]
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal xboxone ps4 switch
            #pragma target 3.0

            #pragma multi_compile _IS_CLIPPING_OFF
            #pragma multi_compile _IS_PASS_FWDBASE
            #include "Fancy_Toonshade.cginc"

            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }

            Blend One One
            Cull[_CullMode]
          
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal xboxone ps4 switch
            #pragma target 3.0
            #pragma multi_compile _IS_CLIPPING_OFF
            #pragma multi_compile _IS_PASS_FWDDELTA
            #include "Fancy_Toonshade.cginc"

            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal xboxone ps4 switch
            #pragma target 3.0
            #pragma multi_compile _IS_CLIPPING_OFF
            #include "Fancy_shadowcast.cginc"
            ENDCG
        }
    }
    FallBack "Legacy Shaders/VertexLit"
}
