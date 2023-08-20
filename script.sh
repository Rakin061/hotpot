#!/bin/sh

nvidia-smi 2>&1 | tee -a output.txt

git clone https://github.com/Rakin061/hotpot.git 2>&1 | tee -a output.txt

while getopts "a:b:" flag;	do
	case "${flag}" in 
		a) filename=${OPTARG} 
			;; 
		b) size=${OPTARG} 
			;; 
	esac 
done 

echo "Dataset: $filename"; 
echo "Size: $size";

if [ "${filename}" = "small" ]
then 
	train_file="sample_train.json"
	dev_distractor="sample_dev_distractor.json"
	dev_fullwiki="sample_dev_fullwiki.json"
else 
	train_file="hotpot_train_v1.1.json"
	dev_distractor="hotpot_dev_distractor_v1.json"
	dev_fullwiki="hotpot_dev_fullwiki_v1.json"
fi 

echo $train_file,$dev_distractor,$dev_fullwiki

echo -e "\n\n#### Ouput for preprocess -- train ######## \n\n" 2>&1 | tee -a output.txt
python main.py --mode prepro --data_file "$train_file" --para_limit 2250 --data_split train 2>&1 | tee -a output.txt

echo -e "\n\n#### Ouput for preprocess -- dev_distractor ######## \n\n" 2>&1 | tee -a output.txt
python main.py --mode prepro --data_file "$dev_distractor" --para_limit 2250 --data_split dev 2>&1 | tee -a output.txt

echo -e "\n\n#### Ouput for preprocess -- dev_fullwiki ######## \n\n" 2>&1 | tee -a output.txt
python main.py --mode prepro --data_file "$dev_fullwiki" --data_split dev --fullwiki --para_limit 2250 2>&1 | tee -a output.txt

echo -e "\n\n#### Training Model ######## \n\n" 2>&1 | tee -a output.txt
python main.py --mode train --para_limit 2250 --batch_size 24 --init_lr 0.1 --keep_prob 1.0 --sp_lambda 1.0 2>&1 | tee -a output.txt

for dir in HOTPOT*; do dir_name="$dir"; done
echo $dir_name