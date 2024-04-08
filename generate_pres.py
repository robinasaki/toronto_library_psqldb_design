import random

output = ""
table = 'SessionPresentations'
start = 1
end = 69*3

i = start
while i <= end:
# for i in range(start, end):
    accepted = [1,2,11] + list(range(28,34)) + list(range(53,60)) + list(range(66,69))
    
    for j in range(1, 4):
        decision = 't' if i in accepted else 'f'
        output += f"INSERT INTO {table} VALUES ({i}, {random.randint(1,8)}, {decision}, '', '');\n"
        i += 1

print(output)