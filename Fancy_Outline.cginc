//https://github.com/FancyBearGuy
            uniform float4 _LightColor0;
            uniform float4 _BaseColor;
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Outline_Width;
            uniform float _Farthest_Distance;
            uniform float _Nearest_Distance;
            uniform sampler2D _Outline_Sampler; uniform float4 _Outline_Sampler_ST;
            uniform float4 _Outline_Color;
            uniform fixed _Is_BlendBaseColor;
            uniform fixed _Is_LightColor_Base;
            uniform float _Offset_Z;
            uniform sampler2D _OutlineTex; uniform float4 _OutlineTex_ST;
            uniform fixed _Is_OutlineTex;
            uniform sampler2D _BakedNormal; uniform float4 _BakedNormal_ST;
            uniform fixed _Is_BakedNormal;
#ifdef _IS_OUTLINE_CLIPPING_YES
            uniform sampler2D _ClippingMask; uniform float4 _ClippingMask_ST;
            uniform float _Clipping_Level;
            uniform fixed _Inverse_Clipping;
            uniform fixed _IsBaseMapAlphaAsClippingMask;
#endif
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float2 Set_UV0 = o.uv0;
                float4 _Outline_Sampler_var = tex2Dlod(_Outline_Sampler,float4(TRANSFORM_TEX(Set_UV0, _Outline_Sampler),0.0,0));
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float3x3 tangentTransform = float3x3( o.tangentDir, o.bitangentDir, o.normalDir);
                float4 _BakedNormal_var = (tex2Dlod(_BakedNormal,float4(TRANSFORM_TEX(Set_UV0, _BakedNormal),0.0,0)) * 2 - 1);
                float3 _BakedNormalDir = normalize(mul(_BakedNormal_var.rgb, tangentTransform));
                float Set_Outline_Width = (_Outline_Width*0.001*smoothstep( _Farthest_Distance, _Nearest_Distance, distance(objPos.rgb,_WorldSpaceCameraPos) )*_Outline_Sampler_var.rgb).r;
                float3 viewDirection = _WorldSpaceCameraPos.xyz - o.pos.xyz;
                float4 viewDirectionVP = mul(UNITY_MATRIX_VP, float4(viewDirection.xyz, 1));
                _Offset_Z = _Offset_Z * -0.01;
#ifdef _OUTLINE_NML
               
                o.pos = UnityObjectToClipPos(lerp(float4(v.vertex.xyz + v.normal*Set_Outline_Width,1), float4(v.vertex.xyz + _BakedNormalDir*Set_Outline_Width,1),_Is_BakedNormal));
#elif _OUTLINE_POS
                Set_Outline_Width = Set_Outline_Width*2;
                o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + normalize(v.vertex)*Set_Outline_Width,1) );
#endif
                o.pos.z = o.pos.z + _Offset_Z*viewDirectionVP.z;
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target{
                _Color = _BaseColor;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float2 Set_UV0 = i.uv0;
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(Set_UV0, _MainTex));
                float3 _BaseColorMap_var = (_BaseColor.rgb*_MainTex_var.rgb);
                float3 Set_BaseColor = lerp( _BaseColorMap_var, (_BaseColorMap_var*saturate(_LightColor0.rgb)), _Is_LightColor_Base );
                float3 _Is_BlendBaseColor_var = lerp( _Outline_Color.rgb, (_Outline_Color.rgb*Set_BaseColor*Set_BaseColor), _Is_BlendBaseColor );
                float3 _OutlineTex_var = tex2D(_OutlineTex,TRANSFORM_TEX(Set_UV0, _OutlineTex));
#ifdef _IS_OUTLINE_CLIPPING_NO
                float3 Set_Outline_Color = lerp(_Is_BlendBaseColor_var, _OutlineTex_var.rgb*_Is_BlendBaseColor_var, _Is_OutlineTex );
                return fixed4(Set_Outline_Color,1.0);
#elif _IS_OUTLINE_CLIPPING_YES
                float4 _ClippingMask_var = tex2D(_ClippingMask,TRANSFORM_TEX(Set_UV0, _ClippingMask));
                float Set_MainTexAlpha = _MainTex_var.a;
                float _IsBaseMapAlphaAsClippingMask_var = lerp( _ClippingMask_var.r, Set_MainTexAlpha, _IsBaseMapAlphaAsClippingMask );
                float _Inverse_Clipping_var = lerp( _IsBaseMapAlphaAsClippingMask_var, (1.0 - _IsBaseMapAlphaAsClippingMask_var), _Inverse_Clipping );
                float Set_Clipping = saturate((_Inverse_Clipping_var+_Clipping_Level));
                clip(Set_Clipping - 0.5);
                float4 Set_Outline_Color = lerp( float4(_Is_BlendBaseColor_var,Set_Clipping), float4((_OutlineTex_var.rgb*_Is_BlendBaseColor_var),Set_Clipping), _Is_OutlineTex );
                return Set_Outline_Color;
#endif
            }

