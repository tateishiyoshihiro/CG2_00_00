struct TransfomationMatrix{
    float32_t4x4 WVP;
};

ConstantBuffer<TransfomationMatrix>gTransformationMatrix : register(b0);
struct VertexShaderOutput {
	float32_t4 position : SV_POSITION;
};

VertexShaderOutput main(VertexShaderInput input) {
	VertexShaderOutput output;
	output.position = mul(input.position,gTransformationMatrix.WVP);
	
	return output;
}