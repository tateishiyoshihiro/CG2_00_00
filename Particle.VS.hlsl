﻿#include "Particle.hlsli"
struct TransfomationMatrix
{
    float32_t4x4 WVP;
};
StructuredBuffer<TransfomationMatrix> gTransformationMatrix : register(b0);

struct VertexShaderInput
{
    float32_t4 position : POSITION0;
    float32_t2 texcoord : TEXCOORD0;
};
VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
    output.position = mul(input.position, gTransformationMatrix.WVP);
    output.texcoord = input.texcoord;
    return output;
}

float4 main( float4 pos : POSITION ) : SV_POSITION
{
	return pos;
}