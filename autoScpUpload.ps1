$fileName = 'notes'
$path = 'C:\Users\rhexa\Desktop'
$filePath = "$path\$fileName.txt"
$ssh = "alpine@192.168.85.14:~/Projects"

$command = "scp $filePath $ssh"

#Create tmp dir
if (ls "$path\tmp"){
    echo "tmp\ exists"
}
else {
    echo "tmp\ Not Found"
    mkdir "$path\tmp"
    echo "tmp\ created"
}
$hashFile = "$path\tmp\$fileName.md5" 
$hashTmp = "$path\tmp\$fileName.tmp"

#Create md5 hash
if (ls "$hashFile") {
    echo "MD5 exists"
    
}
else {
    (Get-FileHash $filePath -Algorithm MD5).Hash > $hashFile
    echo "MD5 created"
}

#Create .tmp hash
(Get-FileHash $filePath -Algorithm MD5).Hash > $hashTmp
echo "$hashTmp created"

#Diff hashes
if ("$(cat $hashFile)" -eq "$(cat $hashTmp)")
{
    echo "$(cat $hashFile)"
    echo "$(cat $hashTmp)"
    echo "Hashes matched"
}
else
{
    $command
    (Get-FileHash $filePath -Algorithm MD5).Hash > $hashFile
    echo "MD5 updated"
} 