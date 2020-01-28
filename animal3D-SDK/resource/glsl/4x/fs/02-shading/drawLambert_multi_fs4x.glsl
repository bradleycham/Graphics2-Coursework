/*
	Copyright 2011-2020 Daniel S. Buckstein

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

/*
	animal3D SDK: Minimal 3D Animation Framework
	By Daniel S. Buckstein
	
	drawLambert_multi_fs4x.glsl
	Draw Lambert shading model for multiple lights.
*/

#version 410

// ****TO-DO: 
//	1) declare uniform variable for texture; see demo code for hints
uniform sampler2D uTex_dm;
//	2) declare uniform variables for lights; see demo code for hints
uniform float uLightCt;
uniform vec4 uLightSz;
uniform vec4 uLightSzInvSq;
uniform vec4 uLightPos;
uniform vec4 uLightCol;
uniform vec4 uColor;
//	3) declare inbound varying data
in vec4 vTexCoord;
in vec4 vNormal;
in vec4 vViewPosition;
//	4) implement Lambert shading model
//	Note: test all data and inbound values before using them!

out vec4 rtFragColor;

void main()
{
	vec4 lightDir = normalize(uLightPos - vViewPosition);
	float diffusal = max(dot(vNormal, lightDir), 0.0);
	float aDistance = distance(uLightCol, vTexCoord);
	float ambientLight = 0.5;
	// DUMMY OUTPUT: all fragments are OPAQUE RED
	//texture(uTex_dm, vTexCoord.xy)
	rtFragColor =  texture(uTex_dm, vTexCoord.xy) * uLightCol * (ambientLight + diffusal) / (aDistance * aDistance);
	// i have no god damn idea how to access different lights values.
}
