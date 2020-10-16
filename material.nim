import vec3, common



type lambertian* = ref object of material
    albedo*: color

type metal* = ref object of material
    albedo*: color
    fuzz*: float

type dielectric* = ref object of material
    refraction_index*: float




method scatter*(m: material, r: ray, rec: hit_record, attenuation: var color, scattered: var ray): bool {.base.} =
    quit "material is an abstract class"

method scatter*(lam: lambertian, r: ray, rec: hit_record, attenuation: var color, scattered: var ray): bool =
    var scatter_direction: point = rec.normal + randomvec()
    scattered = ray(origin: rec.p, direction: scatter_direction)
    attenuation = lam.albedo
    return true

method scatter*(met: metal, r: ray, rec: hit_record, attenuation: var color, scattered: var ray): bool =
    var reflected = reflect(unit_vector(r.direction), rec.normal)
    scattered = ray(origin: rec.p, direction: reflected + met.fuzz*randomvec())
    attenuation = met.albedo
    return (dot(scattered.direction, rec.normal) > 0)

method scatter*(de: dielectric, r:ray, rec: hit_record, attenuation: var color, scattered: var ray): bool =
    attenuation = (1.0, 1.0, 1.0)
    var refraction_ratio: float
    if rec.front_face:
        refraction_ratio = (1.0 / de.refraction_index)
    else:
        refraction_ratio = de.refraction_index
    var unit_direction: vec3 = unit_vector(r.direction)
    var refracted: vec3 = refract(unit_direction, rec.normal, refraction_ratio)
    scattered = ray(origin: rec.p, direction: refracted)
    return true
    
