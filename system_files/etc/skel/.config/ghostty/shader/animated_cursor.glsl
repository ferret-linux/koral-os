// -- CONFIGURATION ---
vec4 CURSOR_COLOR = iCurrentCursorColor;
const float DURATION = 0.18;
const float BLUR = 2.0;

// How much bigger the X jump must be than the Y jump to be treated as
// a "line change" (snap, no stretch) instead of a same-line move (stretch).
const float LINE_CHANGE_RATIO = 1.5;

float ease(float x) {
    return 1.0 - pow(1.0 - x, 5.0);
}

float getSdfRectangle(in vec2 point, in vec2 center, in vec2 halfSize)
{
    vec2 d = abs(point - center) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(BLUR, BLUR), 0.).x, distance);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord){
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);
    vec2 centerCP = previousCursor.xy - (previousCursor.zw * offsetFactor);

    vec2 prevMin = centerCP - previousCursor.zw * 0.5;
    vec2 prevMax = centerCP + previousCursor.zw * 0.5;
    vec2 currMin = centerCC - currentCursor.zw * 0.5;
    vec2 currMax = centerCC + currentCursor.zw * 0.5;

    // Did the row change? If Y moved meaningfully more than a rounding error,
    // treat this as a line change and skip the stretch entirely — just snap.
    float rowChanged = step(0.0001, abs(centerCC.y - centerCP.y));

    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float t = mix(ease(progress), 1.0, rowChanged); // rowChanged=1 -> t=1 always -> instant snap

    vec2 dir = sign(centerCC - centerCP);

    vec2 rectMin, rectMax;

    if (dir.x > 0.0) {
        rectMax.x = currMax.x;
        rectMin.x = mix(prevMin.x, currMin.x, t);
    } else if (dir.x < 0.0) {
        rectMin.x = currMin.x;
        rectMax.x = mix(prevMax.x, currMax.x, t);
    } else {
        rectMin.x = currMin.x;
        rectMax.x = currMax.x;
    }

    if (dir.y > 0.0) {
        rectMax.y = currMax.y;
        rectMin.y = mix(prevMin.y, currMin.y, t);
    } else if (dir.y < 0.0) {
        rectMin.y = currMin.y;
        rectMax.y = mix(prevMax.y, currMax.y, t);
    } else {
        rectMin.y = currMin.y;
        rectMax.y = currMax.y;
    }

    vec2 center = (rectMin + rectMax) * 0.5;
    vec2 halfSize = (rectMax - rectMin) * 0.5;

    float sdfCursor = getSdfRectangle(vu, center, halfSize);
    float alpha = antialising(sdfCursor);

    fragColor = mix(fragColor, CURSOR_COLOR, alpha);
}