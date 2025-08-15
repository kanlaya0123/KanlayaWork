#!/bin/bash

StudentName(){
clear
read -p "Please Enter Student Name : " NAME
}

Head(){
clear
echo "__________________________________"
echo "   WELCOME TO GRADE CALCULATOR"
echo "   $NAME"  
echo "   $SUBJECT_NAME"
echo "__________________________________"
}

Select_Subject(){
find ./conf/ -type f |cut -d'/' -f3 |cut -d'.' -f1 |cat -n
read -p "Please Enter Program : " CHOICE
}

Find_SubjectNamePath(){
        SUBJECT_NAME=$(find ./conf/ -type f | sed -n ${CHOICE}p |cut -d'/' -f3 |cut -d'.' -f1)
        SUBJECT_PATH=$(find ./conf/ -type f | sed -n ${CHOICE}p)
}

Score(){
        i=1
        COUNT=5
        while (( i <= COUNT ));do
                read -p "Enter your score for Program $i : " SCORE
                if [[ "$SCORE" =~ ^[0-9]+$ ]] && (( $SCORE >= 0 && $SCORE <= 100)); then
                Calculate_Score 
                echo "grade calculating...."
                ((i++))
                else
                echo "Please enter a score in the range [1-100]"
                fi
        done
}

Calculate_Score(){
        while IFS='-:' read MIN_SCORE MAX_SCORE GRADE_CHAR; do
#       echo $MIN_SCORE $MAX_SCORE $GRADE_CHAR

#       if [[ $MIN_SCORE =~ ^# ]]; then
#                continue
#        fi
#        MIN_SCORE=$(echo "$MINMAX_GRADE" |cut -d '-' -f1)
#        MAX_SCORE=$(echo "$MINMAX_GRADE" |cut -d '-' -f2 | cut -d ':' -f1)
#        GRADE_CHAR=$(echo "$MINMAX_GRADE" | cut -d ':' -f2)
        
        if (( "$SCORE" >= $MIN_SCORE && $SCORE <= $MAX_SCORE )); then
                GRADE=$GRADE_CHAR
                GRADE_RESULT[$i]="Grade Result of Program $i Score $SCORE : $GRADE"

                if [[ "$GRADE" == "A" ]]; then
                        GRADE_VALUE=4
                elif [[ "$GRADE" == "B" ]]; then
                        GRADE_VALUE=3
                elif [[ "$GRADE" == "C" ]]; then
                        GRADE_VALUE=2
                elif [[ "$GRADE" == "D" ]]; then
                        GRADE_VALUE=1
                elif [[ "$GRADE" == "F" ]]; then
                        GRADE_VALUE=0
                fi
                SUM_GRADE=$((SUM_GRADE+GRADE_VALUE))
                break
        fi
done <<< "$(grep -v '#' ${SUBJECT_PATH})"
}
Result(){
        echo '+++++++++++++++++++++++++++++++++++++++++++'
        echo "  REPORT OF $NAME"
        echo "  CROUSE NAME : $SUBJECT_NAME"
        echo '+++++++++++++++++++++++++++++++++++++++++++'

        printf '%s\n' "${GRADE_RESULT[@]}"
        GPA=$(echo "scale=2; $SUM_GRADE / $COUNT" | bc )
        echo "GPA : $GPA"
#       printf "GPA : %.2f\n" "$GPA"
}

###---- Start Program ----###
#page 1 
StudentName
#page 2 
Head
Select_Subject
Find_SubjectNamePath
#page 3
Head
Score
#page 4
Head
Result
