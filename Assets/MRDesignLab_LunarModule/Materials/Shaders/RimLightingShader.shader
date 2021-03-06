﻿Shader "Custom/TransparentFresnel"
{
	Properties
	{
		_MainTex("Texture (rgba)", 2D) = "white" {}
		_InnerColor("Inner Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_RimColor("Rim Color", Color) = (0.26,0.19,0.16,0.0)
		_RimPower("Rim Power", Range(0.5,8.0)) = 3.0
	}
		SubShader
		{
			//Pass{ ColorMask 0 }

			//Tags{ "Queue" = "Transparent" }

			Cull Back
			//Blend One One

			CGPROGRAM
			#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
			float3 viewDir;
		};

		sampler2D _MainTex;
		float4 _InnerColor;
		float4 _RimColor;
		float _RimPower;

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 mainTex = tex2D(_MainTex, IN.uv_MainTex);
			//o.Albedo = _InnerColor.rgb * mainTex.rgb;
			//o.Alpha = mainTex.a;
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _InnerColor.rgb * mainTex.rgb + _RimColor.rgb * pow(rim, _RimPower) * mainTex.a;
		}
		ENDCG
		}
			Fallback "Diffuse"
}