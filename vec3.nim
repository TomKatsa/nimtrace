import math, utility, common



proc echo(v: vec3) = 
    echo "(", v.x, ",", v.y, ",", v.z, ")"


proc `-`* (v: vec3): vec3 = 
    return (-v.x, -v.y, -v.z)


proc `+=`* (v: var vec3, u: vec3) =
    v[0] += u[0]
    v[1] += u[1]
    v[2] += u[2]

proc `*=`* (v: var vec3, t: float) =
    v[0] *= t
    v[1] *= t
    v[2] *= t

proc `/=`* (v: var vec3, t: float) = 
    v *= 1/t


proc len_squared*(v: vec3): float =
    return (v[0].pow(2) + v[1].pow(2) + v[2].pow(2))


proc magnitude*(v: vec3): float =
    return sqrt(v.len_squared)

proc `+`* (v: vec3, u: vec3): vec3 = 
    return (v.x+u.x, v.y+u.y, v.z+u.z)

proc `-`* (v: vec3, u: vec3): vec3 = 
    return (v.x-u.x, v.y-u.y, v.z-u.z)

proc `*`* (v: vec3, u: vec3): vec3 = 
    return (v.x*u.x, v.y*u.y, v.z*u.z)

proc `*`* (v:vec3, t: float): vec3 = 
    return (v.x*t, v.y*t, v.z*t)

proc `*`* (t: float, v:vec3): vec3 =
    return v*t

proc `/`* (v:vec3, t: float): vec3 = 
    return v*(1/t)

proc dot* (v: vec3, u: vec3): float =
    return (v.x*u.x + v.y*u.y + v.z*u.z)

proc cross* (v: vec3, u: vec3): vec3 =
    return (v[1]*u[2] - v[2]*u[1],
            v[2]*u[0] - v[0]*u[2],
            v[0]*u[1] - v[1]*u[0])

proc unit_vector* (v:vec3): vec3 =
    return v / magnitude(v)

proc randomvec*: vec3 =
    var a = rand_range(0.0, 2*PI)
    var z = rand_range(-1.0, 1.0)
    var r = sqrt(1 - z*z)
    return (r*cos(a), r*sin(a), z)

proc refract*(uv: vec3, n: vec3, refraction_ratio: float): vec3 =
    var cos_theta = dot(-uv, n)
    var r_out_perp =  refraction_ratio * (uv + cos_theta*n)
    var r_out_parallel = -sqrt(abs(1.0 - r_out_perp.len_squared())) * n
    return r_out_perp + r_out_parallel

proc reflect* (v: vec3, n:vec3): vec3 =
    return (v - 2*dot(v,n)*n)


proc reflectance* (cosine: float, ref_idx: float): float =
            # Use Schlick's approximation for reflectance.
            var r0 = (1-ref_idx) / (1+ref_idx)
            r0 = r0*r0
            return r0 + (1-r0)*pow((1 - cosine),5)
        



#[
proc random_in_unit_sphere*: vec3 =
    var p: vec3 = randomvec()
    while p.len_squared >= 1:
        p = randomvec(-1.0, 1.0)
    return p
]#



proc test =
    var example: vec3 = (1.0, 2.0, 3.0)
    var ex: vec3 = (4.0, 0.0, 0.0)
    echo ex.dot(example)
    echo example.cross(ex)
    echo ex.unit_vector


#test()
