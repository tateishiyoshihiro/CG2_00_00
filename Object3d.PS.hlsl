#include "Object3d.hlsli"
struct Material
{
    float1x4 color;
    int32_t enableLighting;
    float32_t shininess;
};
struct DirectionalLight
{
    float32_t4 color; //åıÇÃêF
    float32_t3 direction; //åıÇÃå¸Ç´
    float intensity; //ãPìx
};
struct Camera
{
    float32_t3 worldPosition;
};

ConstantBuffer<Material> gMaterial : register(b0);
ConstantBuffer<DirectionalLight> gDirectionalLight : register(b1);
ConstantBuffer<Camera> gCamera : register(b2);
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
    float32_t3 toEye = normalize(gCamera.worldPosition - input.worldPosition);
    float32_t3 reflectLight = reflect(gDirectionalLight.direction, normalize(input.normal));
    //half lambert
    float NdotL = dot(normalize(input.normal), normalize(-gDirectionalLight.direction));
    float cos = pow(NdotL * 0.5f + 0.5f, 2.0f);
    
    float RdotE = dot(reflectLight, toEye);
    float specularPow = pow(saturate(RdotE), gMaterial.shininess);//îΩéÀã≠ìx
    //ägéUîΩéÀ
    float32_t3 diffuse = gMaterial.color.rgb * texturColor.rgb * gDirectionalLight.color.rgb * cos * gDirectionalLight.intensity;
    //ãæñ îΩéÀ
    float32_t3 specular = gDirectionalLight.color.rgb * gDirectionalLight.intensity * specularPow * float32_t3(1.0f, 1.0f, 1.0f);
    //ägéUîΩéÀ+ãæñ îΩéÀ
    output.color.rgb = diffuse + specular;
    //ÉAÉãÉtÉ@ÇÕç°Ç‹Ç≈í ÇË
    output.color.a = gMaterial.color.a * texturColor.a;
    
    if (gMaterial.enableLighting != 0)
    {
        float cos = saturate(dot(normalize(input.normal), -gDirectionalLight.direction));
        output.color = gMaterial.color * texturColor * gDirectionalLight.color * cos * gDirectionalLight.intensity;
    }
    else
    {
         output.color = gMaterial.color * texturColor;
    }
    output.color.a = 1.0f;
   
        return output;
    }