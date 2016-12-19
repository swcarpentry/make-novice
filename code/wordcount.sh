# Ex.: ./wordcount.sh ../data/books/isles.txt isles.dat 10

inputfile=$1
outputfile=$2
min_count=$3

# Clean and normalize the input
cat $inputfile \
    | tr "[:punct:]" " " \
    | tr "[:upper:]" "[:lower:]" \
    > clean.txt

# Create a working temporary directory
mkdir tmp

# Total number of words
total=`wc -w clean.txt | awk '{print $1}'`

# Counts the occurence of each word
for word in `cat clean.txt`
    do echo '.' >> tmp/$word
done

# Collects the counting into one table and calculate the percentage
cd tmp
for word in `ls`
    do echo `wc -l $word` $total $min_count | \
    awk '$1>$4{print $1, $2, $1/$3*100}' >> db.txt
done

# Order the database, the most frequent word first
cat db.txt | sort -nr | awk '{print $2, $1, $3}' > ../$outputfile

# Clean the working directory
cd ../
rm -r tmp
