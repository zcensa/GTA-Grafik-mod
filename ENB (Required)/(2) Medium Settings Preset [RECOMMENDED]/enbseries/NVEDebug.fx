float DigitBin(int x)
{
	return x == 0 ? 480599.0 : x == 1 ? 139810.0 : x == 2 ? 476951.0 : x == 3 ? 476999.0 : x == 4 ? 350020.0 : x == 5 ? 464711.0 : x == 6 ? 464727.0 : x == 7 ? 476228.0 : x == 8 ? 481111.0 : x == 9 ? 481095.0 : 0.0;
}

float PrintValue(float2 vStringCoords, float fValue, float fMaxDigits, float fDecimalPlaces)
{

	if ((vStringCoords.y < 0.0) || (vStringCoords.y >= 1.0)) return 0.0;
	//  if (vStringCoords.y < 0.0) vStringCoords.y = 1.0;
	vStringCoords.y = 1.0 - vStringCoords.y;
	bool bNeg = (fValue < 0.0);
	fValue = abs(fValue);

	float fLog10Value = log2(abs(fValue)) / log2(10.0);
	float fBiggestIndex = max(floor(fLog10Value), 0.0);
	float fDigitIndex = fMaxDigits - floor(vStringCoords.x);
	float fCharBin = 0.0;
	if (fDigitIndex > (-fDecimalPlaces - 1.01)) {
		if (fDigitIndex > fBiggestIndex) {
			if ((bNeg) && (fDigitIndex < (fBiggestIndex + 1.5))) fCharBin = 1792.0;
		}
		else {
			if (fDigitIndex == -1.0) {
				if (fDecimalPlaces > 0.0) fCharBin = 2.0;
			}
			else {
				float fReducedRangeValue = fValue;
				if (fDigitIndex < 0.0) { fReducedRangeValue = frac(fValue); fDigitIndex += 1.0; }
				float fDigitValue = (abs(fReducedRangeValue / (pow(10.0, fDigitIndex))));
				fCharBin = DigitBin(int(floor(fmod(fDigitValue, 10.0))));
			}
		}
	}
	return floor(fmod((fCharBin / pow(2.0, floor(frac(vStringCoords.x) * 4.0) + (floor(vStringCoords.y * 5.0) * 4.0))), 2.0));
}

float PrintValue2(float2 theUV, float2 thePosition, float theValue)
{
	float2 vFontSize = float2(16.0, 32.0);
	float fDigits = 2.0;
	float fDecimalPlaces = 4.0;
	float fIsDigit2 = PrintValue(((theUV * ScreenSize.x) - thePosition) / vFontSize, theValue, fDigits, fDecimalPlaces);
	return fIsDigit2;
}


// example usage
//	r0.xyz = lerp(r0.xyz, float3(0, 1, 1), PrintValue2(IN.txcoord0.xy, float2(1000, 50), GradientFilterColBottom.x));
//