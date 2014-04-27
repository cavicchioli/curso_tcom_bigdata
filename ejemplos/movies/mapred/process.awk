{ 
	if ($0) 
		printf "%s|", $0;
}

/review\/text/ { 
	print "\n";
}
