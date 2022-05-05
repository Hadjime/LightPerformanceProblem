Shader "TakeTop/DiffuseEmission"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _EmissiveMap("Emissive Map", 2D) = "white" {}
        [HDR] _EmissionColor("Glow Color", Color) = (1,1,1,1)
        _Curvature("Curvature", Float) = 0.001
    }

    SubShader
    {
        Lighting On

        Material
        {
            Emission[_EmissionColor]
        }

        Pass
        {
            SetTexture[_MainTex]{ combine texture }
            SetTexture[_EmissiveMap]{ combine primary lerp(texture) previous }
        }

        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert addshadow

        sampler2D _MainTex;
        sampler2D _EmissiveMap;
        fixed4 _EmissionColor;
        float _Curvature;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_EmissiveMap;
        };

        void vert( inout appdata_full v)
        {
            float4 vv = mul( unity_ObjectToWorld, v.vertex );
            vv.xyz -= _WorldSpaceCameraPos.xyz;
            vv = float4(0.0f, (vv.z * vv.z) * - _Curvature, 0.0f, 0.0f );
            v.vertex += mul(unity_WorldToObject, vv);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);
            half4 e = tex2D(_EmissiveMap, IN.uv_EmissiveMap) * _EmissionColor;
            o.Albedo = c.rgb += e.rgb;
        }
        ENDCG
    }
}
