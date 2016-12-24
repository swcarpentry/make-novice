# ./plotcount.sh isles.dat

inputfile=$1

if [ ! -z $2 ]
then
    limit=$2
else
    limit=10
fi

max=`head -n 1 $inputfile | awk '{print $2}'`

head $inputfile -n $limit | \
    while read line
        do
            word=`echo $line | awk '{print $1}'`
	    rank=`echo $line | awk -v max=$max '{print 70*$2/max}'`
	    bar=''
	    for i in `seq 1 $rank`
                do bar+='#'
            done
	    echo $word $bar
        done
