# ./plotcount.sh isles.dat

inputfile=$1

if [ ! -z $2 ]
then
    limit=$2
else
    limit=10
fi

screenwidth=80
gap=2

wordlist=`head -n $limit $inputfile | awk '{print $1}'`
longestword=`for word in $wordlist; do echo $word | wc -c; done | sort -r | head -n 1`
max=`head -n 1 $inputfile | awk '{print $2}'`

scale=$((screenwidth - gap - longestword))


head -n $limit $inputfile | \
    while read line
        do
            word=`echo $line | awk '{print $1}'`
	    rank=`echo $line | awk -v max=$max -v scale=$scale '{print scale*$2/max}'`
	    wlen=`echo $word | wc -c`
	    extra=$((longestword + gap - wlen))
	    bar=$word
	    for i in `seq 1 $extra`
                do bar+='.'
            done
	    for i in `seq 1 $rank`
                do bar+='#'
            done
	    echo $bar | tr "." " "
        done
