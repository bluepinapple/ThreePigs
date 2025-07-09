shader_type canvas_item;

// 定义两个纹理
uniform sampler2D texture1;
uniform sampler2D texture2;
// 控制过渡的参数 (0.0 ~ 1.0)
uniform float a : hint_range(0.0, 1.0) = 0.0;
uniform float alpha : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    // 获取当前 UV 坐标（0~1 范围）
    vec2 uv = UV;

    // 计算当前像素相对于中心的方向角度（0~2π）
    vec2 center = vec2(0.5, 0.5); // Sprite2D 中心
    vec2 dir = uv - center;
    float angle = atan(dir.y, dir.x); // 计算角度（-π ~ π）
    angle = (angle + 3.14159265359) / (2.0 * 3.14159265359); // 归一化到 0~1

    // 计算当前角度是否在 a 控制的扇形范围内
    float threshold = a;
    float angle_mask = step(angle, threshold); // 如果 angle <= threshold，返回 1，否则 0

    // 混合两个纹理
    vec4 color1 = texture(texture1, uv);
    vec4 color2 = texture(texture2, uv);
    COLOR = mix(color1, color2, angle_mask);
	COLOR.a *= alpha;
}