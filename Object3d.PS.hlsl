
struct Material {
	float32_t4 color;
};
ConstantBuffer<Material>gMaterial:register(b0);
struct PixelShaderOutput {
	float32_t4 color : SV_TARGET0;
};
Texture2D<float32_t4> gTexture : register(t0);
SamplerState gSampler :register(s0);