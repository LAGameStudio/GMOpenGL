#macro FBOs global.fbo

function Init_FBO(){
 global.fbo = {
	 list: [],
	 Create: function ( w, h ) {
		 var fbo=surface_create(w,h);
		 return {
			 fbo: fbo,
			 w: w,
			 h: h,
			 clear: c_black,
			 alpha: 0.0
		 };
	 },
	 Exists: function ( fboo ) { return surface_exists(fboo.fbo); },
	 Destroy: function ( fboo ) { surface_free(fboo.fbo); },
	 Enable: function ( fboo ) { 
		 if ( !surface_exists(fboo.fbo) ) fboo.fbo = surface_create(fboo.w,fboo.h);
		 surface_set_target(fboo.fbo);
	 },
	 Texture: function ( fboo ) { return surface_get_texture(fboo.fbo); },
	 GetPixel: function ( fboo, dx, dy ) { return surface_getpixel(fboo.fbo,dx,dy); },
	 Disable: function ( fboo ) { surface_reset_target(); },
	 Copy: function ( from, to ) { surface_copy( to.fbo, 0,0, from.fbo ); },
	 CopyTo: function ( from, to, dx, dy ) { surface_copy( to.fbo, dx,dy, from.fbo ); },
	 CopyPart: function ( from, xs, ys, ws, wh, to, dx, dy ) { surface_copy_part( to, dx, dy, from, xs, ys, ws, hs ); },
	 Draw: function ( fboo, dx, dy ) { draw_surface(fboo.fbo,dx,dy); },
	 Draw2: function ( fboo, dx, dy, dw, dh, angle, c,a ) { draw_surface_ext(fboo.fbo,dx,dy,dw/fboo.w,dh/fboo.h,angle,c,a); },
	 DrawPart: function ( fboo, sx, sy, sw, sh, dx, dy ) { draw_surface_part(fboo.fbo,sx,sy,sw,sh,dx,dy); },
	 DrawPart2: function ( fboo, sx, sy, sw, sh, dx, dy, dw, dh, c, a ) { draw_surface_part_ext(fboo.fbo,sx,sy,sw,sh, dx, dy, dw/sw, dh/sh, c,a ); },
	 Stretch: function( fboo, dx, dy, w, h ) { draw_surface_stretched(fboo.fbo,dx,dy,w,h); },
	 Stretch2: function( fboo, c,a, dx, dy, w, h ) { draw_surface_stretched_ext(fboo.fbo,dx,dy,w,h,c,a); },
	 Stretch3: function ( fboo, sx,sy,sw,sh, dx,dy,dw,dh, angle, c1,c2,c3,c4, a ) {
		 draw_surface_general( fboo.fbo, sx,sy,sw,sh, dx,dy,dw/sw,dh/sh, angle, c1,c2,c3,c4, a );
	 },
	 Tiled: function ( fboo, dx, dy ) { draw_surface_tiled(fboo.fbo,dx,dy); },
	 Tiled2: function ( fboo, dx, dy, dw, dh, c,a ) { draw_surface_tiled_ext( fboo.fbo, dx,dy, dw/fboo.w, dh/fboo.h, c,a); }
 };
}