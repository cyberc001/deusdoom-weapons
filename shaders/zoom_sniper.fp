void main()
{
	FragColor = texture(InputTexture, TexCoord);
	vec2 texc = TexCoord.st;
	texc -= vec2(0.5, 0.5);
	texc.x *= 4.1;
	texc.y *= 4.1 / aspect_ratio;
	if(dot(texc, texc) > 0.25)
		FragColor = vec4(0, 0, 0, 0);
}