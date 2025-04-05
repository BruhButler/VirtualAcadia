shader_type spatial;
render_mode unshaded, fog_disabled;

uniform vec2 target_resolution = vec2(320.0, 180.0);
uniform float colors_per_channel : hint_range(1.0, 64.0, 1.0) = 8.0;

uniform float depth_outline_strength : hint_range(0.0, 1.0, 0.05) = 0.8;
uniform float normal_outline_strength : hint_range(0.0, 2.0, 0.05) = 0.5;

uniform vec3 outline_tint = vec3(0.0); // optional color tint
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform sampler2D depth_texture : hint_depth_texture, filter_nearest;
uniform sampler2D normal_texture : hint_normal_roughness_texture, filter_nearest;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

vec3 get_normal(vec2 uv) {
	return texture(normal_texture, uv).rgb;
}

float get_linear_depth(vec2 uv, mat4 inv_proj_mat) {
	float raw_depth = texture(depth_texture, uv).r;
	vec3 ndc = vec3(uv * 2.0 - 1.0, raw_depth);
	vec4 view = inv_proj_mat * vec4(ndc, 1.0);
	view.xyz /= view.w;
	return -view.z;
}

void fragment() {
	vec2 texel_size = 1.0 / target_resolution;
	vec2 uv = floor(SCREEN_UV * target_resolution) / target_resolution;

	vec2 offsets[4] = vec2[](
		vec2(0.0, texel_size.y), // Up
		vec2(0.0, -texel_size.y), // Down
		vec2(texel_size.x, 0.0), // Right
		vec2(-texel_size.x, 0.0) // Left
	);

	// Get center values
	float center_depth = get_linear_depth(uv, INV_PROJECTION_MATRIX);
	vec3 center_normal = get_normal(uv);

	float depth_edge = 0.0;
	float normal_edge = 0.0;

	for (int i = 0; i < 4; i++) {
		vec2 neighbor_uv = uv + offsets[i];

		// Depth edge detection
		float neighbor_depth = get_linear_depth(neighbor_uv, INV_PROJECTION_MATRIX);
		float depth_diff = max(0.0, neighbor_depth - center_depth);
		depth_edge += smoothstep(0.01, 0.1, depth_diff);

		// Normal edge detection
		vec3 neighbor_normal = get_normal(neighbor_uv);
		float normal_diff = distance(center_normal, neighbor_normal);
		// Weight by depth similarity (optional)
		float depth_similarity = 1.0 - abs(neighbor_depth - center_depth);
		normal_edge += smoothstep(0.1, 0.5, normal_diff * max(0.0, depth_similarity));
	}

	depth_edge = clamp(depth_edge, 0.0, 1.0) * depth_outline_strength;
	normal_edge = clamp(normal_edge, 0.0, 1.0) * normal_outline_strength;

	float edge_mask = 1.0 - clamp(depth_edge + normal_edge, 0.0, 1.0);

	vec3 color = texture(screen_texture, uv).rgb;
	vec3 quantized = floor(color * colors_per_channel) / colors_per_channel;

	vec3 final_color = quantized * edge_mask + outline_tint * (1.0 - edge_mask);
	ALBEDO = final_color;
}