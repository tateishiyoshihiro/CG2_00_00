#include "Object3d.hlsli"
struct Material
{
    float1x4 color;
};
ConstantBuffer<Material> gMaterial : register(b0);
Texture2D<float32_t4> gTexture : register(t0);
SamplerState gSampler : register(s0);

struct PixelShaderOutput
{
    float4 color : SV_TARGET0;
};
PixelShaderOutput main(VertexShaderOutput input)
{
    PixelShaderOutput output;
    float32_t4 texturColor = gTexture.Sample(gSampler, input.texcoord);
    output.color = gMaterial.color * texturColor;
    if (output.color.a == 0.0)
    {
        discard;
    }
    output.color = gMaterial.color * texturColor;
        return output;
}