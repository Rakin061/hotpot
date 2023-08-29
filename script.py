import sys,json

print(sys.argv[1])
print(type(sys.argv[1]))

with (
  open("hotpot_train_v1.1.json","r") as file_data1, open("hotpot_dev_distractor_v1.json","r") as file_data2, open("hotpot_dev_fullwiki_v1.json","r") as file_data3  ):
  data1=json.load(file_data1)
  data2=json.load(file_data2)
  data3=json.load(file_data3)

json_data1=json_data2=json_data3 =[]
for i in range(sys.argv[1]):
    json_data1.append(data1[i])
    json_data2.append(data2[i])
    json_data3.append(data3[i])

json_object1 = json.dumps(json_data1, indent=4)
json_object2 = json.dumps(json_data2, indent=4)
json_object3 = json.dumps(json_data3, indent=4)

with open("sample_train.json", "w") as outfile1, open("sample_dev_distractor.json", "w") as outfile2,open("sample_dev_fullwiki.json", "w") as outfile3 :
    outfile1.write(json_object1)
    outfile2.write(json_object2)
    outfile3.write(json_object3)
