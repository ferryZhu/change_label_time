function jointDate() {
    #获取当前时间
    date=`date '+%Y-%m-%d %H:%M:%S'`
    #拼接字符串
    time=${1}":$date"
    echo $time
    #查找ViewController.m文件并且替换含有dateLabel.text =的字串
    find . -name "*****.m" -exec sed -i "" "/testLabel.text = /s@.*@    testLabel.text = \@\"$time\"\;@g" {} \;
}

#查找Url.h文件中 包含KURLBase的字符串
file=`find . -name "*Url.h" -exec grep "kURLBase" {} \;`
#逐个读出
echo "$file" | while read i
do
    if [[ $i =~ '//#' ]]
then
    if [[ $i =~ 'uats' ]]
then
    jointDate "生产环境"
else
    jointDate "测试环境"
fi
    break
fi
done
