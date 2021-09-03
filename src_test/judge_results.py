diff = 0.0
eps = 0.0001
answer_file = 'answer.txt'
result_file = 'result.txt'
answer_list = []
result_list = []
with open(answer_file,"r") as ans_file:
    for i in ans_file:
        answer_list.append(float(i.rstrip('\n')))
with open(result_file,"r") as rsl_file:
    for j in rsl_file:
        result_list.append(float(j.rstrip('\n')))

for i in range(len(answer_list)):
    diff = (answer_list[i] - result_list[i]) ** 2

if diff < eps:
    print("OK")
else:
    print("NG")
