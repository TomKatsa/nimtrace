import vec3, math, common

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
        