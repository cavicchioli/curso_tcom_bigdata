#!/usr/bin/awk -f

{ 
	tmpkey = $1;
	value += $2;

	if (tmpkey != key) {
		if (key)
			print key "\tINSERT INTO mitabla(value) VALUES(" value ")";

		key = tmpkey;
		value = 0;
	} 
}
