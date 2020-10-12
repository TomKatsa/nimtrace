import vec3, common



type lambertian* = ref object of material
    albedo*: color

type metal* = ref object of material
    albedo*: color
    fuzz*: float


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