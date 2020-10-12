import math, random

proc deg_to_rad* (deg: float): float =
    return (deg * PI / 180.0)


proc rand_range* (mini: float, maxi: float): float =
    return (mini + (maxi-mini)*rand(1.0))