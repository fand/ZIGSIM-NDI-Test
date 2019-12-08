Shader "Unlit/NDI"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RgbOrAlpha ("RGB or Alpha", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _RgbOrAlpha;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                col = sqrt(col); // fix gamma

                fixed4 rgb = fixed4(col.rgb, 1);
                fixed4 alpha = fixed4(0, 0, 0, 0) + col.a;

                return lerp(rgb, alpha, _RgbOrAlpha);
            }
            ENDCG
        }
    }
}
