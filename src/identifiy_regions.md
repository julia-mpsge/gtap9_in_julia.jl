# Comparing Data

The data in the following sections compares the GTAP regions the G20 aggregation to the non-balanced consumers in my MPSGE.jl model. Notice the only sectors that are the result of an aggregation are the ones that are not balanced.


GTAP 20 Regions

	ARG	Argentina
	ANZ	Australia and New Zealand
	BRA	Brazil
	CAN	Canada
	CHN	China and Hong Kong
	FRA	France
	DEU	Germany
	IND	India
	IDN	Indonesia
	ITA	Italy
	JPN	Japan
	MEX	Mexico
	RUS	Russia
	SAU	Saudi Arabia
	ZAF	South Africa
	KOR	Korea
	TUR	Turkey
	GBR	United Kingdom
	USA	United States
	REU	Rest of European Union (excluding FRA - DEU - GBR - ITA)
	OEX	Other oil exporters
	LIC	Other low-income countries
	MIC	Other middle-income countries

My regions

1 │ RA[reu]    3009.27   -2228.31
2 │ P[c,mic]      1.0     -912.613
3 │ RA[chn]    3904.95    -160.363
4 │ RA[oex]    1121.76     -54.8874
5 │ RA[anz]     259.941    -35.5725
6 │ RA[lic]     855.497    -22.7221

Included Regions

| My regions | GTAP regions |
|------------|--------------|
| reu        | Rest of European Union (excluding FRA - DEU - GBR - ITA) |
| mic        | Other middle-income countries |
| chn        | China and Hong Kong |
| oex        | Other oil exporters |
| anz        | Australia and New Zealand |
| lic        | Other low-income countries |

Excluded Regions

	ARG	Argentina
	BRA	Brazil
	CAN	Canada
	FRA	France
	DEU	Germany
	IND	India
	IDN	Indonesia
	ITA	Italy
	JPN	Japan
	MEX	Mexico
	RUS	Russia
	SAU	Saudi Arabia
	ZAF	South Africa
	KOR	Korea
	TUR	Turkey
	GBR	United Kingdom
	USA	United States