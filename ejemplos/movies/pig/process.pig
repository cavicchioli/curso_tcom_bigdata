%declare FILE '/ejemplos/movies/movies-lines2000.txt';
%declare PATTERN 'tom cruise';

raw_movies = LOAD '$FILE' USING PigStorage('|') AS (
	productId: chararray, 
	userId: chararray, 
	profileName: chararray, 
	helpfulness: chararray, 
	score: chararray, 
	time: chararray, 
	summary: chararray, 
	text: chararray);

filtered_movies = FILTER raw_movies BY productId != '';

raw_regex_movies = FOREACH filtered_movies GENERATE 
	REPLACE(productId, 'product/productId: ', ''),
	FLATTEN(STRSPLIT(LOWER(text), '$PATTERN'));

regex_movies = FOREACH raw_regex_movies GENERATE
	$0 AS productId,
	COUNT(TOBAG(*)) - 2 AS num; -- Remove productId and first ocurrence

grouped_movies = GROUP regex_movies BY productId;

result = FOREACH grouped_movies GENERATE group, SUM(regex_movies.num);

DUMP result;
