function dist = distEclud(vec1,vec2)
    dist  = sum(power((vec1-vec2),2));
end