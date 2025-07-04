shader_type canvas_item;

uniform vec2 resolution = vec2(1.0);

uniform bool use_sprite_alpha = true;
uniform bool use_transition_texture = false;
uniform sampler2D transition_texture;
uniform int transition_type: hint_enum("Basic", "Mask", "Shape", "Clock") = 0;

group_uniforms positioning;
uniform bool invert = false;
uniform bool from_center = false;
uniform vec2 grid_size = vec2(1.0, 1.0);
uniform float rotation_angle = 0.0;

group_uniforms positioning.stagger;
uniform vec2 stagger = vec2(0.0, 0.0);
uniform ivec2 stagger_frequency = ivec2(2, 2);
uniform ivec2 flip_frequency = ivec2(1, 1);

group_uniforms basic_transition_controls;
uniform float gradient_width = 0.0;

group_uniforms mask_transition_controls;
uniform sampler2D mask_texture;
uniform vec2 mask_size;
group_uniforms shape_transition_controls;

uniform int edges : hint_range(3, 64) = 6; // default hexagon
uniform float feather : hint_range(0.0, 10.) = 0.1;

group_uniforms clock_transition_controls;
uniform int sectors : hint_range(1, 128) = 1;
uniform float clock_feather : hint_range(0, 16) = 0.0;
group_uniforms animation;
uniform float progress = 0.0;

uniform vec2 progress_bias = vec2(0.0);

vec2 use_actual_texture_size(vec2 uv, vec2 texture_size) {

	uv -= .5;
	vec2 uv_deriv = fwidth(uv);
	float screen_ratio = uv_deriv.x / uv_deriv.y;
	float texture_ratio = texture_size.x / texture_size.y;
	float mixed_ratio = texture_ratio * screen_ratio;

	if (screen_ratio > texture_ratio) {
		uv.x /= mixed_ratio;
	} else {
		uv.y *= mixed_ratio;
	}

	return uv + .5;
}

vec2 get_stagger_offset(vec2 grid) {
	// TODO: See if it makes sense to extend with stagger_base
	// (for cases in which one wants to start staggering from n-th row/col)
	vec2 cells = floor(grid);
	float offset_row = mod(cells.y, float(stagger_frequency.x)) == 0.0 ? 0.5 : 0.0;
	float offset_col = mod(cells.x, float(stagger_frequency.y)) == 0.0 ? 0.5 : 0.0;

	return vec2(
		offset_row * stagger.x,
		offset_col * stagger.y
	);
}

vec2 get_grid_flip(vec2 grid) {
	vec2 cells = floor(grid);
	float flip_row = mod(cells.y, float(flip_frequency.x)) == 0.0 ? 1.0 : -1.0;
	float flip_col = mod(cells.x, float(flip_frequency.y)) == 0.0 ? 1.0 : -1.0;

	return vec2(
		flip_row * grid.x,
		flip_col * grid.y
	);
}

vec2 rotate(vec2 v, float angle) {
	return mat2(
		vec2(cos(angle), sin(angle)),
		vec2(-sin(angle), cos(angle))
		) * v;
}

vec2 get_edges(float center, float width) {
	float half_width = width * 0.5;
	float edge0 = center - half_width;
	float edge1 = center + half_width + 1e-5;
	return vec2(edge0, edge1);
}

vec2 safe_inverse(vec2 v) {
	return vec2(
		v.x == 0.0 ? 0.0 : 1.0 / v.x,
		v.y == 0.0 ? 0.0 : 1.0 / v.y
	);
}

float get_local_progress(vec2 grid) {

	vec2 grid_coord = floor(grid);
	vec2 scaled_bias = progress_bias * safe_inverse(grid_size);
	// Using dot product just to multiply with each component of the bias
	float max_dist = dot(grid_size - vec2(1.0), abs(scaled_bias));
	float cell_offset = dot(grid_coord, scaled_bias) / max(1.0, max_dist);

	float local_progress = progress * (1. + max_dist) - cell_offset;
	return local_progress;
}

float get_transition() {
	return 0.0;
}

void fragment() {
	//vec2 base_uv = resolution != vec2(1.0) ? use_resolution(UV) : UV;

	vec2 grid = UV * grid_size;
	vec2 offset_uv = grid + get_stagger_offset(grid);
	vec2 grid_flipped_uv = get_grid_flip(offset_uv);
	vec2 tiled_uv = fract(grid_flipped_uv);
	vec2 uv = from_center ? 2. * tiled_uv - 1. : tiled_uv;
	uv = rotate(uv, radians(rotation_angle));

	float local_progress = get_local_progress(grid);

	COLOR = texture(TEXTURE, UV);
	float alpha = COLOR.a;

	if (transition_type == 1) {
		vec2 mask_zoom_uv = uv / local_progress;
		vec2 mask_zoom_uv_01 = mask_zoom_uv * 0.5 + 0.5;
		mask_zoom_uv_01 = use_actual_texture_size(mask_zoom_uv_01, mask_size);

		vec4 mask = texture(mask_texture, mask_zoom_uv_01);
		alpha = invert ? 1.0 - mask.r : mask.r;

	} else if(transition_type == 2) {
    	float radius = length(uv);
	    float angle = atan(uv.y, uv.x);
		float sector_angle = 2. * PI / float(edges);
		float half_sector = sector_angle / 2.0;
		// Define polygon sectors using the power of trigonometry
		float d = cos(half_sector) / cos(mod(angle + half_sector, sector_angle) - half_sector);

		vec2 smooth_edges = get_edges(local_progress, feather);
		float new_alpha = smoothstep(smooth_edges.x, smooth_edges.y, radius / d);

	    alpha = invert ? 1.0 - new_alpha : new_alpha;
		//COLOR = vec4(vec3(polygon), 1.0);
	} else if (transition_type == 3) {
	float radius = length(uv);
	float angle = atan(uv.y, uv.x);
	float sector_angle = 2. * PI / float(sectors);
	float half_sector = sector_angle / 2.0;
	angle = mod(angle - half_sector, sector_angle);

	float progress_angle = local_progress * 2.0 * PI / float(sectors);
	float smooth_angle = smoothstep(0.0, clock_feather, progress_angle - angle);
	float a = invert ? 1.0 - smooth_angle : smooth_angle;


	alpha = a;
	} else {
		vec2 smooth_edges = get_edges(local_progress, gradient_width);

		float separation_x = smoothstep(smooth_edges.x, smooth_edges.y, abs(uv.x));
		float separation_y = smoothstep(smooth_edges.x, smooth_edges.y, abs(uv.y));
		float sep = max(separation_x, separation_y);
		sep = invert ? 1. - sep : sep;

		alpha = sep;
	}

	alpha = use_sprite_alpha ? min(COLOR.a, alpha) : alpha;

	vec4 transition_color = texture(transition_texture, UV);

	if (use_transition_texture) {
		vec4 chosen_color = mix(COLOR, transition_color, alpha);
		COLOR = chosen_color;
	} else {
		COLOR.a *= alpha;
	}
}
