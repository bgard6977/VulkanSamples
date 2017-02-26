/*
 * Copyright (c) 2015-2016 The Khronos Group Inc.
 * Copyright (c) 2015-2016 Valve Corporation
 * Copyright (c) 2015-2016 LunarG, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * Vertex shader used by Cube demo.
 */
#version 400
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable
layout(std140, binding = 0) uniform buf {
        mat4 MVP;
        vec4 position[12*3];
        vec4 attr[12*3];
} ubuf;

layout (location = 0) out vec4 texcoord;

out gl_PerVertex {
        vec4 gl_Position;
};

void main() 
{
   texcoord = ubuf.attr[gl_VertexIndex];
   vec4 vPosition = ubuf.position[gl_VertexIndex];
   // Offset by the instance ID to draw a 3D grid of cubes
   vec3 vOffset = vec3( gl_InstanceIndex % 10 - 5, gl_InstanceIndex / 100 - 5, ( gl_InstanceIndex / 10 ) % 10 - 5);
   // Add some spacing between the cubes
   vOffset *= 4.0f;
   vPosition.xyz += vOffset;
   gl_Position = ubuf.MVP * vPosition;
}