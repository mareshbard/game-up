shader_type canvas_item;

uniform sampler2D tela_fundo : hint_screen_texture, filter_linear_mipmap;

uniform float forca_desfoque : hint_range(0.0, 5.0) = 2.5;
uniform vec4 cor_escurecimento : source_color = vec4(0.0, 0.0, 0.0, 0.6);

void fragment() {
	vec4 imagem_borrada = textureLod(tela_fundo, SCREEN_UV, forca_desfoque);
	
	vec3 cor_final = mix(imagem_borrada.rgb, cor_escurecimento.rgb, cor_escurecimento.a);
	
	COLOR = vec4(cor_final, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
