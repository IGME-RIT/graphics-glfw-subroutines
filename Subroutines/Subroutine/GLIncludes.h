/*
Title: Shader Subroutines
File Name: GLIncludes.h
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

#ifndef _GL_INCLUDES_H
#define _GL_INCLUDES_H

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include "glew\glew.h"
#include "glfw\glfw3.h"
#include "glm\glm.hpp"
#include "glm\gtc\matrix_transform.hpp"
#include "glm\gtc\type_ptr.hpp"
#include "glm\gtc\quaternion.hpp"
#include "glm\gtx\quaternion.hpp"

#define PI 3.147f

// We create a VertexFormat struct, which defines how the data passed into the shader code wil be formatted
struct VertexFormat
{
	glm::vec4 color;	// A vector4 for color has 4 floats: red, green, blue, and alpha
	glm::vec3 position;	// A vector3 for position has 3 float: x, y, and z coordinates
	glm::vec3 normal;	// Vertex Normal

	// Default constructor
	VertexFormat()
	{
		color = glm::vec4(0.0f);
		position = glm::vec3(0.0f);
		normal = glm::vec3(0);
	}

	// Constructor
	VertexFormat(const glm::vec3 &pos, const glm::vec4 &iColor, const glm::vec3 &norm)
	{
		position = pos;
		color = iColor;
		normal = norm;
	}
};

#endif _GL_INCLUDES_H