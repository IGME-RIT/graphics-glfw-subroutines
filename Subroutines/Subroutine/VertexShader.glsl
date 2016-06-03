/*
Title: Shader Subroutines
File Name: VertexShader.glsl
Copyright © 2015
Original authors: Srinivasan T
Written under the supervision of David I. Schwartz, Ph.D., and
supported by a professional development seed grant from the B. Thomas
Golisano College of Computing & Information Sciences
(https://www.rit.edu/gccis) at the Rochester Institute of Technology.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Description:
In GLSL, a subroutine is a mechanism for binding a function call to one of a set of possible
function definitions based on the value of a variable. In many ways it is similar to function
pointers in C. A uniform variable serves as the pointer and is used to invoke the function.
The value of this variable can be set from the OpenGL side, thereby binding it to one of a few
possible definitions. The subroutine's function definitions need not have the same name, but
must have the same number and type of parameters and the same return type.

In this program, we draw two spheres and light them different using the same shaders using
subroutines.

References:
OpenGL 4 shading language cookbook by David Wolff
*/

#version 400 core // Identifies the version of the shader, this line must be on a separate line from the rest of the shader code
 
layout(location = 0) in vec3 in_position;	// Get in a vec3 for position
layout(location = 1) in vec4 in_color;		// Get in a vec4 for color
layout(location = 2) in vec3 in_normal;

out vec4 color; // Our vec4 color variable containing r, g, b, a

uniform mat4 MVP; // Our uniform MVP matrix to modify our position values
uniform vec3 camPos; // camera position for specular lighting.

vec3 LightPos;
vec3 DiffuseLight;
vec3 SpecularLight;

//Declaring the subroutine.
//This means that the subroutine function will return a vec4 and take 2 parameters of vec3 type.
subroutine vec4 shadeModelType (vec3 position, vec3 normal);

//Create an uniform variable of this type.
//here shadeModel will acts as funciton pointer.
subroutine uniform shadeModelType shadeModel;

//This function returns the component of the light reflected as diffuse texture.
vec3 diffuseComponent(vec3 position, vec3 normal)
{
	vec3 s = normalize(LightPos - position);

	return DiffuseLight * max(dot(s, normal),0.0f);
}

//This function deals with the light reflected due to specular behaviour
vec3 specularComponent(vec3 position, vec3 normal)
{
	vec3 s = normalize(LightPos - position);
	vec3 r = (2 * dot(s,normal) * normal) - s;
	vec3 v = normalize(camPos - position);
	
	return SpecularLight * max(pow(dot(v,r),3),0.0f);
}

//We define two functions, both in sync with the compatibility of the subroutine
//thus we declare the two functions to be a part of the subroutine
subroutine (shadeModelType) vec4 diffuseAndSpecular (vec3 position, vec3 normal)
{
	return vec4(in_color.xyz * (diffuseComponent(position,normal) + specularComponent(position, normal)),in_color.w);
}

subroutine (shadeModelType) vec4 diffuseOnly (vec3 position, vec3 normal)
{
	return vec4(in_color.xyz * diffuseComponent(position, normal), in_color.w);
}

void main(void)
{
	LightPos = vec3(3.0f, 3.0f,3.0f);
	DiffuseLight = vec3 (0.5f,0.5f,0.5f);
	SpecularLight = vec3(0.74f,0.74f,0.74f);
	
	//Call the funciton using the subroutine uniform which is set in the openGL application.
	color = shadeModel (in_position, normalize(in_normal));
	gl_Position = MVP * vec4(in_position, 1.0); //w is 1.0, also notice cast to a vec4
}