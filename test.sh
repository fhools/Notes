a=yo
yo=bee

echo $a
echo \$$a
arr[0]=yo
arr[1]=me
host=(a b c)
echo ${!host[@]}
echo ${host[@]}
echo ${arr[@]}