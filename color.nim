import common, math, utility


proc clamp(x: float, mini: float, maxi: float): float =
    if x < mini:
        return mini
    if x > maxi:
        return maxi
    return x


proc write_color*(fileobj: File, c: color, samples: int) =
    var scale: float = 1 / samples
    var x = sqrt(c.x * scale)
    var y = sqrt(c.y * scale)
    var z = sqrt(c.z * scale)
    var r = int(clamp(x, 0.0, 0.999)*256)
    var g = int(clamp(y, 0.0, 0.999)*256)
    var b = int(clamp(z, 0.0, 0.999)*256)
    fileobj.writeLine(r, ' ', g, ' ', b)

proc randcolor*: color =
    return (rand_float(), rand_float(), rand_float())

proc randcolor* (mini: float, maxi: float): color =
    return (rand_range(mini, maxi), rand_range(mini, maxi), rand_range(mini, maxi))