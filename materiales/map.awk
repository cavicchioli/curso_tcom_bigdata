#!/usr/bin/awk -f

BEGIN {
	FS = "|"; # field separator

	if (!pattern)
#		pattern = "Tom Cruise";
		pattern = "have";
}

{ 
	split($1, a, ": "); # product/productId
	productId = a[2];

	split($8, a, ": "); # review/text
	review = a[2];

	num = split($8, a, pattern) - 1; # extracts number of ocurrencies
	if (num > 0) 
		print productId "\t" num;
}
