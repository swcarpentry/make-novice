# Ex.: ./wordcount.sh ../data/books/isles.txt isles.dat 10

inputfile=$1
outputfile=$2
min_count=$3

# Clean and normalize the input, one word per line, sorted.
cat $inputfile \
    | tr "[:punct:]" " " \
    | tr "[:upper:]" "[:lower:]" \
    | tr -cs "[:alpha:]" "\n" \
    | sort -o clean.txt

# Total number of words
total=`wc -w clean.txt | awk '{print $1}'`

# Be sure to don't reuse tmp.txt
rm -f tmp.txt

# Counts the occurence of each word.
count=0
word=`head -n 1 clean.txt`
for item in `cat clean.txt`
    do if [ $word = $item ]
        then count=$((count + 1))
    else
        if [ $count -ge $min_count ]
	    then echo $count $word >> tmp.txt
        fi
	word=$item
	count=1
    fi
done

# Order output by most frequent word first, and include the percentage.
cat tmp.txt \
    | sort -nr \
    | awk -v total=$total '{print $2, $1, $1/total*100}' \
    > $outputfile

rm clean.txt tmp.txt
