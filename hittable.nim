import vec3, common



method hit* (this: hittable, r: ray, t_min: float, t_max: float, rec: var hit_record): bool {.base.} =
    quit "not implemented abstract class"


proc set_face_normal* (rec: var hit_record, r: ray, out_normal: vec3) =
    rec.front_face = dot(r.direction, out_normal) < 0
    if rec.front_face:
        rec.normal = out_normal
    else:
        rec.normal = -out_normal



method hit* (hittable_list: seq[hittable], r: ray, t_min: float, t_max: float, rec: var hit_record): bool {.base.} =
    var temp_rec: hit_record
    var hit_anything = false
    var closest = t_max
    for h in hittable_list:
        if h.hit(r, t_min, closest, temp_rec):
            hit_anything = true
            closest = temp_rec.t
            rec = temp_rec
    return hit_anything


