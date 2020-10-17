import common, vec3, utility, math

type camera* = object
    origin*: point
    lower_left_corner*: point
    horizontal*: vec3
    vertical*: vec3


proc init_cam*(cam: var camera, lookfrom: point, lookat: point, vup: vec3 , vfov: float, aspect_ratio: float) =
    var w = unit_vector(lookfrom - lookat)
    var u = unit_vector(cross(vup, w))
    var v = cross(w, u)
    var theta = deg_to_rad(vfov)
    var h = tan(theta/2)
    var viewport_height = 2.0 * h
    var viewport_width = viewport_height * aspect_ratio
    cam.origin = lookfrom
    cam.horizontal = viewport_width * u
    cam.vertical = viewport_height * v
    cam.lower_left_corner = cam.origin - cam.horizontal/2 - cam.vertical/2 - w

proc get_ray*(cam: camera, s: float, t: float): ray =
    return ray(origin: cam.origin, direction: cam.lower_left_corner + s*cam.horizontal + t*cam.vertical - cam.origin)


proc init_cam_angle*(cam: var camera, angle: float, radius: float, height: float, lookat: point, vup: vec3, vfov: float, aspect_ratio: float) =
    var x = radius * cos(angle)
    var y = height
    var z = radius * sin(angle)
    echo "x = ", x, " y = ", y, " z = ", z
    cam.init_cam((x, y, z), lookat, vup, vfov, aspect_ratio)