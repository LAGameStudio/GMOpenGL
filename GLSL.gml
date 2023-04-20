#macro GLSL global.glsl

#macro GLSL_sampler 0
#macro GLSL_f 1
#macro GLSL_f_array 2
#macro GLSL_i 3
#macro GLSL_i_array 4
#macro GLSL_mat 5
#macro GLSL_mat_array 6

#macro none -4

function Init_GLSL() {
	global.glsl = {
		list: [],
		supported: shaders_are_supported(),
		/* Example for uniforms:  [ ["u_Refract", GLSL_f], ["tex_NormalMap", GLSL_sampler] ] */
		Create: function ( shader_id, name, uniforms ) {
			var compiled=shader_is_compiled(shader_id);
			var len=array_length(uniforms);
			var types=[];
			var names=[];
			var params=[];
			for ( var i=0; i<len; i++ ) {
				names[i]=uniforms[i][0];
				types[i]=uniforms[i][1];
				if ( types[i] != GLSL_sampler )
				params[array_length(params)]=shader_get_uniform(shader_id,names[i]);
				else
				params[array_length(params)]=shader_get_sampler_index(shader_id,names[i]);
			}
			return {
				name: name,
				shader: shader_id,
				compiled: compiled,
				names: names,
				types: types,
				uniforms: params,
				fallback: none
			};
		},
		Add: function ( shader_id, uniforms ) {
			GLSL.list[array_length(GLSL.list)]=GLSL.Create(shader_id,uniforms);
			return GLSL.list[array_length(GLSL.list)-1];
		},
		Index: function ( name ) {
			var len=array_length(GLSL.list);
			for ( var i=0; i<len; i++ )	if ( GLSL.list[i].name == name ) return i;
			return none;
		},
		Get: function ( name ) {
			var len=array_length(GLSL.list);
			for ( var i=0; i<len; i++ )	if ( GLSL.list[i].name == name ) return GLSL.list[i];
			return none;
		},
		Enable: function ( shadero ) {
			shader_set(shadero.shader);
		},
		Set: function ( shadero, values ) {
			shader_set(shadero.shader);
			var len=array_length(values);
			for ( var i=0; i<len; i++ ) {
				switch ( shadero.types[i] ) {
					case GLSL_sampler:		texture_set_stage(shadero.uniforms[i],values[i]);			break;
					case GLSL_f:			shader_set_uniform_f(shadero.uniforms[i],values[i]);		break;
					case GLSL_f_array:		shader_set_uniform_f_array(shadero.uniforms[i],values[i]);	break;
					case GLSL_i:			shader_set_uniform_i(shadero.uniforms[i],values[i]);		break;
					case GLSL_i_array:		shader_set_uniform_i_array(shadero.uniforms[i],values[i]);	break;
					case GLSL_mat:			shader_set_uniform_matrix(shadero.uniforms[i]);		break;
					case GLSL_mat_array:	shader_set_uniform_matrix_array(shadero.uniforms[i],values[i]);	break;
					default: show_debug_message("Invalid type: "+string(shader.types[i]) );				break;
				}
			}
		},
		Disable: function () {
			shader_reset();
		}
	};
}