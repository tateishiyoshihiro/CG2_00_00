struct PixelShaderOutput {
	float32_t4 color:
};
PixelShaderOutput main() {
	pixelShaderOutput output;
	output.color = float32_t4(1.0, 1.0, 1.0, 1.0);
	return output;
}