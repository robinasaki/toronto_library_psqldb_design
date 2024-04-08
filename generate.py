import random

output = ""
table = 'Reviews'
start = 1
end = 69*3

i = start
current = 1
while i <= end:
# for i in range(start, end):
    accepted = [1,2,11] + list(range(28,34)) + list(range(53,60)) + list(range(66,69))
    
    for j in range(1, 4):
        decision = 't' if current in accepted else 'f'
        output += f"INSERT INTO {table} VALUES ({i}, {random.randint(1,8)}, {current}, {decision}, '', '');\n"
        i += 1
    current += 1

print(output)